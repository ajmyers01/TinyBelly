require 'test_helper'

class LinksControllerTest < ActionController::TestCase

  def setup
    @user = users(:one)
    @link = links(:one)

    login(@user)
    request.env['HTTP_AUTHORIZATION'] = "Bearer #{@token}"
  end
  
  test "index" do 
    get :index

    json_response = JSON.parse(response.body)
    assert_equal json_response["links"][0]["id"], @link.id
  end

  test "create with slug" do 
    post "create", 
    params: {  
        original_url: "www.alexmyers.net", 
        slug: "SupaDupa", 
    }

    json_response = JSON.parse(response.body)
    assert_equal json_response["link"]["original_url"], "www.alexmyers.net" 
    assert_equal json_response["link"]["slug"], "SupaDupa" 
    assert_equal Link.last.original_url, "www.alexmyers.net" 
    assert_equal Link.last.slug, "SupaDupa" 
  end

  test "create without slug" do 
    post "create", 
    params: {  
        original_url: "www.alexmyers.net", 
    }

    json_response = JSON.parse(response.body)
    assert_equal json_response["link"]["original_url"], "www.alexmyers.net" 
    assert_equal Link.last.original_url, "www.alexmyers.net" 
    assert Link.last.slug.present? 
  end

  test "Successful Redirect" do 
    get "show",
    params: {slug: "resume"}
    assert_redirected_to "www.alexmyers.net"
  end

  test "Non-Successful Redirect" do 
    get "show",
    params: {slug: "where"}
    json_response = JSON.parse(response.body)
    assert_equal json_response["message"], "No Link Found"
  end
end