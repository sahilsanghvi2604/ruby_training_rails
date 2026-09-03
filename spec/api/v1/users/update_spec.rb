# spec/api/v1/users/update_spec.rb
require 'rails_helper'

RSpec.describe 'API V1 Users Update', type: :request do
  let!(:user) { create(:user, first_name: 'OriginalName', email: 'original@example.com') }

  it 'updates a single attribute of a user successfully' do
    update_params = { user: { first_name: 'UpdatedName' } }

    put "/api/v1/users/#{user.id}", params: update_params, as: :json

    expect(response).to have_http_status(:ok)

    json_response = JSON.parse(response.body)
    expect(json_response['first_name']).to eq('UpdatedName')
    expect(json_response['email']).to eq('original@example.com')

    expected_attributes = %w[id first_name last_name email created_at]
    expect(json_response.keys).to match_array(expected_attributes)
  end

  it 'updates all allowed attributes successfully' do
    update_params = {
      user: {
        first_name: 'NewFirst',
        last_name: 'NewLast',
        email: 'newemail@example.com'
      }
    }

    put "/api/v1/users/#{user.id}", params: update_params, as: :json

    expect(response).to have_http_status(:ok)

    json_response = JSON.parse(response.body)
    expect(json_response['first_name']).to eq('NewFirst')
    expect(json_response['last_name']).to eq('NewLast')
    expect(json_response['email']).to eq('newemail@example.com')
  end

  it 'fails to update user with invalid parameters' do
    invalid_params = { user: { email: '' } }

    put "/api/v1/users/#{user.id}", params: invalid_params, as: :json

    expect(response).to have_http_status(:unprocessable_content)

    json_response = JSON.parse(response.body)
    expect(json_response).to have_key('errors')
  end
end
