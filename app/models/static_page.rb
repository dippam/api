class StaticPage < ActiveRecord::Base
  has_friendly_id :title, use_slug: true

  def show
    @static_page = StaticPage.find params[:id]
  end 
end
