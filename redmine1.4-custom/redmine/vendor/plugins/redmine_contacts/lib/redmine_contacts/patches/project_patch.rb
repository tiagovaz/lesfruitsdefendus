module RedmineContacts
  module Patches
    module ProjectPatch
      def self.included(base) # :nodoc: 
        base.class_eval do    
          unloadable # Send unloadable so it will not be unloaded in development
          has_and_belongs_to_many :contacts, :order => "contacts.last_name, contacts.first_name", :uniq => true  
          has_many :deals, :dependent => :delete_all 
          has_many :deal_categories, :dependent => :delete_all, :order => "#{DealCategory.table_name}.name"  
          has_and_belongs_to_many :deal_statuses, :order => "#{DealStatus.table_name}.position", :uniq => true  
        end  
      end  
    end
  end
end

Dispatcher.to_prepare do  

  unless Project.included_modules.include?(RedmineContacts::Patches::ProjectPatch)
    Project.send(:include, RedmineContacts::Patches::ProjectPatch)
  end
end
