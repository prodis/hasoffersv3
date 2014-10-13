ENV['TEST'] = 'TEST'

require 'hasoffersv3'
require 'webmock/rspec'

# This file was generated by the `rspec --init` command. Conventionally, all
# specs live under a `spec` directory, which RSpec adds to the `$LOAD_PATH`.
# Require this file using `require "spec_helper"` to ensure that it is only
# loaded once.
#
# See http://rubydoc.info/gems/rspec-core/RSpec/Core/Configuration
RSpec.configure do |config|
  config.run_all_when_everything_filtered = true
  config.filter_run :focus

  # Run specs in random order to surface order dependencies. If you find an
  # order dependency and want to debug it, you can fix the order by providing
  # the seed, which is printed after each run.
  #     --seed 1234
  config.order = 'random'

  config.before :each do
    WebMock.disable_net_connect!
    HasOffersV3::Testing.disable!
  end
end

def api_url(object)
  "#{ HasOffersV3.configuration.base_uri }/#{ object }.json"
end

def body
  { 'response' => { 'status' => 1, 'data' => [] } }
end

def default_return
  { status: 200, body: JSON.dump(body) }
end

def data
  body['response']['data']
end

def stub_call(method = :post, to_return = nil, custom_url = nil)
  stub_request(method, custom_url || url).to_return to_return || default_return
end

def validate_call(response)
  expect(response).to be_success
  expect(response.data).to be == data
end
