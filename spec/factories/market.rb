FactoryGirl.define do
  factory :market do
    country
    name 'NYSE'
    created_at Time.now
    updated_at Time.now
  end
end