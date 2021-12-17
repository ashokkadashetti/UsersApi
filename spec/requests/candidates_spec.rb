require 'rails_helper'

describe 'Candidates API', type: :request do
  Candidate.destroy_all
  User.destroy_all
  describe 'GET/candidates' do
    it 'returns all the candidates' do
      get '/api/v1/candidates'
      expect(response).to have_http_status(200)
      expect(JSON.parse(response.body).size).to eq(3)
    end
  end

  describe 'POST/candidate' do
    it 'cerate a new candidate' do
      user = User.create!(name: 'klrahul', email: 'klrahul@gmail.com', password: '123456', role: 'TL')
      expect {
        post '/api/v1/candidates', params: { candidate: { user_id: user.id, name: 'vinayak', email: 'vinayak@gmail.com' } }
      }.to change{ Candidate.count }.from(0).to(1)
      expect(User.count).to eq(1)
      expect(response.status).to eq(200)
      expect(JSON.parse(response.body).size).to eq(3)
    end
  end

  it 'delete/candidates' do
    user = User.create!(name: 'klrahul', email: 'klrahul@gmail.com', password: '123456', role: 'TL')
    candidate = Candidate.create!(user_id: user.id, name: 'vinayak', email: 'vinayak@gmail.com')
      expect {
        delete "/api/v1/candidates/#{candidate.id}"
      }.to change{ Candidate.count }.from(1).to(0)
  end

end
