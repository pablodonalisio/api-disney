require 'rails_helper'

RSpec.describe "POST /movies", type: :request do
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

  it "creates a new movie" do
    post films_path,
      params: {
        film: {
          title: 'Aladdin',
          image_url: 'http://placeimg.com/640/480',
          release_date: "10-10-1995",
          rating: "5"
        }
      },
      headers: {
        authorization: "Bearer #{token}"
      }

    expect(response).to have_http_status(201)

    json = JSON.parse(response.body).deep_symbolize_keys

    expect(json[:title]).to eq('Aladdin')
    expect(json[:image_url]).to eq('http://placeimg.com/640/480')
    expect(json[:release_date]).to eq('1995-10-10')
    expect(json[:rating]).to eq(5)
    expect(Film.last.title).to eq('Aladdin')
  end
  
  scenario "empty title" do
    post films_path,
      params: {
        film: {
          title: ''
        }
      },
      headers: {
        authorization: "Bearer #{token}"
      }

    expect(response).to have_http_status(422)

    json = JSON.parse(response.body).deep_symbolize_keys

    expect(json[:title]).to include("can't be blank")
  end

  describe "title already taken" do
    let!(:film) { Film.create({ title: "Aladdin" })}
    it "returns 'title has already been taken'" do
      post films_path,
        params: {
          film: {
            title: 'Aladdin',
            image_url: 'http://placeimg.com/640/480'
          }
        },
        headers: {
          authorization: "Bearer #{token}"
        }

      expect(response).to have_http_status(422)

      json = JSON.parse(response.body).deep_symbolize_keys

      expect(json[:title]).to include("has already been taken")
    end
  end
end