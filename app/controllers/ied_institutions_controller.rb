class IedInstitutionsController < ApplicationController
  def index
    @archives = IedInstitution.all
  end
  
  def show
    @institution = IedInstitution.find params[:id]
  end
end
