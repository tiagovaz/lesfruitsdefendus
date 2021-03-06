# Patches active_support/core_ext/load_error.rb to support 1.9.3 LoadError message
if RUBY_VERSION >= '1.9.3'
  MissingSourceFile::REGEXPS << [/^cannot load such file -- (.+)$/i, 1] 
end

require 'active_record'

require 'active_record/connection_adapters/abstract_adapter'
module ActiveRecord
  module ConnectionAdapters
    class MysqlAdapter < AbstractAdapter
      def create_table(table_name, options = {}) #:nodoc:
        encoding = @config[:encoding]
        if encoding
          options = options.reverse_merge(:options => "DEFAULT CHARSET=#{encoding}")
        end
        super(table_name, options.reverse_merge(:options => "ENGINE=InnoDB"))
      end
    end
  end
end


module ActiveRecord
  class Base
    include Redmine::I18n

    # Translate attribute names for validation errors display
    def self.human_attribute_name(attr, *args)
      l("field_#{attr.to_s.gsub(/_id$/, '')}", :default => attr)
    end
  end
end

module ActionView
  module Helpers
    module DateHelper
      # distance_of_time_in_words breaks when difference is greater than 30 years
      def distance_of_date_in_words(from_date, to_date = 0, options = {})
        from_date = from_date.to_date if from_date.respond_to?(:to_date)
        to_date = to_date.to_date if to_date.respond_to?(:to_date)
        distance_in_days = (to_date - from_date).abs

        I18n.with_options :locale => options[:locale], :scope => :'datetime.distance_in_words' do |locale|
          case distance_in_days
            when 0..60     then locale.t :x_days,             :count => distance_in_days.round
            when 61..720   then locale.t :about_x_months,     :count => (distance_in_days / 30).round
            else                locale.t :over_x_years,       :count => (distance_in_days / 365).floor
          end
        end
      end
    end
  end
end

ActionView::Base.field_error_proc = Proc.new{ |html_tag, instance| "#{html_tag}" }

module AsynchronousMailer
  # Adds :async_smtp and :async_sendmail delivery methods
  # to perform email deliveries asynchronously
  %w(smtp sendmail).each do |type|
    define_method("perform_delivery_async_#{type}") do |mail|
      Thread.start do
        send "perform_delivery_#{type}", mail
      end
    end
  end

  # Adds a delivery method that writes emails in tmp/emails for testing purpose
  def perform_delivery_tmp_file(mail)
    dest_dir = File.join(Rails.root, 'tmp', 'emails')
    Dir.mkdir(dest_dir) unless File.directory?(dest_dir)
    File.open(File.join(dest_dir, mail.message_id.gsub(/[<>]/, '') + '.eml'), 'wb') {|f| f.write(mail.encoded) }
  end
end

ActionMailer::Base.send :include, AsynchronousMailer

module TMail
  # TMail::Unquoter.convert_to_with_fallback_on_iso_8859_1 introduced in TMail 1.2.7
  # triggers a test failure in test_add_issue_with_japanese_keywords(MailHandlerTest)
  class Unquoter
    class << self
      alias_method :convert_to, :convert_to_without_fallback_on_iso_8859_1
    end
  end

  # Patch for TMail 1.2.7. See http://www.redmine.org/issues/8751
  class Encoder
    def puts_meta(str)
      add_text str
    end
  end
end

module ActionController
  module MimeResponds
    class Responder
      def api(&block)
        any(:xml, :json, &block)
      end
    end
  end

  # CVE-2012-2660
  # https://groups.google.com/group/rubyonrails-security/browse_thread/thread/f1203e3376acec0f
  # CVE-2012-2694
  # https://groups.google.com/group/rubyonrails-security/browse_thread/thread/8c82d9df8b401c5e
  class Request
    protected

    # Remove nils from the params hash
    def deep_munge(hash)
      keys = hash.keys.find_all { |k| hash[k] == [nil] }
      keys.each { |k| hash[k] = nil }

      hash.each_value do |v|
        case v
        when Array
          v.grep(Hash) { |x| deep_munge(x) }
          v.compact!
        when Hash
          deep_munge(v)
        end
      end
      hash
    end

    def parse_query(qs)
      deep_munge(super)
    end
  end
end

# CVE-2012-2695
# https://groups.google.com/group/rubyonrails-security/browse_thread/thread/9782f44c4540cf59
module ActiveRecord
  class Base
    class << self
      def sanitize_sql_hash_for_conditions(attrs, default_table_name = quoted_table_name, top_level = true)
        attrs = expand_hash_conditions_for_aggregates(attrs)

        conditions = attrs.map do |attr, value|
          table_name = default_table_name

          if not value.is_a?(Hash)
            attr = attr.to_s

            # Extract table name from qualified attribute names.
            if attr.include?('.') and top_level
              attr_table_name, attr = attr.split('.', 2)
              attr_table_name = connection.quote_table_name(attr_table_name)
            else
              attr_table_name = table_name
            end

            attribute_condition("#{attr_table_name}.#{connection.quote_column_name(attr)}", value)
          elsif top_level
            sanitize_sql_hash_for_conditions(value, connection.quote_table_name(attr.to_s), false)
          else
            raise ActiveRecord::StatementInvalid
          end
        end.join(' AND ')

        replace_bind_variables(conditions, expand_range_bind_variables(attrs.values))
      end
      alias_method :sanitize_sql_hash, :sanitize_sql_hash_for_conditions
    end
  end
end

# the session store
ActionController::Base.session_options[:tmpdir] = File.join(ENV['RAILS_VAR'], 'sessions') unless !ENV['RAILS_VAR']
