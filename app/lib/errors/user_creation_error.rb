class UserCreationError < StandardError
  def message
    'There was a problem creating this User'
  end
end