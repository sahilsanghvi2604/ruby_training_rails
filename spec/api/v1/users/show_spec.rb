require 'rails_helper'

RSpec.describe 'API V1 Users Show', type: :request do
  let!(:user) { create(:user) }

  it 'returns a 200 status and the requested user with whitelisted attributes' do
    get "/api/v1/users/#{user.id}"

    # Verify HTTP response code
    expect(response).to have_http_status(:ok)

    # Parse the response
    json_response = JSON.parse(response.body)

    # 3. Verify the correct user is returned
    expect(json_response['id']).to eq(user.id)
    expect(json_response['first_name']).to eq(user.first_name)
    expect(json_response['last_name']).to eq(user.last_name)
    expect(json_response['email']).to eq(user.email)
  end
  it 'returns a 404 status when the user does not exist' do
    get '/api/v1/users/999999'

    # Verify HTTP response code
    expect(response).to have_http_status(:not_found)
  end
end
