class VmrEmigration < ActiveRecord::Base
  belongs_to :vmr_interview
  belongs_to :vmr_decade
end
