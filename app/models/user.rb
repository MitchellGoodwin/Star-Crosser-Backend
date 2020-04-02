class User < ApplicationRecord
    has_secure_password
    validates :email, uniqueness: { case_sensitive: false }

    belongs_to :sun_sign

    has_many :liked_users, foreign_key: :liker_id, class_name: 'Like'
    has_many :likees, through: :liked_users

    has_many :liking_users, foreign_key: :likee_id, class_name: 'Like'
    has_many :likers, through: :liked_users

    has_many :matches
    has_many :matched_users, through: :matches

    has_many :messages_sent, foreign_key: :sender_id, class_name: 'Message'
    has_many :messaged_users, through: :messages_sent

    has_many :messages_received, foreign_key: :receiver_id, class_name: 'Message'
    has_many :messaging_users, through: :messages_received

    def find_sun_sign
        birth_month = Date::MONTHNAMES[self.birthDate.split('-')[1].to_i]
        birth_day = self.birthDate.split('-')[2].to_i
        SunSign.all.select{|sign| (sign.sun_dates[0].split(' ')[0] === birth_month &&  sign.sun_dates[0].split(' ')[1].to_i <= birth_day) || (sign.sun_dates[1].split(' ')[0] === birth_month &&  sign.sun_dates[1].split(' ')[1].to_i > birth_day)}[0]
    end

    def gender_filtered_users
        filtered_users = User.all.select{|user| (self.lookingFor == 'either' || user.gender == self.lookingFor) && (user.lookingFor == self.gender || user.lookingFor == 'either')}
    end

    def filter_sun_compatibility
        self.gender_filtered_users.select{|user| self.sun_sign.compatibility.include?(user.sun_sign.name)}
    end
end