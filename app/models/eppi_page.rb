class EppiPage < ActiveRecord::Base
  belongs_to :eppi_document

  searchable do
    text :content, stored: true
    integer :eppi_document_id
    integer :ordinal
  end

  def img_src
    "/images/pages/#{"%08d" % ordinal}.jpg"
  end
end
