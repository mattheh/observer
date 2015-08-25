class Post < ActiveRecord::Base
  belongs_to :user

  before_create do
    self.active = true
  end
end
