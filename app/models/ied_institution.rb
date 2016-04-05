class IedInstitution < ActiveRecord::Base
  has_many :records, class_name: 'IedRecord', foreign_key: :institution_id
  
  validates_presence_of :name
  validates_uniqueness_of :name
end
