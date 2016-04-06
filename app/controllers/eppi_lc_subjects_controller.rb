class EppiLcSubjectsController < ApplicationController
  def index
    @eppi_lc_subjects = EppiLcSubject.order :full_name
  end
end
