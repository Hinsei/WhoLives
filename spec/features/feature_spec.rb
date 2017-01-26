require "rails_helper"

RSpec.feature "button", :type => :feature do

	let(:user) {User.create!(username: "testing", email: "testing@gmail.com", password: "12345678", password_confirmation: "12345678")}
	let(:email) {"testing@gmail.com"}
	let(:password) {"12345678"}

  scenario "New user clicks log in button" do
    visit "/session/new"
    fill_in "Email", with: "testing@gmail.com"
    expect(find_field("Email").value).to eq("testing@gmail.com")
  end
end