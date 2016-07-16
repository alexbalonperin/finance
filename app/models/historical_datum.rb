class HistoricalDatum < ActiveRecord::Base
  belongs_to :company

  validates :company, :trade_date, :open, :high, :low, :close, :volume, :adjusted_close, presence: true

  def trade_date_as_timestamp
    d = trade_date
    date = Date.new(d.year, d.month, d.day)
    date.to_time.to_i * 1000
  end
end
