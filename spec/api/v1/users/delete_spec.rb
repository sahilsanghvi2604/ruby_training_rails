# spec/api/v1/users/delete_spec.rb
require 'rails_helper'

RSpec.describe 'API V1 Users Delete', type: :request do
  let!(:user) { create(:user) }

  it 'deletes a user successfully and returns a success message' do
    expect do
      delete "/api/v1/users/#{user.id}", as: :json
    end.to change(User, :count).by(-1)

    expect(response).to have_http_status(:ok)

    json_response = JSON.parse(response.body)
    expect(json_response['message']).to eq('User deleted successfully')
  end

  it 'returns 404 when trying to delete a non-existent user' do
    delete '/api/v1/users/0', as: :json

    expect(response).to have_http_status(:not_found)
  end
end