# An EppiDocument is the core model of the EPPI collection,
# representing an individual document that contains 1+ pages.
#
# - EPPI documents are published in breviates.
# - EPPI documents may be part of a session.
#
# There are four types of EPPI document in the collection:
#
# 1. Account
# 1. Bill
# 1. Command Paper
# 1. Report
#
class EppiDocument < ActiveRecord::Base
  # Associations
  has_many   :eppi_pages
  has_one :summary_document, as: :source
  belongs_to :eppi_lc_subject
  belongs_to :eppi_doctype
  belongs_to :eppi_breviate
  belongs_to :eppi_session

  # Sunspot Indexing
  searchable do
    text :title, stored: true
    string :title
    string :published
    string :session
    text :content
    string :code
    string :source
    integer :eppi_doctype_id
    string :paper_no
    integer :num_pages
  end

  # Preprocess search query and send to SOLR, returning results.
  def self.do_search params
    search do
      if params[:qclean].size == 0 then
        case params[:fields]
        when 'titles' then keywords params[:qclean], fields: :title
        when 'code' then with(:code).starting_with params[:qclean].upcase
        when 'exact_title' then with(:title).starting_with params[:qclean]
        when 'paper_no' then with(:paper_no).starting_with params[:qclean]
        else keywords params[:q]
        end 
      end
      
      with(:session).greater_than params[:from] if params[:from].present?
      with(:session).less_than params[:to] if params[:to].present?
      with(:eppi_doctype_id, params[:cat].keys) unless params[:cat].key? '0'
      order_by params[:sort], params[:sort_dir]
      paginate page: params[:page], per_page: params[:per_page]
      facet :session
      facet :eppi_doctype_id
    end
  end

  # Accessor Methods
  def num_pages; eppi_pages.size; end
  def content; eppi_pages.map(&:content).join; end
  def title; eppi_breviate.title; end

  # Return the document code.
  # Code formats vary over the years and also on source.
  def code
    # Short circuit is this isn't a Command Paper.
    return "#{source} #{session} (#{paper_no}) #{vol} #{start_page}" if source != 'CMD'

    # Paper number prefixes are different for sessions.
    prefix = case session[0..3].to_i
      when 1000..1869 then ''
      when 1870..1899 then 'C.'
      when 1900..1919 then 'Cd.'
      else 'Cmd.'
    end
    
    "HC #{session} [#{prefix}#{paper_no}] #{vol} #{start_page}"
  end

  # Return a URI where the associated PDF can be accessed.
  def pdf_location
    "/pdf/#{authoritative_ref}.pdf" if File.exists? "public/pdf1/#{authoritative_ref}.pdf"
  end

  # Return the volume year in roman numerals.
  def vol_roman
    dict = { M: 1000, CM: 900, D: 500, CD: 400,
             C: 100,  XC: 90,  L: 50,  XL: 40,
             X: 10 ,  IX: 9,   V: 5,   IV: 4,
             I: 1 };
    input, output = vol.to_i, ''

    # Descend through the character list.
    dict.each_pair do |r, a|
      # Subtract from the input/add to the output until
      # this character is no longer useful.
      while input >= a { input -= a; output << r.to_s }
    end
    
    output
  end
end
