class Merger < ActiveRecord::Base
  belongs_to :acquired, :class_name => 'Company', :foreign_key => :acquired_id
  belongs_to :acquiring, :class_name => 'Company', :foreign_key => :acquiring_id
end