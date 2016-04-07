class AddDoctypeToEppiDocuments < ActiveRecord::Migration
  def change
     add_column :eppi_documents, :doctype, :string
     add_column :eppi_documents, :date_appointed, :string
     add_column :eppi_documents, :lc_subject_heading, :string
     add_column :eppi_documents, :breviate_keywords, :string
     add_column :eppi_documents, :breviate_title, :string
     add_column :eppi_documents, :breviate_volume, :string
     add_column :eppi_documents, :vol_arabic, :string
     add_column :eppi_documents, :session_old, :string
     add_column :eppi_documents, :session_year_from, :string
     add_column :eppi_documents, :session_year_to, :string
     add_column :eppi_documents, :date_published, :string
  end
end
