class Match < ApplicationRecord
    belongs_to :user, :foreign_key => "user1_id", :class_name => "User"
    belongs_to :matched_user, :foreign_key => "user2_id", :class_name => "User" 

    after_create :create_inverse

    def create_inverse
        self.class.create(user1_id: self.matched_user.id, user2_id: self.user.id)
    end

    validates_uniqueness_of :user1_id, scope: :user2_id
end
