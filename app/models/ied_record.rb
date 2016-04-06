class IedRecord < ActiveRecord::Base
  belongs_to :ied_institution, foreign_key: :institution_id
  belongs_to :ied_category, foreign_key: :ied_chapter_id
  has_many :ied_enclosures
  has_and_belongs_to_many :places
  has_one :summary_document, as: :source

  searchable do
    text :name, default_boost: 2, stored: true
    text :transcript, stored: true
    time :timestamp
    string :serial
    string :name
    integer :ied_chapter_id
    integer :num_images
  end

  def self.earliest; minimum(:timestamp).strftime('%Y-%m-%d'); end
  def self.latest; maximum(:timestamp).strftime('%Y-%m-%d'); end
  def link; "http://ied.dippam.ac.uk/records/#{id}"; end
  
  def self.do_search params
    search do
      keywords params[:q], highlight: true unless params[:q].size < 3
      with(:ied_chapter_id, params[:cat].keys) if params.key?(:cat) and not params[:cat].key?('0')
      order_by params[:sort], params[:sort_dir] if params.key? :sort_dir
      paginate page: params[:page], per_page: params[:per_page] if params.key? :page
      with(:timestamp).greater_than(Date.parse params[:start]) if params.key? :start
      with(:timestamp).less_than(Date.parse params[:end]) if criteria.key? :end
      keywords ''
      facet :ied_chapter_id
    end
  end

  def citation
    str = name
    if institution_id == 530
      m = source.match /(T|D\.*\ *\d+\/*\d*)/
      str += ' PRONI '
      str += m[1] unless m.nil?
    end
    str += " CMSIED  #{serial}"
    str
  end
end
