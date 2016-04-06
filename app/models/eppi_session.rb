class EppiSession < ActiveRecord::Base
  has_many :eppi_documents
  
  def name
    str = from
    str += '-' + to unless to.nil?
    str
  end
  
  def self.earliest
    minimum :from
  end
  
  def self.latest
    maximum :to
  end
end