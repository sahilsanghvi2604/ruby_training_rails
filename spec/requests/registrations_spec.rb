# require 'rails_helper'

# RSpec.describe "User Sign Up", type: :request do

#   # 1. Valid Scenario: User should be created with valid details
#   it "successfully registers a user with valid details" do
#     valid_data = {
#       user: {
#         first_name: "Sahil",
#         last_name: "Sanghvi",
#         email: "sahil@example.com",
#         password: "password123",
#         password_confirmation: "password123"
#       }
#     }

#     # Check that the user count in the database increases by 1
#     expect {
#       post "/users", params: valid_data
#     }.to change(User, :count).by(1)
#   end

#   # 2. Invalid Scenario: User should not be created if passwords don't match
#   it "fails to register a user when password confirmation does not match" do
#     invalid_data = {
#       user: {
#         first_name: "Sahil",
#         last_name: "Sanghvi",
#         email: "sahil@example.com",
#         password: "password123",
#         password_confirmation: "wrong_password" # Mismatch!
#       }
#     }

#     # Check that the user count in the database does NOT change
#     expect {
#       post "/users", params: invalid_data
#     }.not_to change(User, :count)
#   end

# end
require 'rails_helper'

RSpec.describe "User Sign Up", type: :request do
  let(:valid_user_attributes) { attributes_for(:user) }

  # 1. Valid Scenario: User should be created with valid details
  it "successfully registers a user with valid details" do
    valid_data = { user: valid_user_attributes }

    expect do
      post "/users", params: valid_data
    end.to change(User, :count).by(1)
  end

  # 2. Invalid Scenario: User should not be created if passwords don't match
  it "fails to register a user when password confirmation does not match" do
    invalid_data = {
      user: valid_user_attributes.merge(password_confirmation: "wrong_password")
    }

    expect do
      post "/users", params: invalid_data
    end.not_to change(User, :count)
  end
end
