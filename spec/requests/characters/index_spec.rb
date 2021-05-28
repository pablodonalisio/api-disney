require 'rails_helper'

RSpec.describe "GET /characters", type: :request do
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
      name: 'Aladdin',
      image_url:'http://placeimg.com/640/480',
      age:'18',
      weight:'72',
      story: 'Porro occaecati et animi dolorem aliquam dolor.'
    })
  end

  it "shows all characters" do
    get characters_path,
      headers: {
        authorization: "Bearer #{token}"
      }

    expect(response).to have_http_status(200)

    json = JSON.parse(response.body)[0].deep_symbolize_keys
    expect(json[:name]).to eq('Aladdin')
  end

  it "redirects to specified character" do
    get characters_path,
      params: {
        name: 'Aladdin'
      },
      headers: {
        authorization: "Bearer #{token}"
      }

    expect(response).to have_http_status(302)
  end

  it 'returns characters with specified age' do 
    get characters_path,
      params: {
        age: '18'
      },
      headers: {
        authorization: "Bearer #{token}"
      }

    expect(response).to have_http_status(200)

    json = JSON.parse(response.body)[0].deep_symbolize_keys
    expect(json[:name]).to eq('Aladdin')
  end

  it 'returns characters with specified weight' do 
    get characters_path,
      params: {
        weight: '72'
      },
      headers: {
        authorization: "Bearer #{token}"
      }

    expect(response).to have_http_status(200)

    json = JSON.parse(response.body)[0].deep_symbolize_keys
    expect(json[:name]).to eq('Aladdin')
  end
end