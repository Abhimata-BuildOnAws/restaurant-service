# frozen_string_literal: true

Geocoder.configure(
  units: :km,
  bing: {
    api_key: ENV['BING_MAPS_KEY']
  },
  abstract_api: {
    api_key: ENV['ABSTRACT_API_KEY']
  }
)
