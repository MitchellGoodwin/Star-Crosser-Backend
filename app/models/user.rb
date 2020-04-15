class User < ApplicationRecord
    include Rails.application.routes.url_helpers
    has_secure_password
    acts_as_mappable :auto_geocode=>{:field=>:location, :error_message=>'Could not geocode address'}
    validates :email, uniqueness: { case_sensitive: false }

    belongs_to :sun_sign

    has_one_attached :image

    has_many :liked_users, foreign_key: :liker_id, class_name: 'Like'
    has_many :likees, through: :liked_users

    has_many :liking_users, foreign_key: :likee_id, class_name: 'Like'
    has_many :likers, through: :liking_users

    has_many :matches, foreign_key: :user1_id
    has_many :matched_users, through: :matches

    has_many :messages_sent, foreign_key: :sender_id, class_name: 'Message'
    has_many :messaged_users, through: :messages_sent

    has_many :messages_received, foreign_key: :receiver_id, class_name: 'Message'
    has_many :messaging_users, through: :messages_received

    has_many :notifications, foreign_key: :recipient_id

    def find_sun_sign
        birth_month = Date::MONTHNAMES[self.birthDate.split('-')[1].to_i]
        birth_day = self.birthDate.split('-')[2].to_i
        SunSign.all.select{|sign| (sign.sun_dates[0].split(' ')[0] === birth_month &&  sign.sun_dates[0].split(' ')[1].to_i <= birth_day) || (sign.sun_dates[1].split(' ')[0] === birth_month &&  sign.sun_dates[1].split(' ')[1].to_i > birth_day)}[0]
    end

    def image_url
        if self.image.attached?
            return url_for(self.image)
        else
            return self.picture
        end
    end

    def element
        self.sun_sign.element
    end

    def sun_sign_name
        self.sun_sign.name
    end

    def sun_sign_image
        self.sun_sign.image_url
    end

    def get_age
        birth_day = self.birthDate.split('-')[2].to_i
        birth_month = self.birthDate.split('-')[1].to_i
        birth_year = self.birthDate.split('-')[0].to_i
        now = Time.now.utc.to_date
        self.age = now.year - birth_year - ((now.month > birth_month || (now.month == birth_month && now.day >= birth_day)) ? 0 : 1)
        self.save
    end


    def gender_filtered_users(users=User.all)
        filtered_users = users.select{|user| (self.lookingFor == 'either' || user.gender == self.lookingFor) && (user.lookingFor == self.gender || user.lookingFor == 'either')}
    end

    def filter_sun_compatibility(users=self.gender_filtered_users)
        users.select{|user| self.sun_sign.compatibility.include?(user.sun_sign.name)}
    end

    def filter_age(users, max, min=18)
        users.select{|user| user.age >= min && user.age <= max}
    end

    def geocode_address
        geo=Geokit::Geocoders::GoogleGeocoder.geocode (location)
        errors.add(:address, "Could not Geocode address") if !geo.success
        self.lat, self.lng = geo.lat,geo.lng if geo.success
        self.save
    end

    def self.update_lats
        self.all.each do |user|
            user.geocode_address
            user.save
        end
    end
end
