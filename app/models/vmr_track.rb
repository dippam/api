class VmrTrack < ActiveRecord::Base
  belongs_to :vmr_interview
  
  def filename
    vmr_interview.code
  end
end
