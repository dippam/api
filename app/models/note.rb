class Note < ActiveRecord::Base
  acts_as_nested_set
  
  validates_presence_of :title, :body

  def move(dst) 
    (dst == '0') ? move_to_root : move_to_child_of(Note.find(dst))
  end
end
