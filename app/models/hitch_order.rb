# frozen_string_literal: true

class HitchOrder < ApplicationRecord
  belongs_to :hitch
  belongs_to :order
end
