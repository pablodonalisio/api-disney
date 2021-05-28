require 'rails_helper'

RSpec.describe "PATCH /character/:id", type: :request do
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
    Character.create({
      name: 'Aladdino',
      image_url:'http://placeimg.com/640/480',
      age:'18',
      weight:'72',
      story: 'Porro occaecati et animi dolorem aliquam dolor.'
    })
  end

  it "updates a character name" do
    patch character_path(character),
      params: {
        character: {
          name: 'Aladdin'
        }
      },
      headers: {
        authorization: "Bearer #{token}"
      }

    expect(response).to have_http_status(200)

    json = JSON.parse(response.body).deep_symbolize_keys

    expect(json[:name]).to eq('Aladdin')
    expect(Character.last.name).to eq('Aladdin')
  end
  
  scenario "empty name" do
    patch character_path(character),
      params: {
        character: {
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