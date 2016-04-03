class Company < ActiveRecord::Base
  belongs_to :industry
  has_one :sector, :through => :industry
end
