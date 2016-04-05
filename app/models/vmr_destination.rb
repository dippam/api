class VmrDestination < ActiveRecord::Base
  belongs_to :place
  belongs_to :vmr_interview
end
