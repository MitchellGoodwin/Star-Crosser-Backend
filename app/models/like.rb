class Like < ApplicationRecord
    belongs_to :likee, :foreign_key => "likee_id", :class_name => "User"
    belongs_to :liker, :foreign_key => "liker_id", :class_name => "User" 

    validates_uniqueness_of :likee_id, scope: :liker_id
end
