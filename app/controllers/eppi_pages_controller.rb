class EppiPagesController < ApplicationController
  def index
    @pages = EppiPage.where 'eppi_document_id = ?', params[:document_id]
  end
  
  def show
    @page = EppiPage.find params[:id]
    @cp = @page.ordinal
    @doc = @page.eppi_document
  end
  
  def download
    @page = EppiPage.find params[:id]
    send_file "/#{@page.eppi_document.authoritative_ref}/#{"%08d" % @page.ordinal}.jpg"
  end
end
