require 'rails_helper'

RSpec.describe "PATCH /genres/:id", type: :request do
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
    Genre.create({
      name: 'Adventure',
      image_url:'http://placeimg.com/640/480'
    })
  end

  it "updates a genre name" do
    patch genre_path(genre),
      params: {
        genre: {
          name: 'Action'
        }
      },
      headers: {
        authorization: "Bearer #{token}"
      }

    expect(response).to have_http_status(200)

    json = JSON.parse(response.body).deep_symbolize_keys

    expect(json[:name]).to eq('Action')
    expect(Genre.last.name).to eq('Action')
  end
  
  scenario "empty name" do
    patch genre_path(genre),
      params: {
        genre: {
          name: ''
        }
      },
      headers: {
        authorization: "Bearer #{token}"
      }

    expect(response).to have_http_status(422)

    json = JSON.parse(response.body).deep_symbolize_keys

    expect(json[:name]).to include("can't be blank")
  end
end