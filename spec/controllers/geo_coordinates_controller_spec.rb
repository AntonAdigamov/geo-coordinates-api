require 'rails_helper'

RSpec.describe GeoCoordinatesController, type: :controller do
  it 'returns 406 with a respective message if no token is provided' do
    get 'locate'

    expect(response).to have_http_status(406)
    expect(JSON.parse(response.body)['message']).to eq('Please provide your access token.')
  end

  it 'returns 406 with a respective message if no search value is provided' do
    get 'locate', params: { token: 'asdf' }

    expect(response).to have_http_status(406)
    expect(JSON.parse(response.body)['message']).to eq('Please input the search value: an address or a name of a place you are searching for.')
  end

  it 'returns 401 in case of the wrong token' do
    get 'locate', params: { token: 'asdf', search_value: 'blah-blah' }

    expect(response).to have_http_status(401)
    expect(JSON.parse(response.body)['message']).to eq('There is a problem with your access token.')
  end
end
