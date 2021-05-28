require 'rails_helper'

RSpec.describe "PATCH /films/:id", type: :request do
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
    Film.create({
      title: 'Aladdino',
      image_url:'http://placeimg.com/640/480',
      release_date: "10-10-1995",
      rating: "5"
    })
  end

  it "updates a film title" do
    patch film_path(film),
      params: {
        film: {
          title: 'Aladdin'
        }
      },
      headers: {
        authorization: "Bearer #{token}"
      }

    expect(response).to have_http_status(200)

    json = JSON.parse(response.body).deep_symbolize_keys

    expect(json[:title]).to eq('Aladdin')
    expect(Film.last.title).to eq('Aladdin')
  end
  
  scenario "empty title" do
    patch film_path(film),
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
end