class UsersController < ApplicationController
    skip_before_action :authorized, only: [:create]
 
    def create
        @user = User.create(user_params)
        @user.sun_sign = @user.find_sun_sign
        @user.location = "#{params[:user][:city]}, #{params[:user][:state]}, #{params[:user][:country]}"
        @user.picture = 'https://t4.ftcdn.net/jpg/00/64/67/63/240_F_64676383_LdbmhiNM6Ypzb3FM4PPuFP9rHe7ri8Ju.jpg'
        @user.save
        @user.get_age
        byebug
        if @user.valid?
            @token = encode_token(user_id: @user.id)
            render json: { user: UserSerializer.new(@user), jwt: @token }, status: :created
        else
            render json: { error: 'failed to create user' }, status: :not_acceptable
        end
    end

    def index
        users = current_user.gender_filtered_users.first(400)
        render json: users.to_json(only: [:firstName, :lastName, :location, :age, :picture, :lookingFor, :gender, :id])
    end

    def show
        user = User.find_by(id: params[:id])
        render json: user.to_json()
    end

    def update
        user = current_user
        user.update(user_params)
        render json: { user: UserSerializer.new(user)}
    end
    
    private
    
    def user_params
        params.require(:user).permit(:email, :password, :firstName, :lastName, :location, :age, :birthDate, :picture, :gender, :lookingFor, :bioIntro, :bioGeneral, :bioFood, :bioMusic, :bioMovies, :bioBooks, :bioActivities, :bioGoals)
    end
end
