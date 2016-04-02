namespace :populate do

  def companies
    yahoo_client = YahooFinance::Client.new
    nyse_companies = yahoo_client.companies_by_market('us', 'nyse')
    nasdaq_companies = yahoo_client.companies_by_market('us', 'nasdaq')
    amex_companies = yahoo_client.companies_by_market('us', 'amex')
    nyse_companies + nasdaq_companies + amex_companies
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

end
