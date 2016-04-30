class Company < ActiveRecord::Base
  belongs_to :industry
  has_one :sector, :through => :industry
  has_many :historical_data
  has_many :subsidiaries_mergers, :class_name => 'Merger', :foreign_key => :acquiring_id
  has_one :parent_merger, :class_name => 'Merger', :foreign_key => :acquired_id
  has_one :parent, :through => :parent_merger, :source => :acquiring
  has_many :subsidiaries, :through => :subsidiaries_mergers, :source => :acquired
  has_many :companies_changes_from, :class_name => 'CompaniesChange', :foreign_key => :from_id
  has_many :companies_changes_to, :class_name => 'CompaniesChange', :foreign_key => :to_id

  def to_json
    {
        :id => id,
        :symbol => symbol,
        :name => name,
        :industry => industry.name,
        :sector => sector.name,
        :industry_id => industry_id,
        :sector_id => sector.id,
        :delisted => delisted,
        :inactive => !active,
        :liquidated => liquidated,
        :merged => parent.present?,
        :changed => companies_changes_from.present?
    }
  end
end
