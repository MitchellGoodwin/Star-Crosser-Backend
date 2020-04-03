class UserSerializer < ActiveModel::Serializer
  attributes :id, :email, :firstName, :lastName, :location, :age, :birthDate, :picture, :gender, :lookingFor, :sun_sign_id, :bioIntro, :bioGeneral, :bioFood, :bioMusic, :bioMovies, :bioBooks, :bioActivities, :bioGoals, :sun_sign
end
