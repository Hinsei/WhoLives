require "rails_helper"

RSpec.describe User, :type => :model do

	let(:user) { User.create!(username: "testing", email: "test@gmail.com", password: "testing12345", password_confirmation: "testing12345") }


  describe "required columns for table" do
		it {should have_db_column(:username).of_type(:string)}
		it {should have_db_column(:email).of_type(:string)}
		it {should have_db_column(:wins).of_type(:integer)}
		it {should have_db_column(:losses).of_type(:integer)}
		it {should have_db_column(:total_game).of_type(:integer)}
		it {should have_db_column(:role).of_type(:integer)}
		it {should have_db_column(:password_digest).of_type(:string)}
	end

	describe "required validation for creating new users" do
		it {should have_secure_password}
		it {should validate_presence_of(:password)}
		it {should validate_length_of(:password).is_at_least(5)}
		it {should validate_uniqueness_of(:username)}
		it {should validate_uniqueness_of(:email)}
		it {should validate_presence_of(:username)}
		it {should validate_presence_of(:email)}
	end

	it "#self.authenticate" do
		expect{User.authenticate}.to raise_error(ArgumentError)
		expect{User.authenticate("test@gmail.com", "testing12345")}.not_to raise_error
	end

	it "#email" do
		expect(user.email).to eq("test@gmail.com")
	end

	it "#username" do
		expect(user.username).to eq("testing")
	end

	it "#losses" do
		expect(user.losses).to eq(0)
	end

	it "#role" do
		expect(user.role).to eq("user")
	end

end