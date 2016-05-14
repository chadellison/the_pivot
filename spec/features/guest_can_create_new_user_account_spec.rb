require 'rails_helper'

RSpec.feature "guest can create a new user account" do
  scenario "guest selects create account and fills in their information" do
    original_user_count = User.count

    visit users_path

    expect(current_path).to eq(users_path)
    expect(page).to have_content("Please Create an Account")
    expect(page).to have_field("Username")
    expect(page).to have_field("Email")
    expect(page).to have_field("Password")

    fill_in "Username", with: "JoeSmith"
    fill_in "Email", with: "j1@gmail.com"
    fill_in "Password", with: "password"
    fill_in "Password confirmation", with: "password"

    click_on "Create Account"

    expect(current_path).to eq(login_path)
    expect(page).to have_content("Success! Your account was created!.")
    expect(User.count).to eq(original_user_count + 1)
  end

  scenario "guest trys to create account without username" do
    original_user_count = User.count

    visit users_path

    expect(current_path).to eq(users_path)

    fill_in "Email", with: "j1@gmail.com"
    fill_in "Password", with: "password"
    fill_in "Password confirmation", with: "password"

    click_on "Create Account"

    expect(current_path).to eq(users_path)
    expect(page).to have_content("Your account could not be created. Please check your input and try again.")
    expect(User.count).to eq(original_user_count)
  end

  scenario "guest trys to create account without email" do
    original_user_count = User.count

    visit users_path

    expect(current_path).to eq(users_path)

    fill_in "username", with: "JoeSmith"
    fill_in "Password", with: "password"
    fill_in "Password confirmation", with: "password"

    click_on "Create Account"

    expect(current_path).to eq(users_path)
    expect(page).to have_content("Your account could not be created. Please check your input and try again.")
    expect(User.count).to eq(original_user_count)
  end

  scenario "guest trys to create account without password" do
    original_user_count = User.count

    visit users_path

    expect(current_path).to eq(users_path)

    fill_in "username", with: "JoeSmith"
    fill_in "Email", with: "j1@gmail.com"
    fill_in "Password confirmation", with: "password"

    click_on "Create Account"

    expect(current_path).to eq(users_path)
    expect(page).to have_content("Your account could not be created. Please check your input and try again.")
    expect(User.count).to eq(original_user_count)
  end
end
