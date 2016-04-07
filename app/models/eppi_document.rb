class EppiDocument < ActiveRecord::Base
  has_many   :eppi_pages
  has_one :summary_document, as: :source
  belongs_to :eppi_lc_subject
  belongs_to :eppi_doctype
  belongs_to :eppi_breviate
  belongs_to :eppi_session

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
      
      with(:session).greater_than p[:from] if p[:from].present?
      with(:session).less_than p[:to] if p[:to].present?
      with(:eppi_doctype_id, p[:cat].keys) unless p[:cat].key? '0'
      order_by p[:sort], p[:sort_dir]
      paginate page: p[:page], per_page: p[:per_page]
      facet :session
      facet :eppi_doctype_id
    end
  end

  def num_pages; eppi_pages.size; end
  def content; eppi_pages.map(&:content).join; end
  def title; eppi_breviate.title; end

  # Return the document code.
  # Code formats vary over the years and also on source.
  def code
    return "#{source} #{session} (#{paper_no}) #{vol} #{start_page}" if source != 'CMD'
    
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
    dict = { M: 1000, CM: 900, D: 500, CD: 400, C: 100, XC: 90,
             L: 50, XL: 40, X: 10, IX: 9,  V: 5, IV: 4, I: 1 };
    input, output = vol.to_i, ''

    dict.each_pair do |r, a|
      while input >= a do
        input -= a; output << r.to_s
      end
    end
    
    output
  end
end
