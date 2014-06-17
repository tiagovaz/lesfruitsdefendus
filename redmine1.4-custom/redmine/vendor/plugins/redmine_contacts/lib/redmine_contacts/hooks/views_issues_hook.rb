module RedmineContacts
  module Hooks
    class ViewsIssuesHook < Redmine::Hook::ViewListener     
      require "contacts_helper"

      render_on :view_issues_sidebar_planning_bottom, :partial => "issues/contacts", :locals => {:contact_issue => @issue}  

      def view_issues_index_bottom(context={})
        stylesheet_link_tag :contacts, :plugin => 'redmine_contacts'
      end

    end   
  end
end
