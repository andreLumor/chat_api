# frozen_string_literal: true

module Users
  class Updater
    include Dry::Transaction

    map :downcase_email
    try :update_user, catch: ActiveRecord::RecordInvalid

    private
    def update_user(input)
      User.find(input[:id]).update!(input)
      { message: 'User updated' }
    end
    
    def downcase_email(input)
      binding.pry
      input['email'].downcase!
      input
    end
  end
end
