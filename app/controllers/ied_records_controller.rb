class IedRecordsController < ApplicationController
  def index
    params ||= { q: '', page: 1, sort: 'timestamp',
                 cat: {'0' => 'on'}, sort_dir: :asc, 
                 start: "1/1/#{IedRecord.earliest.year}", 
                 end: "31/12/#{IedRecord.latest.year}", 
                 page: 1, per_page: 15, exact: true
    }
    @results = IedRecord.do_search params
    @facets  = IedCategory.where('ied_categories.show = ?', true).order(:name)

    respond_to  do |f|
      f.html
      f.results
      f.facets
    end
  end

  def show
    @record = IedRecord.find params[:id]
    @hits = IedRecord.do_search(params.merge({ page: 1, per_page: 1000 })).hits.map(&:primary_key)
    @position = @hits.index @record.id.to_s
    
    render 'transcript' if request.url.match /\.transcript$/
  end
end
