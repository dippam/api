class EppiDocumentsController < ApplicationController
  def index
    params ||= { q: '', qclean: '', page: 1, sort: :title_actual,
                 sort_dir: :asc, cat: { '0' => 'on' }, fields: :titles }

    # Override sort when chronologic checkbox ticked.
    params.merge!({ sort: :session, sort_dir: :asc}) if params[:chrono].present?

    @results = EppiDocument.do_search params
    @doctypes = EppiDoctype.order :name
    
    respond_to do |f|
      f.html
      f.results
      f.facets
      f.json { render json: @results }
    end
  end

  def show
    q = params[:q] || ''
    @document = EppiDocument.find params[:id]
    @results = EppiPage.search do
      keywords q { highlight :content }
      with :eppi_document_id, params[:id]
    end

    respond_to do |f|
      f.html
      f.txt
    end
  end
end
