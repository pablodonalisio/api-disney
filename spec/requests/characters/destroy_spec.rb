require 'rails_helper'

RSpec.describe "DELETE /characters/:id", type: :request do
  let!(:user) { User.create({ email: "test@test.com", password: "asdfgh" })}
  let!(:token) do
    post login_path, params: {
      user: {
        email: user.email,
        password: "asdfgh"
      }
    }
    json = JSON.parse(response.body).deep_symbolize_keys
    json[:token]
  end
  let!(:character) do
    Character.create({ name: 'Aladdin' })
  end

  it "delete a character" do
    delete character_path(character),
      headers: {
        authorization: "Bearer #{token}"
      }

    expect(response).to have_http_status(204)
    expect(Character.find_by_name('Aladdin')).to be_nil
  end
end