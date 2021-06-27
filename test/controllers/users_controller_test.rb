require 'test_helper'

class UsersControllerTest < ActionController::TestCase
  def setup
    @user = users(:one)
  end
  
  test "create" do 
    post "create", 
    params: {  
        email: "unique@gmail.com", 
        password: "tester1", 
        password_confirmation: "tester1"
    }

    json_response = JSON.parse(response.body)

    # This can be done better.
    # I should test content not just prescence.
    assert json_response["token"].present? 
    assert_equal json_response["user"]["id"], User.last.id
  end

  test "bad create" do 
    post "create", 
    params: {  
        email: "unique@gmail.com", 
        password: "tester", 
        password_confirmation: "tester1"
    }

    json_response = JSON.parse(response.body)
    assert_equal json_response["error"], "Invalid username or password"
  end
  
  test "login" do 
    post "login", 
    params: {  
        email: @user.email, 
        password: "Password1!", 
    }

    json_response = JSON.parse(response.body)

    assert json_response["token"].present? 
    assert_equal json_response["user"]["id"], User.last.id
  end

  test "bad login" do 
    post "login", 
    params: {  
        email: @user.email, 
        password: "WrongPassword!", 
    }

    json_response = JSON.parse(response.body)

    assert_equal json_response["error"], "Invalid email or password"
  end
end