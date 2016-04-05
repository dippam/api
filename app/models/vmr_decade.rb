class VmrDecade < ActiveRecord::Base
  has_many :vmr_emigrations
  has_many :vmr_returns
end
