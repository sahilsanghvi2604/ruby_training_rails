# spec/api/v1/users/create_spec.rb
require 'rails_helper'

RSpec.describe 'API V1 Users Create', type: :request do
  it 'creates a user successfully with valid params' do
    valid_params = { user: attributes_for(:user) }

    expect do
      post '/api/v1/users', params: valid_params, as: :json
    end.to change(User, :count).by(1)

    expect(response).to have_http_status(:created)

    json_response = JSON.parse(response.body)
    expected_attributes = %w[id first_name last_name email created_at]

    expect(json_response.keys).to match_array(expected_attributes)
  end

  it 'fails to create a user when required params are missing' do
    invalid_params = { user: { email: 'invalid_email' } }

    expect do
      post '/api/v1/users', params: invalid_params, as: :json
    end.not_to change(User, :count)

    expect(response).to have_http_status(:unprocessable_entity)

    json_response = JSON.parse(response.body)
    expect(json_response).to have_key('errors')
  end
end
