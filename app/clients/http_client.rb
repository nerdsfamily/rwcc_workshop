class HttpClient
  def initialize(api_key)
    @api_key = api_key
  end

  def get(url, params = {})
    request(:get, url, params)
  end

  def post(url, params = {}, body = {})
    request(:post, url, params, body)
  end

  def put(url, params = {}, body = {})
    request(:put, url, params, body)
  end

  def delete(url, params = {})
    request(:delete, url, params)
  end

  private

  attr_reader :api_key

  def request(method, url, params = {}, body = {})
    response = HTTP.headers(authorization_header)
                   .public_send(method, url, params: params, json: body)

    handle_response(response)
  end

  def authorization_header
    { 'Authorization' => "Bearer #{@api_key}" }
  end

  def handle_response(response)
    case response.code
    when 200..299
      JSON.parse(response.to_s)
    else
      raise "HTTP Error: #{response.code} - #{response}"
    end
  end
end
