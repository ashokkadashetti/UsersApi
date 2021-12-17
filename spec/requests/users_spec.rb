require 'rails_helper'

describe 'Users API', type: :request do
  User.destroy_all
  describe 'GET/users' do
    it 'returns all the users' do
      get '/api/v1/users'
      expect(response).to have_http_status(200)
      expect(JSON.parse(response.body).size).to eq(3)
    end
  end

  describe 'POST/user' do
    it 'create a new user' do
      User.destroy_all
      expect {
        post '/api/v1/users', params: { user: { name: 'Venki', email: 'venki@gmail.com', password: '123456', role: 'TL' }}
      }.to change { User.count }.from(0).to(1)
    end
  end

  describe 'Delete/user' do
    it 'detete a user' do
      user = User.create!(name: 'venki', email: 'venki@gmail.com', password: '123456', role: 'TL')
      expect {
        delete "/api/v1/users/#{user.id}"
      }.to change { User.count }.from(1).to(0)

      expect(response).to have_http_status(204)
    end
  end

  describe 'Show/user' do
    it 'show a user' do
      user = User.create!(name: 'venki', email: 'venki@gmail.com', password: '123456', role: 'TL')
      get "/api/v1/users/#{user.id}"
      expect(response).to have_http_status(302)
      expect(JSON.parse(response.body).size).to eq(4)
    end
  end

  describe 'Edit/user' do
    let!(:user) { User.create!(name: 'venki', email: 'venki@gmail.com', password: '123456', role: 'TL') }
    it 'edit a user' do
      put "/api/v1/users/#{user.id}", params: {
        user: {
          name: 'Rahul',
          email: 'rahul@gmail.com',
          password: '123456',
          role: 'TL'
        }
      }
      expect(response).to have_http_status(200)
      expect(JSON.parse(response.body).size).to eq(3)
      expect(User.find(user.id)).to eq(user)
    end
  end
end
