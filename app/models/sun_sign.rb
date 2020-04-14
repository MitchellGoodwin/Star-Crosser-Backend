class SunSign < ApplicationRecord
    include Rails.application.routes.url_helpers
    serialize :wish,Array
    serialize :hates,Array
    serialize :bad_traits,Array
    serialize :good_traits,Array
    serialize :favorites,Array
    serialize :planet,Array
    serialize :keywords,Array
    serialize :compatibility,Array
    serialize :mental_traits,Array
    serialize :physical_traits,Array
    serialize :sun_dates,Array

    has_one_attached :image

    has_many :users

    def image_url
        if self.image.attached?
            return url_for(self.image)
        end
    end
end
