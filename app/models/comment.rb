class Comment < ActiveRecord::Base
  belongs_to :record, foreign_key: :record_id,  class_name: 'IedRecord'
  belongs_to :user
end
