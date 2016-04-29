class Industry < ActiveRecord::Base
  belongs_to :sector
  has_many :companies
end
