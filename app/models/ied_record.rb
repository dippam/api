# IedRecord is the main document model of the IED collection.
#
# - IED Records are classified in categories.
# - IED Records have donated/belong to an institution.
# - IED Records may have one or more enclosures (attachments).
class IedRecord < ActiveRecord::Base
  # Associations
  belongs_to :ied_institution, foreign_key: :institution_id
  belongs_to :ied_category, foreign_key: :ied_chapter_id
  has_many :ied_enclosures
  has_one :summary_document, as: :source

  # SOLR indexing
  searchable do
    text :name, default_boost: 2, stored: true
    text :transcript, stored: true
    time :timestamp
    string :serial
    string :name
    integer :ied_chapter_id
    integer :num_images
  end
  
  # Accessor Methods
  def self.earliest; minimum(:timestamp).strftime('%Y-%m-%d'); end
  def self.latest; maximum(:timestamp).strftime('%Y-%m-%d'); end
  def num_images; ied_enclosures.size; end

  # Search customisations - preprocess query, send to SOLR, fetch results.
  def self.do_search params
    search do
      keywords params[:q], highlight: true if params[:q].size > 2
      with(:ied_chapter_id, params[:cat].keys) if params.key?(:cat) and not params[:cat].key?('0')
      order_by params[:sort], params[:sort_dir] if params.key? :sort_dir
      paginate page: params[:page], per_page: params[:per_page] if params.key? :page
      with(:timestamp).greater_than(Date.parse params[:start]) if params.key? :start
      #with(:timestamp).less_than(Date.parse params[:end]) if criteria.key? :end
      keywords ''
      facet :ied_chapter_id
    end
  end

  # Generate citation to be used when referring to this record.
  def citation
    str = name
    if institution_id == 530
      str += ' PRONI '
      m = source.match /(T|D\.*\ *\d+\/*\d*)/
      str += m[1] unless m.nil?
    end
    "#{str} CMSIED  #{serial}"
  end
end
