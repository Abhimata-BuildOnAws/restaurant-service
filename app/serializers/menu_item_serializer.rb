# frozen_string_literal: true

class MenuItemSerializer
  include JSONAPI::Serializer

  attributes :id, :name, :description, :price

  attribute :image_url do |item|
    item.image.url
  end
end