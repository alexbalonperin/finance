class Sector < ActiveRecord::Base
  has_many :industries
  has_many :companies, :through => :industries
end
