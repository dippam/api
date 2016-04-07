class AddSessionToEppiDocuments < ActiveRecord::Migration
  def change
    add_column :eppi_documents, :session, :string
  end
end
