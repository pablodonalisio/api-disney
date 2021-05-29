require 'rails_helper'

RSpec.describe "DELETE /genre/:id", type: :request do
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
  let!(:genre) do
    Genre.create({ name: 'Adventure' })
  end

  it "delete a genre" do
    delete genre_path(genre),
      headers: {
        authorization: "Bearer #{token}"
      }

    expect(response).to have_http_status(204)
    expect(Genre.find_by_name('Adventure')).to be_nil
  end
end