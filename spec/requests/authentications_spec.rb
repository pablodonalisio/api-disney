require 'rails_helper'

RSpec.describe "Authentications", type: :request do
  describe "POST /login" do
    let!(:user) { User.create({ email: 'test@test.com', password:'asdfgh' }) }

    scenario "succesfully loged in" do
      post login_path, params: {
        user: {
          email: 'test@test.com',
          password: 'asdfgh'
        }
      }

      expect(response).to have_http_status(200)

      json = JSON.parse(response.body).deep_symbolize_keys

      expect(json).to include(:token, :exp)
      expect(json[:email]).to eq('test@test.com')
    end

    scenario "unauthorized" do
      post login_path, params: {
        user: {
          email: '',
          password: 'asdfgh'
        }
      }

      expect(response).to have_http_status(401)

      json = JSON.parse(response.body).deep_symbolize_keys

      expect(json[:error]).to eq('unauthorized')
    end
  end
end
