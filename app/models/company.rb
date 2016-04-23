class Company < ActiveRecord::Base
  belongs_to :industry
  has_one :sector, :through => :industry
  has_many :historical_data

  def to_json
    {
        :id => id,
        :symbol => symbol,
        :name => name,
        :industry => industry.name,
        :sector => sector.name
    }
  end
end
