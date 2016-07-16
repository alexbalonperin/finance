class Market < ActiveRecord::Base
  belongs_to :country

  validates :name, :country, presence: true

end
