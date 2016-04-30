class CompaniesChange < ActiveRecord::Base
  belongs_to :from, :class_name => 'Company', :foreign_key => :from_id
  belongs_to :to, :class_name => 'Company', :foreign_key => :to_id
end