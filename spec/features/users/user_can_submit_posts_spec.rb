require 'rails_helper'

RSpec.feature "Timeline", type: :feature do
  scenario "Can submit posts and view them" do
    visit "/users/sign_up"
    fill_in "user_username", with: "Bob"
    fill_in "user_email", with: "bob@example.com"
    fill_in "user_password", with: "password1!"
    fill_in "user_password_confirmation", with: "password1!"
    click_button "Sign up"
    visit "/posts"
    click_link "New post"
    fill_in "Message", with: "Hello, world!"
    click_button "Submit"
    expect(page).to have_content("Hello, world!")
  end

  scenario "Can submit posts and with images view them" do
    visit "/posts"
    click_link "New post"
    fill_in "post[message]", with: "Hello, world!"
    attach_file("post[images][]", './spec/files/attachment.jpeg')
    click_button "Submit"
    expect(page).to have_content("Hello, world!")
    expect(page).to have_css("img[src*='attachment.jpeg']")
  end

  scenario "Can submit posts and with multiple images" do
    visit "/posts"
    click_link "New post"
    fill_in "post[message]", with: "Hello, world!"
    attach_file("post[images][]", ['./spec/files/attachment.jpeg', './spec/files/marmite.jpeg'])
    click_button "Submit"
    expect(page).to have_content("Hello, world!")
    expect(page).to have_css("img[src*='attachment.jpeg']")
  end

  scenario "Gives error message if post empty" do
    visit "/posts"
    click_link "New post"
    click_button "Submit"
    expect(page).to have_content("Cannot create an empty post.")
  end
end