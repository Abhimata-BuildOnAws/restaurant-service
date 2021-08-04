# frozen_string_literal: true

class OpenRoutesService
  def self.get_route(mode_of_transport, restaurant, pickup)
    values = { "coordinates": [restaurant, pickup] }
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
  
  def self.get_travel_distance(mode_of_transport, restaurant, pickup)
    values = { "coordinates": [restaurant, pickup] }
  
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
    json = JSON.parse(response.body)
    segments = json['features'][0]['properties']['segments']
    total_distance = 0
    segments.each do |s|
      total_distance += s['distance']
    end
    total_distance
  end
end