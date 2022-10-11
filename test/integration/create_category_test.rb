require "test_helper"

class CreateCategoryTest < ActionDispatch::IntegrationTest
   test "get new category form and create category" do
     get '/categories/new'
     assert_response :success

     assert_difference 'Category.count', 1 do
       post categories_path, params: { category: { name: 'Sports'}}
       assert_response :redirect # make sure that there is a redirect
     end

     follow_redirect! # to follow redirect
     assert_response :success
     # we are going to look for a name in the body of HTML page
     assert_match 'Sports', response.body
   end

   test "get new category form and reject invalid category submission" do
     get '/categories/new'
     assert_response :success

     assert_no_difference 'Category.count'  do
       post categories_path, params: { category: { name: ' '}}
     end

     # looking for word 'errors in h1'
     assert_match 'errors', response.body
     # testing for existence of html elements
     assert_select 'div.alert', 'Categories#index'
     assert_select 'h1.errs_heading', 'Categories#index'
   end
end
