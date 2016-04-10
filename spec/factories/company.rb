FactoryGirl.define do
  factory :company do
    industry
    name {generate(:company_name)}
    symbol 'MSFT'
    created_at Time.now
    updated_at Time.now
  end
end