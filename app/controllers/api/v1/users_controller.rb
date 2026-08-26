module Api
  module V1
    class UsersController < ApplicationController
      api :GET, "/api/v1/users", "List all users"
      def index
        render json: User.all, status: :ok
      end

      api :GET, "/api/v1/users/:id", "Show a user"
      param :id, Integer, required: true, desc: "User ID"
      def show
        user = User.find(params[:id])
        render json: user, status: :ok
      end

      api :POST, "/api/v1/users", "Create a new user"
      param :user, Hash, required: true do
        param :first_name, String, desc: "First Name"
        param :last_name, String, desc: "Last Name"
        param :email, String, desc: "Email address"
        param :password, String, desc: "Password"
        param :password_confirmation, String, desc: "Password Confirmation"
        param :phone_number, String, desc: "Phone Number"
        param :age, Integer, desc: "Age"
        param :date_of_birth, String, desc: "Date of Birth"
      end
      def create
        outcome = Users::CreateUser.run(user_params)

        if outcome.valid?
          render json: outcome.result, status: :created
        else
          render json: { errors: outcome.errors.full_messages }, status: :unprocessable_entity
        end
      end

      private

      def user_params
        params.require(:user).permit(
          :first_name, :last_name, :email, :password,
          :password_confirmation, :phone_number, :age, :date_of_birth
        )
      end
    end
  end
end
