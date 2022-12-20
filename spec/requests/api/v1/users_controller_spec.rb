# frozen_string_literal: true

require "rails_helper"

RSpec.describe "api/v1/user", type: :request do
  let(:admin) { create(:all_casa_admin) }

  describe "POST /create" do
    subject(:create_user) { post api_v1_users_path, params: user_params, as: :json }
    let(:response_body) { JSON.parse(response.body) }
    
    context "with valid parameters" do
      let(:user_params) { { name: 'user', email: 'user@user.com', password: '123456', password_confirmation: '123456' } }

      it "creates a new user" do
        expect{create_user}.to change(User, :count).by(1)
      end

      it "returns user as json" do
        create_user
        expect(response.body).to include(user_params[:email])
        expect(response.body).to include(user_params[:name])
      end
    end

    context "with invalid parameters" do
      let(:user_params) { { name: 'user', email: 'user@user.com', password: '123456', password_confirmation: 'wrong_password' } }
      it "doesn't create a new user" do
        expect{create_user}.to change(User, :count).by(0)
      end

      it "returns errors as json", :aggregate_failures do
        create_user
        expect(JSON.parse(response.body)).to eq({"errors" => "Validation failed: Password confirmation doesn't match Password"})
      end
    end
  end

  describe "PATCH /update" do
    context "with valid parameters" do
      xit "updates the user"

      xit "returns updated user as json"
    end

    context "with invalid parameters" do
      xit "returns unauthorized status"
    end
  end
end
