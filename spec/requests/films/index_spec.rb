require 'rails_helper'

RSpec.describe "GET /films", type: :request do
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
      title: 'Aladdin',
      image_url:'http://placeimg.com/640/480',
      release_date: "10-10-1995",
      rating: 5
    })
  end
  let!(:genre) { Genre.create({ name: 'Adventure' }) }
  let!(:genre_id) { Genre.find_by_name('Adventure') }

  it "shows all films" do
    get films_path,
      headers: {
        authorization: "Bearer #{token}"
      }

    expect(response).to have_http_status(200)

    json = JSON.parse(response.body)[0].deep_symbolize_keys
    expect(json[:title]).to eq('Aladdin')
  end

  it "redirects to specified film" do
    get films_path,
      params: {
        title: 'Aladdin'
      },
      headers: {
        authorization: "Bearer #{token}"
      }

    expect(response).to have_http_status(302)
  end

  it 'returns films with specified genre' do 
    get films_path,
      params: {
        genreId: genre_id
      },
      headers: {
        authorization: "Bearer #{token}"
      }

    expect(response).to have_http_status(200)

    json = JSON.parse(response.body)[0].deep_symbolize_keys
    expect(json[:title]).to eq('Aladdin')
  end

  describe "ordering films" do
    let!(:other_film) do
      Film.create({
        title: 'Mickey Mouse Adventures',
        release_date: "10-10-1990",
      })
    end

    it 'returns films in DESC order' do 
      get films_path,
        params: {
          order: 'DESC'
        },
        headers: {
          authorization: "Bearer #{token}"
        }

      expect(response).to have_http_status(200)

      json = JSON.parse(response.body)[0].deep_symbolize_keys
      expect(json[:title]).to eq('Aladdin')
    end

    it 'returns films in ASC order' do 
      get films_path,
        params: {
          order: 'ASC'
        },
        headers: {
          authorization: "Bearer #{token}"
        }

      expect(response).to have_http_status(200)

      json = JSON.parse(response.body)[0].deep_symbolize_keys
      expect(json[:title]).to eq('Mickey Mouse Adventures')
    end
  end
end