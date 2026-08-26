module Build
  class DatabaseBuilder
    def run
      execute
    end

    def execute
      reset_data
      create_users
    end

    def reset_data
      puts "Cleaning database..."
      User.destroy_all
    end

    def create_users
      puts "Creating 10 users..."
      FactoryBot.create_list(:user, 10)
    end
  end
end
