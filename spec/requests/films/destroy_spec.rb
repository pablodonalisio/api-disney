require 'rails_helper'

RSpec.describe "DELETE /films/:id", type: :request do
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
  let!(:film) do
    Film.create({ title: 'Aladdin' })
  end

  it "delete a film" do
    delete film_path(film),
      headers: {
        authorization: "Bearer #{token}"
      }

    expect(response).to have_http_status(204)
    expect(Film.find_by_title('Aladdin')).to be_nil
  end
end