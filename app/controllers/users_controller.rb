class UsersController < ApplicationController
    skip_before_action :authorized, only: [:create]
 
    def create
        @user = User.create(user_params)
        @user.sun_sign = @user.find_sun_sign
        @user.location = "#{params[:user][:city]}, #{params[:user][:state]}, #{params[:user][:country]}"
        @user.geocode_address
        @user.picture = 'https://t4.ftcdn.net/jpg/00/64/67/63/240_F_64676383_LdbmhiNM6Ypzb3FM4PPuFP9rHe7ri8Ju.jpg'
        @user.save
        @user.get_age
        if @user.valid?
            @token = encode_token(user_id: @user.id)
            render json: { user: UserSerializer.new(@user), jwt: @token }, status: :created
        else
            render json: { error: 'failed to create user' }, status: :not_acceptable
        end
    end

    def index
        if request.headers['Filter']
            if request.headers['Filter'].include? 'Distance'
                users = User.within(request.headers['Distance'].to_i, :origin => current_user)
            else
                users = User.all
            end
            users = current_user.gender_filtered_users(users)
            if request.headers['Filter'].include? 'Compatability'
                users = current_user.filter_sun_compatibility(users)
            end
            if request.headers['Filter'].include? 'Age'
                users = current_user.filter_age(users, request.headers['AgeMax'].to_i, request.headers['AgeMin'].to_i)
            end
        else
            users = current_user.gender_filtered_users()
        end
            
        render json: FastUserSerializer.new(users.first(100))
    end

    def show
        user = User.find_by(id: params[:id])
        likes = user.liking_users.select{|like| like.liker == current_user}
        matches = user.matches.select{|match| match.matched_user == current_user}
        render json: { user: UserSerializer.new(user), likes: likes, matches: matches }
    end

    def update
        user = current_user
        user.update(update_params)
        user.geocode_address
        user.save
        render json: { user: UserSerializer.new(user)}
    end
    
    private

    def update_params
        params.permit(:email, :password, :firstName, :lastName, :location, :age, :birthDate, :picture, :gender, :lookingFor, :bioIntro, :bioGeneral, :bioFood, :bioMusic, :bioMovies, :bioBooks, :bioActivities, :bioGoals, :image)
    end
    
    def user_params
        params.require(:user).permit(:email, :password, :firstName, :lastName, :location, :age, :birthDate, :picture, :gender, :lookingFor, :bioIntro, :bioGeneral, :bioFood, :bioMusic, :bioMovies, :bioBooks, :bioActivities, :bioGoals)
    end
end
