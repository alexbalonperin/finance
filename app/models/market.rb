class Market < ActiveRecord::Base
  belongs_to :country

  validates :name, :country, presence: true

  def country_name
    country.name
  end

  def country_code
    country.code
  end

end
