class Restaurant < User
  self.table_name = 'restaurants'
  # Relationships
  has_many :menu_items

  # Validations
  validates_uniqueness_of :name, scope: %i[address], message: 'This restaurant is already listed under the same address'
end
