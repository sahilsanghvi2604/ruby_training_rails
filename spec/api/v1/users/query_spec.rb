# spec/api/v1/users/index_spec.rb
require 'rails_helper'

RSpec.describe 'API V1 Users Index', type: :request do
  let!(:sahil_sanghvi)    { create(:user, first_name: 'Sahil', last_name: 'Sanghvi', email: 'sahil@example.com') }
  let!(:mark_doe)    { create(:user, first_name: 'Drumil', last_name: 'Sanghvi', email: 'drumil@example.com') }
  let!(:john_doe) { create(:user, first_name: 'John', last_name: 'Doe', email: 'milton@example.com') }

  it 'returns all users when no filter parameters are sent' do
    get '/api/v1/users', as: :json

    expect(response).to have_http_status(:ok)
    json = JSON.parse(response.body)
    expect(json.pluck('id')).to match_array([john_doe.id, mark_doe.id, john_milton.id])
  end

  it 'filters users by first_name' do
    get '/api/v1/users', params: { first_name: 'John' }, as: :json

    expect(response).to have_http_status(:ok)
    json = JSON.parse(response.body)
    expect(json.pluck('id')).to match_array([john_doe.id, john_milton.id])
  end

  it 'filters users by last_name' do
    get '/api/v1/users', params: { last_name: 'Doe' }, as: :json

    expect(response).to have_http_status(:ok)
    json = JSON.parse(response.body)
    expect(json.pluck('id')).to match_array([john_doe.id, mark_doe.id])
  end

  it 'filters users by email' do
    get '/api/v1/users', params: { email: 'mark@example.com' }, as: :json

    expect(response).to have_http_status(:ok)
    json = JSON.parse(response.body)
    expect(json.pluck('id')).to match_array([mark_doe.id])
  end

  it 'filters users by multiple parameters simultaneously (first_name and last_name)' do
    get '/api/v1/users', params: { first_name: 'John', last_name: 'Doe' }, as: :json

    expect(response).to have_http_status(:ok)
    json = JSON.parse(response.body)
    expect(json.pluck('id')).to match_array([john_doe.id])
  end
end