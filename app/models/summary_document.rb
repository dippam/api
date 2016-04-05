class SummaryDocument < ActiveRecord::Base
  belongs_to :source, polymorphic: true
  before_save :save_title
  before_create :save_title
  
  searchable do
    string :title, stored: true
    text :body, stored: true
  end

  def self.do_search criteria
    search do
      keywords criteria['q'], highlight: true unless criteria['q'].size < 3
      paginate page: criteria['page'], per_page: 20
    end
  end

  def body
    case source_type
    when 'EppiDocument' then source.content
    when 'IedRecord' then source.transcript
    else source.content
    end
  end

  def save_title
    self.title = (self.source_type == 'EppiDocument') ? 
      self.source.eppi_breviate.title : self.source.name
  end
end
