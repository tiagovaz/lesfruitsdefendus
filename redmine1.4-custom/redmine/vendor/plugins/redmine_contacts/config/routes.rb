#custom routes for this plugin
ActionController::Routing::Routes.draw do |map|

  map.resources :contacts,
                :collection => {:bulk_edit => [:get, :post], 
                                :bulk_update => :post, 
                                :bulk_destroy => :delete, 
                                :context_menu => :get,
                                :preview_email => :get,
                                :edit_mails => :get,
                                :send_mails => :post,
                                :contacts_notes => :get},
                :path_names => {:contacts_notes => 'notes'}
  
  map.resources :projects do |project|
    project.resources :contacts,
                      :collection => {:contacts_notes => :get},
                      :path_names => {:contacts_notes => 'notes'} 
  end
  
  map.resources :deals,
                :collection => {:bulk_edit => [:get, :post], 
                                :bulk_update => :post, 
                                :bulk_destroy => :delete, 
                                :context_menu => :get,
                                :preview_email => :get,
                                :edit_mails => :get,
                                :send_mails => :post}
  
  map.resources :projects do |project|
    project.resources :deals, :only => [:new, :create, :index]
  end

  map.resources :projects do |project|
    project.resources :contacts_queries, :only => [:new, :create]
  end  

  map.resources :contacts_queries, :except => [:show]

  map.with_options :controller => 'contacts_tasks' do |contacts_issues_routes|  
    contacts_issues_routes.connect "projects/:project_id/contacts/tasks", :action => 'index' 
    contacts_issues_routes.connect "projects/:project_id/contacts/:contact_id/new_task", :conditions => { :method => :post }, :action => 'new' 
    contacts_issues_routes.connect "contacts/tasks", :action => 'index'
  end

  map.with_options :controller => 'contacts_duplicates' do |contacts_issues_routes|  
    contacts_issues_routes.connect "contacts/:contact_id/duplicates"
  end
  
  map.with_options :controller => 'deal_categories' do |categories|
    categories.connect 'projects/:project_id/deal_categories/new', :action => 'new'
  end

  map.with_options :controller => 'sale_funel' do |sale_funel|
    sale_funel.connect 'projects/:project_id/sale_funel', :action => 'index'
    sale_funel.connect 'sale_funel', :action => 'index'
    sale_funel.connect "sale_funel/:action"
  end

  map.with_options :controller => 'notes' do |notes_routes|
    notes_routes.connect "notes/:note_id", :conditions => { :method => :get }, :action => 'show', :note_id => /\d+/
    notes_routes.connect "notes/show/:note_id", :conditions => { :method => :get }, :action => 'show', :note_id => /\d+/
    notes_routes.connect "notes/:note_id/edit", :conditions => { :method => :get }, :action => 'edit', :note_id => /\d+/
    notes_routes.connect "notes/:note_id/update", :conditions => { :method => :post }, :action => 'update', :note_id => /\d+/
    notes_routes.connect "notes/:note_id/destroy_note", :action => 'destroy_note', :note_id => /\d+/
    notes_routes.connect "notes/add_note", :action => 'add_note'
    notes_routes.connect "notes/destroy", :action => 'destroy'
  end
  
  map.connect "users/new_from_contact", :controller => "users", :action => 'new_from_contact'
  map.connect "auto_completes/contact_tags", :controller => "auto_completes", :action => 'contact_tags'
  map.connect "contacts_duplicates/:action", :controller => "contacts_duplicates"
  map.connect "contacts_projects/:action", :controller => "contacts_projects"
  map.connect "contacts_tags/:action", :controller => "contacts_tags"
  map.connect "contacts_tasks/:action", :controller => "contacts_tasks"
  map.connect "tasks/:action", :controller => "tasks"
  map.connect "contacts_vcf/:action", :controller => "contacts_vcf"
  map.connect "contacts_csv/:action", :controller => "contacts_csv"
  map.connect "deal_categories/:action", :controller => "deal_categories"
  map.connect "deal_contacts/:action", :controller => "deal_contacts"
  map.connect "deal_statuses/:action", :controller => "deal_statuses"
  map.connect "deals_tasks/:action", :controller => "deals_tasks"
  map.connect "contacts_settings/:action", :controller => "contacts_settings"
  map.connect "contacts_mailer/:action", :controller => "contacts_mailer"
  map.connect "deals_tasks/:action", :controller => "deals_tasks"
  map.connect "attachments/thumbnail", :controller => "attachments", :action => 'thumbnail'
    
end
