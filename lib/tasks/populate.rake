namespace :populate do

  def companies
    nyse_companies = get_companies('us', 'nyse')
    nasdaq_companies = get_companies('us', 'nasdaq')
    amex_companies = get_companies('us', 'amex')
    nyse_companies + nasdaq_companies + amex_companies
  end

  def get_companies(country, market_name)
    client.companies_by_market(country, market_name)
  end

  def client
    @client ||= YahooFinance::Client.new
  end

  def historical_data(companies)
    yahoo_client = YahooFinance::Client.new
    companies.inject({}) do |h, company|
      puts "Getting historical data for : #{company.name}"
      begin
        h[company.id] = yahoo_client.historical_quotes(company.symbol)
      rescue StandardError => e
        puts "Couldn't fetch data for company #{company.name}. Error: #{e.message}"
        company.update(:skip_historical_data => true)
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

  desc 'set market to company'
  task markets: :environment do
    Market.select(:name).map(&:name).each do |name|
      nyse_companies = get_companies('us', name.downcase)
      puts "Number of companies on the #{name} market: #{nyse_companies.size}."
      companies = Company.where("market_id is null and symbol in ('#{nyse_companies.map{|c| c.symbol.strip }.join("', '")}')")
      puts "Found #{companies.size} companies to update."
      companies.update_all(:market_id => Market.find_by_name(name).id)
      puts "Done adding market to companies in #{name}."
    end
    puts 'DONE'
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
    cur_companies = Company.select(:name).map(&:name)
    company_to_company = lambda { |company| Company.new(:industry => Industry.find_by_name(company.industry), :name => company.name, :symbol => company.symbol) }
    missing_companies = companies.reject { |company| cur_companies.include?(company.name) }
    missing_companies = missing_companies.map(&company_to_company).uniq(&:name)
    next unless missing_companies.size > 0
    puts "Found #{missing_companies.size} companies to add."
    BulkUpdater.update(Company, missing_companies)
  end

  desc 'populate the database with historical data for all companies in the database'
  task historical_data: :environment do
    companies = Company.
        joins('left join historical_data hd on hd.company_id = companies.id').
        where('hd.id is null and skip_historical_data is false').limit(1000)
    companies.each_slice(50) do |batch|
      historical_data(batch).each do |company_id, prices|
        data = prices.inject([]) do |arr, record|
          arr << HistoricalDatum.new(trade_date: record.trade_date,
                                  open: record.open,
                                  high: record.high,
                                  low: record.low,
                                  close: record.close,
                                  volume: record.volume,
                                  adjusted_close: record.adjusted_close,
                                  company_id: company_id)
        end
        HistoricalDatum.import(data)
      end
    end
  end
end
