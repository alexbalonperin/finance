FactoryGirl.define do
  sequence :company_name do |n|
    "#{Faker::Company.name}#{n}"
  end

  sequence :industry_name do |n|
    "#{Faker::Company.profession}#{n}"
  end

  sequence :sector_name do |n|
    "#{Faker::Commerce.department}#{n}"
  end

  sequence :country_name do |n|
    "#{Faker::Address.country}#{n}"
  end
end