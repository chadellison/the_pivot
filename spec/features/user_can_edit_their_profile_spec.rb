require "rails_helper"

RSpec.feature "User can edit their profile" do
  scenario "user selects 'edit profile' on their dashboard" do
    user = User.create(username: "Susan", password: "password", password_confirmation: "password", email: "susan@gmail.com")
    user.roles.create(name: "customer")

    visit root_path
    click_on "Login"
    fill_in "Username", with: "Susan"
    fill_in "Password", with: "password"
    click_on "Sign In"

    click_on "Edit Profile"
    # save_and_open_page
    # byebug

    expect(current_path).to eq("/users/edit")
    fill_in "Username", with: "Fred"
    fill_in "Email", with: "fred@gmail.com"
    fill_in "Password", with: "pass2"
    fill_in "Password confirmation", with: "pass2"
    click_on "Edit Account"

    expect(current_path).to eq(dashboard_path(user.id))
    expect(page).to have_content("Success! Your account updated.")
    expect(page).to have_content("Welcome to Your Dashboard, Fred")
    user = User.first
    expect(user.username).to eq("Fred")
    expect(user.email).to eq("fred@gmail.com")
  end
end
