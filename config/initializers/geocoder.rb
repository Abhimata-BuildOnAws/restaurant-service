Geocoder.configure(lookup: :bing, api_key: ENV['BING_MAPS_KEY'])
Geocoder.configure(ip_lookup: :abstract_api, api_key: ENV['ABSTRACT_API_KEY'])