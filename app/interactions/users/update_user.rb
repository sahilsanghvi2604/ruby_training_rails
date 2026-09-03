# app/interactions/users/update_user.rb
module Users
  class UpdateUser < ActiveInteraction::Base
    object :user, class: User

    string :first_name, default: nil
    string :last_name, default: nil
    string :email, default: nil
    string :password, default: nil
    string :password_confirmation, default: nil
    string :phone_number, default: nil
    integer :age, default: nil
    date :date_of_birth, default: nil

    def execute
      update_params = inputs.except(:user).compact

      errors.merge!(user.errors) unless user.update(update_params)
      user
    end
  end
end
