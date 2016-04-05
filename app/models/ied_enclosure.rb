class IedEnclosure < ActiveRecord::Base
  belongs_to :ied_record
  has_attached_file :image, styles: { medium: "300x300>", thumb: "100x100>" }
end
