class SummaryDocumentsController < ApplicationController
  def index
    params ||= { q: '', page: 1, sort: :title, sort_dir: :asc, per_page: 15 }
    @results = SummaryDocument.do_search params
    
    respond_to do |f|
      f.html
      f.results
    end
  end

  def show
    @record = IedRecord.find params[:id]
    @results = IedRecord.do_search params.merge({ per_page: 1000, page: 1 })
    @position = @results.results.index @record
  end
  
  def edit
    @record = Ied::Record.find params[:id]
  end
end
