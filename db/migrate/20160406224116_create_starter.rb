class CreateStarter < ActiveRecord::Migration
  def self.up
    create_table :collections do |t|
      t.string   :name
      t.timestamps
    end
    
    create_table :enclosures do |t|
      t.string   :filename
      t.integer  :ied_record_id
      t.string   :caption
      t.timestamps
    end
    
    create_table :eppi_breviates do |t|
      t.string   :title
      t.integer  :volume_id
      t.string   :name
      t.string   :year
      t.string   :keywords
      t.timestamps
    end
    
    create_table :eppi_doctypes do |t|
      t.string   :name
      t.timestamps
    end
    
    create_table :eppi_documents do |t|
      t.string   :paper_no
      t.string   :authoritative_ref
      t.string   :title_actual
      t.string   :corp_authors
      t.string   :personal_author
      t.string   :publisher
      t.string   :breviate_page
      t.string   :tables
      t.string   :series
      t.string   :chairman
      t.string   :abstract
      t.string   :pages_sectioned
      t.string   :held_by
      t.string   :additional_components
      t.string   :start_page
      t.string   :vol
      t.string   :subvol_arabic
      t.integer  :eppi_lc_subject_id
      t.string   :published
      t.string   :appointed
      t.string   :source
      t.integer  :eppi_session_id
      t.integer  :eppi_doctype_id
      t.integer  :eppi_breviate_id
      t.timestamps
    end
    
    add_index :eppi_documents, [:authoritative_ref], name: :index_eppi_documents_on_authoritative_ref
    add_index :eppi_documents, [:eppi_breviate_id], name: :index_eppi_documents_on_eppi_breviate_id
    add_index :eppi_documents, [:eppi_doctype_id], name: :index_eppi_documents_on_eppi_doctype_id
    add_index :eppi_documents, [:eppi_lc_subject_id], name: :index_eppi_documents_on_eppi_lc_subject_id
    add_index :eppi_documents, [:eppi_session_id], name: :index_eppi_documents_on_eppi_session_id
    add_index :eppi_documents, [:paper_no], name: :index_eppi_documents_on_paper_no
    
    create_table :eppi_keywords do |t|
      t.string   :name
      t.timestamps
    end
    
    create_table :eppi_lc_subjects do |t|
      t.string   :name
      t.integer  :lft
      t.integer  :rgt
      t.integer  :parent_id
      t.string   :full_name
      t.timestamps
    end
    
    create_table :eppi_pages do |t|
      t.integer  :eppi_document_id
      t.integer  :ordinal
      t.text     :content
      t.timestamps
    end
    
    add_index :eppi_pages, [:eppi_document_id], name: :index_eppi_pages_on_eppi_document_id
    
    create_table :eppi_sessions do |t|
      t.string :from
      t.string :to
    end
    
    create_table :eppi_volumes do |t|
      t.string   :name
      t.timestamps
    end
    
    create_table :ied_cat_files do |t|
      t.string   :filename
      t.string   :filesize
      t.string   :ied_cat_files, limit: 4
      t.string   :description
      t.string   :string
      t.integer  :category_id
      t.integer  :integer
      t.timestamps
    end
    
    create_table :ied_catalogues do |t|
      t.string   :title
      t.string   :source
      t.string   :archive
      t.string   :serial
      t.string   :catdate
      t.string   :tags
      t.string   :transcript
      t.timestamps
    end
    
    create_table :ied_categories do |t|
      t.string   :code
      t.string   :name
      t.string   :reference
      t.string   :description
      t.boolean  :show, default: true
      t.timestamps
    end
    
    create_table :ied_enclosures do |t|
      t.string   :ied_record_id
      t.string   :filename
      t.string   :label
      t.string   :image_file_name
      t.string   :image_content_type
      t.integer  :image_file_size
      t.datetime :image_updated_at
      t.timestamps
    end
    
    create_table :ied_institutions do |t|
      t.string   :name
      t.timestamps
    end
    
    create_table :ied_pages do |t|
      t.integer  :document_id
      t.integer  :ordinal
      t.text     :content
      t.timestamps
    end
    
    create_table :ied_records do |t|
      t.string   :uuid
      t.integer  :someid
      t.string   :name
      t.string   :srcdoc
      t.string   :source
      t.string   :somenum
      t.string   :somenum2
      t.string   :added
      t.string   :chapcode
      t.text     :transcript
      t.integer  :institution_id
      t.integer  :ied_chapter_id
      t.string   :ied_chapcode
      t.date     :timestamp
      t.string   :archive
      t.string   :serial
      t.string   :recorddate
      t.string   :recordlog
      t.string   :recordtype
      t.string   :catid
      t.string   :partialdate
      t.timestamps
    end
    
    create_table :interviews do |t|
      t.string   :name
      t.text     :summary
      t.integer  :denomination_id
      t.integer  :gender_id
      t.integer  :place_of_birth
      t.integer  :residence
      t.integer  :childhood_residence
      t.string   :duration
      t.datetime :timestamp
      t.integer  :age_group_id
      t.timestamps
    end
    
    create_table :pages do |t|
      t.integer :document_id,      limit: 3, null: false
      t.integer :ordinal,          limit: 2
      t.text    :content,          limit: 16777215
      t.integer :chapter_id,       limit: 3
      t.string  :record_id,        limit: 100
      t.text    :clean_content,    limit: 16777215
      t.integer :eppi_document_id
    end
    
    add_index :pages, [:document_id], name: :document_id
    
    create_table :sites do |t|
      t.string   :subdomain
      t.string   :title
      t.string   :short_title
      t.integer  :position
      t.timestamps
    end
    
    create_table :summary_documents do |t|
      t.string   :title
      t.integer  :source_id
      t.string   :source_type
      t.integer  :boost
      t.timestamps
    end
    
    create_table :vmr_age_groups do |t|
      t.string   :name
      t.timestamps
    end
    
    create_table :vmr_decades do |t|
      t.string   :name
      t.timestamps
    end
    
    create_table :vmr_denominations do |t|
      t.string   :name
      t.timestamps
    end
    
    create_table :vmr_destinations do |t|
      t.integer  :place_id
      t.integer  :position
      t.integer  :vmr_interview_id
      t.timestamps
    end
    
    create_table :vmr_emigrations do |t|
      t.integer  :vmr_interview_id
      t.integer  :vmr_decade_id
      t.timestamps
    end
    
    create_table :vmr_genders do |t|
      t.string   :name
      t.timestamps
    end
    
    create_table :vmr_interviews do |t|
      t.string   :code
      t.text     :summary
      t.integer  :vmr_denomination_id
      t.integer  :vmr_gender_id
      t.integer  :birthplace_id
      t.integer  :residence_id
      t.integer  :childhood_residence_id
      t.string   :duration
      t.date     :date
      t.integer  :vmr_age_group_id
      t.timestamps
    end
    
    create_table :vmr_keywords do |t|
      t.string   :name
      t.timestamps
    end
    
    create_table :vmr_returns do |t|
      t.integer  :vmr_interview_id
      t.integer  :vmr_decade_id
      t.timestamps
    end
    
    create_table :vmr_tracks do |t|
      t.integer  :track_id
      t.integer  :track_no
      t.string   :duration
      t.string   :keywords
      t.integer  :vmr_interview_id
      t.string   :keywordstr
      t.string   :durationstr
      t.timestamps
    end
  end

  def self.down
    drop_table :collections
    drop_table :enclosures
    drop_table :eppi_breviates
    drop_table :eppi_doctypes
    drop_table :eppi_documents
    drop_table :eppi_keywords
    drop_table :eppi_lc_subjects
    drop_table :eppi_pages
    drop_table :eppi_sessions
    drop_table :eppi_volumes
    drop_table :ied_cat_files
    drop_table :ied_catalogues
    drop_table :ied_categories
    drop_table :ied_enclosures
    drop_table :ied_institutions
    drop_table :ied_pages
    drop_table :ied_records
    drop_table :interviews
    drop_table :pages
    drop_table :sites
    drop_table :summary_documents
    drop_table :vmr_age_groups
    drop_table :vmr_decades
    drop_table :vmr_denominations
    drop_table :vmr_destinations
    drop_table :vmr_emigrations
    drop_table :vmr_genders
    drop_table :vmr_interviews
    drop_table :vmr_keywords
    drop_table :vmr_returns
    drop_table :vmr_tracks
  end
end
