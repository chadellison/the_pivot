require "rails_helper"

RSpec.feature "User can edit their profile" do
  scenario "user selects 'edit profile' on their dashboard" do
    user = User.create(username: "Susan", password: "password", password_confirmation: "password", email: "susan@gmail.com")
    user.roles.create(name: "customer")
    ApplicationController.any_instance.stubs(:current_user).returns(user)

    visit(dashboard_path(user))
    click_on "Edit Profile"
    within(".edit_user") do
      fill_in "Username", with: "Fred"
      fill_in "Email", with: "fred@gmail.com"
      fill_in "Password", with: "pass2"
      fill_in "Password confirmation", with: "pass2"
      click_on "Edit Account"
    end

    expect(current_path).to eq(dashboard_path(user.id))
    expect(page).to have_content("Success! Your account updated.")
    expect(page).to have_content("Welcome to Your Dashboard, Fred")
    user = User.first
    expect(user.username).to eq("Fred")
    expect(user.email).to eq("fred@gmail.com")
  end

  scenario "user selects 'edit profile' on their dashboard" do
    user = User.create(username: "Susan", password: "password", password_confirmation: "password", email: "susan@gmail.com")
    user.roles.create(name: "customer")
    ApplicationController.any_instance.stubs(:current_user).returns(user)

    visit(dashboard_path(user))
    click_on "Edit Profile"
    within(".edit_user") do
      fill_in "Username", with: ""
      fill_in "Email", with: "fred@gmail.com"
      fill_in "Password", with: "pass2"
      fill_in "Password confirmation", with: "pass2"
      click_on "Edit Account"
    end

    expect(current_path).to eq("/users/edit")
    expect(page).to have_content("Your account could not be updated. Please check your input and try again")
    user = User.first
    expect(user.username).to eq("Susan")
    expect(user.email).to eq("susan@gmail.com")
  end
end
