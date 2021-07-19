# frozen_string_literal: true

Geocoder.configure(
  bing: {
    api_key: ENV['BING_MAPS_KEY']
  },
  abstract_api: {
    api_key: ENV['1eb3887453fc4402b589e6941c03e36b']
  }
)
