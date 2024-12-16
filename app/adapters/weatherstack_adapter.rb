class WeatherstackAdapter
  def current_weather
    HTTParty.get('https://api.weatherstack.com/current', params: { city: 'Warsaw', access_key})
  end

  private

  attr_reader :client
end
