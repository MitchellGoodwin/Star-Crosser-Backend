class SunSign < ApplicationRecord
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

    has_many :users
end
