module Users
  class CreateUser < ActiveInteraction::Base
    # 1. Define required inputs and their expected data types
    string :first_name, :last_name, :email, :password, :password_confirmation

    # 2. Define optional inputs by giving them a default value of nil
    string :phone_number, default: nil
    integer :age, default: nil
    date :date_of_birth, default: nil

    # 3. Validation rules
    validates :first_name, :last_name, :email, :password, :password_confirmation, presence: true

    def execute
      user = User.new(inputs)

      # If saving fails (e.g. email already exists in DB), pass model errors to ActiveInteraction
      errors.merge!(user.errors) unless user.save

      user # Return the user object
    end
  end
end
