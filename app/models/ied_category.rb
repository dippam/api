class IedCategory < ActiveRecord::Base
  versioned
  has_many :records, class_name: 'IedRecord', foreign_key: :ied_chapter_id

  validates_presence_of :code, :name, :reference, :description
  validates_uniqueness_of :code, :name, :reference, :description
  validates_numericality_of :code
end
