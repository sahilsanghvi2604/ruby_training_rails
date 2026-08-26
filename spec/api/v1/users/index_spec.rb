require 'rails_helper'

RSpec.describe 'API V1 Users Index', type: :request do
  let!(:users) { create_list(:user, 3) }

  it 'returns a 200 status and the list of users with whitelisted attributes' do
    get '/api/v1/users'
    puts response.status
    puts response.body
    # 1. Verify HTTP response code
    expect(response).to have_http_status(:ok)

    # 2. Verify total count of users returned
    json_response = JSON.parse(response.body)
    expect(json_response.size).to eq(3)

    # 3. Verify ONLY the 5 required attributes are present
    expected_attributes = %w[id first_name last_name email created_at]
    expect(json_response.first.keys).to match_array(expected_attributes)
  end
end
