# Redmine CRM plugin

require 'redmine'  
require 'redmine_contacts'
VERSION_NUMBER = '2.3.4'
VERSION_STATUS = ''
  
Redmine::Plugin.register :contacts do
  name 'Redmine CRM plugin'
  author 'RedmineCRM'
  description 'This is a CRM plugin for Redmine that can be used to track contacts and deals information'
  version VERSION_NUMBER + '-light' + VERSION_STATUS
  url 'http://redminecrm.com'
  author_url 'mailto:kirbez@redminecrm.com'

  requires_redmine :version_or_higher => '1.2.2'   
  
  settings :default => {
    :use_gravatars => false, 
    :name_format => :lastname_firstname.to_s,
    :auto_thumbnails  => true,
    :contact_list_default_columns => ["first_name", "last_name"],
    :max_thumbnail_file_size => 300
  }, :partial => 'settings/contacts'
  
  project_module :contacts_module do
    permission :view_contacts, { 
      :contacts => [:show, :index, :live_search, :contacts_notes, :context_menu],
      :contacts_tasks => :index, 
      :notes => [:show]
    }

    permission :add_contacts, {
      :contacts => [:new, :create],
      :contacts_vcf => [:load]
    }
    permission :edit_contacts, { 
      :contacts => [:edit, :update],
      :notes => [:add_note, :destroy, :edit, :update],
      :contacts_tasks => [:new, :add, :delete, :close],
      :contacts_duplicates => [:index, :merge, :duplicates],
      :contacts_projects => [:add, :delete],
      :contacts_vcf => [:load]
    }
    permission :delete_contacts, :contacts => [:destroy, :bulk_destroy]
    permission :add_notes, :notes => [:add_note]
    permission :delete_notes, :notes => [:destroy, :edit, :update]
    permission :delete_own_notes, :notes => [:destroy, :edit, :update]
    permission :manage_contacts, { 
      :projects => :settings, 
      :contacts_settings => :save, 
      :deal_categories => [:new, :edit, :destroy], 
      :deal_statuses => [:assing_to_project], :require => :member
    }

  end

  menu :project_menu, :contacts, {:controller => 'contacts', :action => 'index'}, :caption => :contacts_title, :param => :project_id
  menu :application_menu, :contacts, 
                          {:controller => 'contacts', :action => 'index'}, 
                          :caption => :label_contact_plural, 
                          :param => :project_id, 
                          :if => Proc.new{User.current.allowed_to?({:controller => 'contacts', :action => 'index'}, 
                                          nil, {:global => true}) && RedmineContacts.settings[:show_in_app_menu]}
  
  menu :top_menu, :contacts, {:controller => 'contacts', :action => 'index'}, :caption => :contacts_title, :if => Proc.new {
    User.current.allowed_to?({:controller => 'contacts', :action => 'index'}, nil, {:global => true})
  }  
  
  menu :admin_menu, :contacts, {:controller => 'settings', :action => 'plugin', :id => "contacts"}, :caption => :contacts_title, :param => :project_id
  
  activity_provider :contacts, :default => false, :class_name => ['ContactNote'] 

  Redmine::Search.map do |search|
    search.register :contacts
    search.register :contact_notes
  end
 
end

