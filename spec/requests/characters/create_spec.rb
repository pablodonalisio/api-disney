require 'rails_helper'

RSpec.describe "POST /characters", type: :request do
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

  it "creates a new character" do
    post characters_path,
      params: {
        character: {
          name: 'Aladdin',
          image_url: 'http://placeimg.com/640/480',
          age: "18",
          weight: "72",
          story: "Porro occaecati et animi dolorem aliquam dolor."
        }
      },
      headers: {
        authorization: "Bearer #{token}"
      }

    expect(response).to have_http_status(201)

    json = JSON.parse(response.body).deep_symbolize_keys

    expect(json[:name]).to eq('Aladdin')
    expect(json[:image_url]).to eq('http://placeimg.com/640/480')
    expect(json[:age]).to eq('18')
    expect(json[:weight]).to eq('72')
    expect(json[:story]).to eq('Porro occaecati et animi dolorem aliquam dolor.')
    expect(Character.last.name).to eq('Aladdin')
  end
  
  scenario "empty name" do
    post characters_path,
      params: {
        character: {
          name: '',
          image_url: 'http://placeimg.com/640/480',
          age: "18",
          weight: "72",
          story: "Porro occaecati et animi dolorem aliquam dolor."
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
    let!(:character) { Character.create({ name: "Aladdin" })}
    it "returns 'name already taken'" do
      post characters_path,
        params: {
          character: {
            name: 'Aladdin',
            image_url: 'http://placeimg.com/640/480',
            age: "18",
            weight: "72",
            story: "Porro occaecati et animi dolorem aliquam dolor."
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