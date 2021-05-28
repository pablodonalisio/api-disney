require 'rails_helper'

RSpec.describe "POST /genres", type: :request do
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

  it "creates a new genre" do
    post genres_path,
      params: {
        genre: {
          name: 'Adventure',
          image_url: 'http://placeimg.com/640/480',
        }
      },
      headers: {
        authorization: "Bearer #{token}"
      }

    expect(response).to have_http_status(201)

    json = JSON.parse(response.body).deep_symbolize_keys

    expect(json[:name]).to eq('Adventure')
    expect(json[:image_url]).to eq('http://placeimg.com/640/480')
    expect(Genre.last.name).to eq('Adventure')
  end

  scenario "empty name" do
    post genres_path,
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

  describe "name already taken" do
    let!(:genre) { Genre.create({ name: "Adventure" })}
    it "returns 'name already taken'" do
      post genres_path,
        params: {
          genre: {
            name: 'Adventure',
            image_url: 'http://placeimg.com/640/480'
          }
        },
        headers: {
          authorization: "Bearer #{token}"
        }

      expect(response).to have_http_status(422)

      json = JSON.parse(response.body).deep_symbolize_keys

      expect(json[:name]).to include("has already been taken")
    end
  end
end