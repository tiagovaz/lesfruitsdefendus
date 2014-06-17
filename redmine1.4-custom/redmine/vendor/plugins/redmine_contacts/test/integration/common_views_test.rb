require File.dirname(__FILE__) + '/../test_helper'  
require File.dirname(__FILE__) + '/../../../../../test/test_helper' 

class CommonViewsTest < ActionController::IntegrationTest

  def setup
    RedmineContacts::TestCase.prepare

    @request    = ActionController::TestRequest.new
    @response   = ActionController::TestResponse.new
    @request.env['HTTP_REFERER'] = '/'
  end  
  
  test "View user" do
    log_user("rhill", "foo")
    get "/users/2"
    assert_response :success
  end  
  
  test "View contacts activity" do
    log_user("admin", "admin")    
    get "/projects/ecookbook/activity?show_contacts=1"
    assert_response :success
  end
  
  test "View contacts settings" do
    log_user("admin", "admin")    
    get "/settings/plugin/contacts"
    assert_response :success
  end 
  
  test "View contacts project settings" do
    log_user("admin", "admin")    
    get "/projects/ecookbook/settings/contacts"
    assert_response :success
  end

  test "View contacts project tasks list" do
    log_user("admin", "admin")    
    get "/projects/ecookbook/contacts/tasks"
    assert_response :success
  end 

  test "View contacts tasks list" do
    log_user("admin", "admin")    
    get "/contacts/tasks"
    assert_response :success
  end 

  test "Global search with contacts" do
    log_user("admin", "admin")    
    get "/search?q=Domoway"
    assert_response :success
  end 

  test "View contacts project notes list" do
    log_user("admin", "admin")    
    get "/projects/ecookbook/contacts/notes"
    assert_response :success
  end 

  test "View contacts notes list" do
    log_user("admin", "admin")    
    get "contacts/notes"
    assert_response :success
  end 

  test "View user with contact relation" do
    log_user("admin", "admin")    
    get "/users/2"
    assert_response :success
    # assert_tag :div,
    #   :content => /John Smith/,
    #   :attributes => { :class => 'contact card' }
  end 
  
end
