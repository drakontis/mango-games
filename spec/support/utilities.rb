# def login
#   # Capybara case
#   visit login_path(:kumquat => true)
#   click_link 'Google Problem? Login with Username/Password'
#   fill_in "email", :visible => false, with: 'root@pamediakopes.gr' # visible => false for capybara when running without javascript
#   fill_in "password", :visible => false, with: "root"              # visible => false for capybara when running without javascript
#   click_button "Login with Kumquat", :visible => false             # visible => false for capybara when running without javascript
# end
#
# def logout
#   # Capybara case
#   click_link_or_button "Logout"
# end

def login_without_capybara
  new_person = User.find_by_username('Root')
  # no Capybara case
  @controller.session[:user_id] = new_person.id unless @controller.nil? || @controller.session.nil?
end

def logout_without_capybara
  # no Capybara case
  #cookies[:remember_token] = nil
  @controller.session[:user_id] = nil unless @controller.nil? || @controller.session.nil?
end


