class Industry < ActiveRecord::Base
  belongs_to :sector
  has_many :companies

  validates :name, :sector, presence: true

  def sector_name
    sector.name
  end

end
