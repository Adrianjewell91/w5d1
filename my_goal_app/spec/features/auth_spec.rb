require "spec_helper"
require "rails_helper"

feature "the sign up process" do
  scenario "has a new user" do
    visit new_user_path
    expect(page).to have_content 'Sign In'
  end

  scenario "has the correct information listed" do
    visit new_user_path
    expect(page).to have_content 'Email'
    expect(page).to have_content 'Password'
  end

  feature "logging in a user" do
    scenario "shows username(email) on the home page after sign up" do
      sign_up('adrian@adrian.com')
      expect(page).to have_content "Welcome adrian@adrian.com"
    end

    scenario "has a sign out button" do
     sign_up('adrian@adrian.com')
     expect(page).to have_button "Sign Out"
    end
  end

  #Want to test for the existence of a dropdown or radio

end

feature "the log in process" do
  scenario "shows the username(email) on the home page after login" do
    user = 'adrian.com'
    User.create(email: user, password: '123456')
    sign_in(user)
    # save_and_open_page
    expect(page).to have_content "Welcome #{user}"
  end

end

feature "the log out process" do
  scenario "begins with a logged out state" do
    #how do I test this?
    #when going to the website, the default is
    #to logout and out go to new
    visit root_path
    expect(page).to have_content 'Sign In'
  end

  scenario "doesn't show username after logging out" do
    sign_up('adrian')
    click_button 'Sign Out'
    expect(page).not_to have_content "Welcome"
  end
end
