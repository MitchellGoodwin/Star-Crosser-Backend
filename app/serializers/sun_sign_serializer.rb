class SunSignSerializer < ActiveModel::Serializer
  attributes :id, :name, :wish, :hates, :bad_traits, :good_traits, :favorites, :planet, :symbol, :keywords, :vibe, :compatibility, :mental_traits, :physical_traits, :sun_dates, :element, :image_url
end
