class Country < ActiveRecord::Base
  validates :name, :code, presence: true
end
