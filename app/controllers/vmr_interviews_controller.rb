class VmrInterviewsController < ApplicationController
  def index
    params ||= { q: '', page: 1, per_page: 15, sort: :code, sort_dir: :asc, view: :list }
    @results = VmrInterview.do_search params

    respond_to do |f|
      f.html
      f.results
    end
  end
end
