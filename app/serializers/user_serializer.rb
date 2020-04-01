class UserSerializer < ActiveModel::Serializer
  attributes :id, :email, :password_digest, :firstName, :lastName, :location, :age, :birthDate, :picture, :gender, :lookingFor, :sunSign_id, :bioIntro, :bioGeneral, :bioFood, :bioMusic, :bioMovies, :bioBooks, :bioActivities, :bioGoals
end
