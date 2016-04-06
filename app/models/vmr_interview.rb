class VmrInterview < ActiveRecord::Base
  belongs_to :vmr_denomination
  belongs_to :vmr_gender
  belongs_to :vmr_age_group
  belongs_to :childhood_residence, class_name: 'Place', foreign_key: 'childhood_residence_id'
  belongs_to :residence, class_name: 'Place', foreign_key: 'residence_id'
  belongs_to :birthplace, class_name: 'Place', foreign_key: 'birthplace_id'
  has_many :vmr_tracks
  has_many :vmr_returns
  has_many :vmr_emigrations
  has_many :vmr_destinations
  has_one :summary_document, as: :source

  searchable do
    text :summary
    text :keywords
    text :destination_list
    string :code
    #integer :vmr_destination_ids, multiple: true { vmr_destinations.map(&:place_id).uniq }
    #integer :vmr_emigration_ids, multiple: true { vmr_emigrations.map(&:vmr_decade_id).uniq }
    #integer :vmr_return_ids, multiple: true { vmr_returns.map(&:vmr_decade_id).uniq }
    integer :birthplace_id
    integer :residence_id
    integer :childhood_residence_id
    integer :vmr_denomination_id
    integer :vmr_gender_id
    integer :vmr_age_group_id
  end 
  
  def self.do_search(p)
    search do
      keywords p['q'], highlight: true unless p['q'].size < 3
      with :vmr_destination_ids, p['vmr_destination_id'] if p['vmr_destination_id'].present?
      with :vmr_emigration_ids, p['vmr_emigration_id'] if p['vmr_emigration_id'].present?
      with :vmr_return_ids,  p['vmr_return_id'] if p['vmr_return_id'].present?
      with :birthplace_id, p['birthplace_id'] if p['birthplace_id'].present?
      with :childhood_residence_id, p['childhood_residence_id'] if p['childhood_residence_id'].present?
      with :residence_id, p['residence_id'] if p['residence_id'].present?
      with :vmr_denomination_id, p['vmr_denomination_id'] if p['vmr_denomination_id'].present?
      with :vmr_gender_id, p['vmr_gender_id'] if p['vmr_gender_id'].present?
      with :vmr_age_group_id, p['vmr_age_group_id'] if p['vmr_age_group_id'].present?
      order_by p['sort'], p['sort_dir']
      paginate :page => p['page'], :per_page => p['per_page']
    end
  end

  def length
    vmr_tracks.sum('durationstr')
  end

  def keywords
    vmr_tracks.empty? ? '' :
      vmr_tracks.map{|x| x.keywords[48..-5].split(',')}.flatten!.map{|x| x.strip}.uniq.join(', ') 
  end

  def content
    [keywords, destination_list, summary].join(' ')
  end

  def destination_list
    vmr_destinations.map{|x| x.place.name}.to_sentence
  end

  def name
    "#{code} #{destination_list}"
  end

  def self.all_birthplaces
    #    Place.find(VmrInterview.select("DISTINCT(birthplace_id)").map(&:birthplace_id), order: :name)
    []
  end

  def self.all_childhood_residences
    #   Place.find(VmrInterview.select("DISTINCT(childhood_residence_id)").map(&:childhood_residence_id), order: :name)
    []
  end

  def self.all_residences
    #  Place.find(VmrInterview.select("DISTINCT(residence_id)").map(&:residence_id), order: :name)
    []
  end

  def self.all_destinations
    # Place.find(VmrDestination.all.map(&:place_id).uniq, order: :name)
    []
  end
  
  def self.all_emigrations
    # VmrDecade.find(VmrEmigration.all.map(&:vmr_decade_id).uniq, order: :name)
    []
  end
  
  def self.all_returns
    # VmrDecade.find(VmrReturn.all.map(&:vmr_decade_id).uniq, order: :name)
    []
  end
end
