class EppiBreviate < ActiveRecord::Base
  belongs_to :eppi_volume
  has_many :eppi_documents
  paginate_alphabetically by: :name
end
