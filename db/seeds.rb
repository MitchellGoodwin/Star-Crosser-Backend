# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

require 'rest-client'

require 'faker'

require 'geokit'


# puts 'getting data'

# resp = RestClient.get 'https://zodiacal.herokuapp.com/api'

# puts 'converting data'

# data = JSON.parse(resp)


# puts 'seeding signs'

# data.each do |sign|
#     SunSign.create(
#         name: sign['name'],
#         wish: sign['secret_wish'],
#         hates: sign['hates'],
#         bad_traits: sign['bad_traits'],
#         good_traits: sign['good_traits'],
#         favorites: sign['favorites'],
#         planet: sign['ruling_planet'],
#         symbol: sign['symbol'],
#         keywords: sign['keywords'],
#         vibe: sign['vibe'],
#         compatibility: sign['compatibility'],
#         mental_traits: sign['mental_traits'],
#         physical_traits: sign['physical_traits'],
#         sun_dates: sign['sun_dates'],
#         element: sign['element']
#     )
# end

# data.each do |sign|
#     oldsign = SunSign.find_by(name: sign['name'])
#     oldsign.compatibility = sign['compatibility']
#     oldsign.save
# end

# SunSign.all.each do |sign| 
#     filepath = "zodiac_images/#{sign.name.downcase}.jpg"
#     filename = "#{sign.name.downcase}.jpg"
#     sign.image.attach(io: File.open(filepath), filename: filename, content_type: 'application/jpg') 
# end

puts 'getting data'

resp = RestClient.get 'https://randomuser.me/api/?nat=us&results=5000'

puts 'converting data'

data = JSON.parse(resp)['results']

lookingForArray = ['male', 'female', 'either']

data.each do |person|
    user = User.new(
        email: person['email'],
        password: person['login']['password'],
        firstName: person['name']['first'],
        lastName: person['name']['last'],
        location: "#{person['location']['city']}, #{person['location']['state']}, #{person['location']['country']}",
        age: person['dob']['age'],
        birthDate: person['dob']['date'].split('T')[0],
        picture: person['picture']['large'],
        gender: person['gender'],
        lookingFor: lookingForArray.sample(),
        bioGeneral: Faker::Lorem.paragraph,
        bioIntro: Faker::Lorem.paragraph,
        bioFood: Faker::Lorem.paragraph,
        bioMovies: Faker::Lorem.paragraph,
        bioMusic: Faker::Lorem.paragraph,
        bioBooks: Faker::Lorem.paragraph,
        bioActivities: Faker::Lorem.paragraph,
        bioGoals: Faker::Lorem.paragraph
    )
    if user.age <= 35
        user.sun_sign = user.find_sun_sign
        user.geocode_address
        user.save
    end
end