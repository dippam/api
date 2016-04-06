class IedCategoriesController < ApplicationController
  def index
    @categories = IedCategory.paginate page: params[:page], order: :name
  end

  def show
    @category = IedCategory.find params[:id]
    @records = @category.records.paginate page: params[:page], order: :timestamp
  end
end
