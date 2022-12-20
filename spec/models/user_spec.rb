require 'rails_helper'

RSpec.describe User, type: :model do
  subject { create(:user) }
  describe "validations" do
    it { should validate_uniqueness_of(:email) }
    it { should validate_presence_of(:email) }
    it { should validate_presence_of(:password_digest) }
    it { should validate_presence_of(:name) }
  end
  it { should have_secure_password }

  
end
