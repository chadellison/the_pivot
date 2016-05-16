require "rails_helper"

RSpec.feature "User can logout" do
  scenario "user logs out after they've logged in" do
    user = User.create(username: "Susan", password: "password", password_confirmation: "password", email: "susan@gmail.com")
    user.roles.create(name: "customer")

    visit root_path
    click_on("Login")
    fill_in("session[username]", with: "Susan")
    fill_in("session[password]", with: "password")
    click_on("Sign In")
    expect(page).to have_content("Log Out")
    expect(page).not_to have_content("Login")
    click_on("Log Out")

    expect(page).to have_content("Login")
  end
end
