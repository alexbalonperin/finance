namespace :populate do

  def companies
    yahoo_client = YahooFinance::Client.new
    nyse_companies = yahoo_client.companies_by_market('us', 'nyse')
    nasdaq_companies = yahoo_client.companies_by_market('us', 'nasdaq')
    amex_companies = yahoo_client.companies_by_market('us', 'amex')
    nyse_companies + nasdaq_companies + amex_companies
  end

  def historical_data(companies)
    yahoo_client = YahooFinance::Client.new
    companies.inject({}) do |h, company|
      puts "Getting historical data for : #{company.name}"
      begin
        h[company.id] = yahoo_client.historical_quotes(company.symbol)
      rescue StandardError => e
        puts "Couldn't fetch data for company #{company.name}. Error: #{e.message}"
      end
      h
    end
  end

  company_to_industry = lambda do |company|
    sector = Sector.find_by_name(company.sector)
    if sector.nil?
      puts "Couldn't find sector '#{company.sector}. Please update the sector first"
      return
    end
    Industry.new(:sector_id => sector.id, :name => company.industry)
  end

  class BulkUpdater
    def self.update(klass, records)
      records.each do |rec|
        if rec.save
          puts "#{klass} '#{rec.name}' saved to database"
        else
          puts "Couldn't save #{klass.downcase} '#{rec.name}''"
        end
      end
    end
  end

  desc 'populate the database with all entities'
  task all: :environment do
    Rake::Task['sectors'].invoke
    Rake::Task['industries'].invoke
    Rake::Task['companies'].invoke
  end

  desc 'populate the database with a list of sectors from the web'
  task sectors: :environment do
    sectors = Sector.select(:name)
    missing_companies = companies.reject { |company| sectors.include?(company.sector) }
    missing_sectors = missing_companies.map { |company| Sector.new(:name => company.sector) }.uniq(&:name)
    BulkUpdater.update(Sector, missing_sectors)
  end

  desc 'populate the database with a list of industries from the web'
  task industries: :environment do
    industries = Industry.select(:name)
    missing_companies = companies.reject { |company| industries.include?(company.industry) }
    missing_industries = missing_companies.map(&company_to_industry).uniq(&:name)
    BulkUpdater.update(Industry, missing_industries)
  end

  desc 'populate the database with a list of companies from the web'
  task companies: :environment do
    cur_companies = Company.select(:name)
    company_to_company = lambda { |company| Company.new(:industry => Industry.find_by_name(company.industry), :name => company.name, :symbol => company.symbol) }
    missing_companies = companies.reject { |company| cur_companies.include?(company.name) }
    missing_companies = missing_companies.map(&company_to_company).uniq(&:name)
    BulkUpdater.update(Company, missing_companies)
  end

  desc 'populate the database with historical data for all companies in the database'
  task historical_data: :environment do
    companies = Company.
        joins('left join historical_data hd on hd.company_id = companies.id').
        where('hd.id is null').limit(1000)
    companies.each_slice(50) do |batch|
      historical_data(batch).each do |company_id, records|
        records.each do |record|
          h = HistoricalDatum.new
          h.trade_date = record.trade_date
          h.open = record.open
          h.high = record.high
          h.low = record.low
          h.close = record.close
          h.volume = record.volume
          h.adjusted_close = record.adjusted_close
          h.company_id = company_id
          unless h.save
            puts "Couldn't save historical data for company : #{company_id}"
          end
        end
      end
    end
  end
end
