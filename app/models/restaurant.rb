class Restaurant < User
  # attr_accessor :id, :name, :street, :state, :country, :contact_no, :stripe_id, :latitude, :longitude

  self.table_name = 'restaurants'

  # Relationships
  has_many :menu_items

  # Validations
  validates_uniqueness_of :name, scope: %i[street], message: 'This restaurant is already listed under the same address'
end
