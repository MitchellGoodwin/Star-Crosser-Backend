class FastUserSerializer
    include FastJsonapi::ObjectSerializer

    attributes :id, :email, :firstName, :lastName, :location, :age, :birthDate, :picture, :gender, :lookingFor, :sun_sign_id, :bioIntro, :bioGeneral, :bioFood, :bioMusic, :bioMovies, :bioBooks, :bioActivities, :bioGoals, :image_url, :element, :sun_sign_name
    belongs_to :sun_sign
end