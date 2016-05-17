require "rails_helper"

RSpec.feature "User can login" do
  scenario "user successfully logs in" do
    user = User.create(username: "Susan", password: "password", password_confirmation: "password", email: "susan@gmail.com")
    user.roles.create(name: "customer")

    visit root_path
    click_on("Login")
    fill_in("session[username]", with: "Susan")
    fill_in("session[password]", with: "password")
    click_on("Sign In")

    expect(page).to have_content("Log Out")
    expect(page).not_to have_content("Login")
  end

  scenario "user unsuccessfully logs in" do
    user = User.create(username: "Susan", password: "password", password_confirmation: "password", email: "susan@gmail.com")
    user.roles.create(name: "customer")

    visit root_path
    click_on("Login")
    fill_in("session[username]", with: "Susan")
    fill_in("session[password]", with: "pass")
    click_on("Sign In")

    expect(page).to have_content("Incorrect email/password combination.")
    expect(page).to have_button("Sign In")
    expect(page).to have_content("Login")
    expect(page).not_to have_content("Log Out")
  end
end
