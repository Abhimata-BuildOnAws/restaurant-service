
class OpenRoutesService
  def self.get_route(mode_of_transport, values)
    values = {"coordinates":[[8.681495,49.41461],[8.686507,49.41943],[8.687872,49.420318]]}
    headers = {
        'accept' => 'application/json, application/geo+json, application/gpx+xml, img/png; charset=utf-8',
        'Authorization' => ENV['OPEN_ROUTES_API_KEY'],
        'Content-Type' => 'application/json; charset=utf-8'
      }
      url = "https://api.openrouteservice.org/v2/directions/#{mode_of_transport}/geojson"

    conn = Faraday.new(
      url: url,
      headers: headers
    )

    response = conn.post do |req|
      req.body = values.to_json
    end
    response.body
    
  end
end