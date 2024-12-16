class WeatherstackClient < HttpClient
  BASE_URL = 'https://api.weatherstack.com'.freeze

  def initialize
    @api_key = Rails.credentials.weatherstack.api_key
  end

  private

  attr_reader :api_key

  def request(method, path, params = {}, body = {})
    params.merge!(access_key: api_key)
    url = [BASE_URL + path].join

    response = HTTP.public_send(method, url, params: params, json: body)

    handle_response(response)
  end
end
