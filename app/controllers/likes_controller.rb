class LikesController < ApplicationController

    def create
        likee = User.find_by(id: params[:likee_id])
        if likee.likees.include?(current_user)
            like = Like.find_by(likee: current_user, liker: likee)
            like.destroy()
            match = Match.create(user1_id: likee.id, user2_id: current_user.id)
            render json: { match: match.to_json(), like: [] }
        else
            like = Like.create(likee: likee, liker: current_user)
            render json: { like: like.to_json(), match: [] }
        end
    end

    def index
        liked_users = current_user.likees
        matched_users = current_user.matched_users
        render json: { liked_users: liked_users, matched_users: matched_users}
    end

    def destroy
        like = Like.find_by(id: params[:id])
        render json: like.destroy().to_json()
    end
end
