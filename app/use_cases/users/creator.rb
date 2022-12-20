# frozen_string_literal: true

module Users
  class Creator
    include Dry::Transaction

    map :downcase_email
    try :create_user, catch: ActiveRecord::RecordInvalid

    private
    def create_user(input)
      User.create!(
        name: input['name'],
        email: input['email'],
        password: input['password'],
        password_confirmation: input['password_confirmation']
      )
    end

    def downcase_email(input)
      input['email'].downcase!
      input
    end
  end
end
