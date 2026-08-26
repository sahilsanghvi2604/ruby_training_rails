# require 'rails_helper'

# RSpec.describe "User Sign In", type: :request do

#   # 1. Valid Scenario: Successfully logs in with correct credentials
#   it "logs in successfully with correct email and password" do
#     # Saari validations pass ho isiliye poori details ke sath user bana rahe hain
#     User.create!(
#       first_name: "Sahil",
#       last_name: "Sanghvi",
#       email: "sahil@example.com",
#       password: "sahil123",
#       password_confirmation: "sahil123"
#     )

#     valid_credentials = {
#       user: {
#         email: "sahil@example.com",
#         password: "sahil123"
#       }
#     }

#     post "/users/sign_in", params: valid_credentials

#     expect(controller.current_user).not_to be_nil
#   end

#   # 2. Invalid Scenario: Fails to log in with incorrect password
#   it "fails to log in with an incorrect password" do
#     User.create!(
#       first_name: "Sahil",
#       last_name: "Sanghvi",
#       email: "sahil@example.com",
#       password: "sahil123",
#       password_confirmation: "sahil123"
#     )

#     invalid_credentials = {
#       user: {
#         email: "sahil@example.com",
#         password: "wrong_password"
#       }
#     }

#     post "/users/sign_in", params: invalid_credentials

#     expect(controller.current_user).to be_nil
#   end

# end

require 'rails_helper'

RSpec.describe "User Sign In", type: :request do
  let!(:user) { create(:user, password: "sahil123", password_confirmation: "sahil123") }

  # 1. Valid Scenario: Successfully logs in with correct credentials
  it "logs in successfully with correct email and password" do
    valid_credentials = {
      user: {
        email: user.email,
        password: "sahil123"
      }
    }

    post "/users/sign_in", params: valid_credentials

    expect(controller.current_user).not_to be_nil
  end

  # 2. Invalid Scenario: Fails to log in with incorrect password
  it "fails to log in with an incorrect password" do
    invalid_credentials = {
      user: {
        email: user.email,
        password: "wrong_password"
      }
    }

    post "/users/sign_in", params: invalid_credentials

    expect(controller.current_user).to be_nil
  end
end
