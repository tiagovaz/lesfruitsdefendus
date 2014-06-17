require File.dirname(__FILE__) + '/../test_helper'

class ContactsQueryTest < ActiveSupport::TestCase
  fixtures :projects, :enabled_modules, :users, :members,
           :member_roles, :roles, :trackers, :issue_statuses,
           :issue_categories, :enumerations, :issues,
           :watchers, :custom_fields, :custom_values, :versions,
           :contacts_queries,
           :projects_trackers


  def test_project_filter_in_global_queries
    query = ContactsQuery.new(:project => nil, :name => '_')
    tags_filter = query.available_filters["tags"]
    assert_not_nil tags_filter
    tag_ids = tags_filter[:values].map{|p| p[1]}
    assert tag_ids.include?("main")  #public project
    # assert !tag_ids.include?("test") #private project user cannot see
  end

  def find_contacts_with_query(query)
    Contact.find :all,
      :include => [ :projects, :notes ],
      :conditions => query.statement
  end

  def assert_find_contacts_with_query_is_successful(query)
    assert_nothing_raised do
      find_contacts_with_query(query)
    end
  end

  def assert_query_statement_includes(query, condition)
    assert query.statement.include?(condition), "Query statement condition not found in: #{query.statement}"
  end
  
  def assert_query_result(expected, query)
    assert_nothing_raised do
      assert_equal expected.map(&:id).sort, query.issues.map(&:id).sort
      assert_equal expected.size, query.issue_count
    end
  end


end

