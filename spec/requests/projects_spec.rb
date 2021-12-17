require 'rails_helper'

describe 'Project API', type: :request do

  it 'returns all the projects' do
    get '/api/v1/projects'
    expect(response.status).to eq(200)
  end

  it 'returns a project' do
    project = Project.create!(name: 'AI with home automation', description: 'This is about home automation', idle: 'no', realtime: 'yes', bill: 'billable')
    get "/api/v1/projects/#{project.id}"
    expect(response.status).to eq(302)
  end

  it 'create a project' do
    expect {
      post '/api/v1/projects', params: { project: { name: 'AI with home automation', description: 'This is about home automation', idle: 'no', realtime: 'yes', bill: 'billable'}}
    }.to change { Project.count }.from(0).to(1)
    expect(response.status).to eq(201)
  end

  it 'delete a project' do
    project = Project.create!(name: 'AI with home automation', description: 'This is about home automation', idle: 'no', realtime: 'yes', bill: 'billable')
    expect {
      delete "/api/v1/projects/#{project.id}"
    }.to change {Project.count}.from(1).to(0)
  end

  it 'edit a project' do
    project = Project.create!(name: 'AI with home automation', description: 'This is about home automation', idle: 'no', realtime: 'yes', bill: 'billable')
    put "/api/v1/projects/#{project.id}", params: {
      project: {
        name: 'AI library management',
        description: 'This is about library management',
        idle: 'no',
        realtime: 'yes',
        bill: 'billable'
      }
    }
    expect(response).to have_http_status(201)
    expect(JSON.parse(response.body).size).to eq(3)
  end
end
