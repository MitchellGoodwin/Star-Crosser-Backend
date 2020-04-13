class LikesController < ApplicationController

    def create
        likee = User.find_by(id: params[:likee_id])
        if likee.likees.include?(current_user)
            like = Like.find_by(likee: current_user, liker: likee)
            like.destroy()
            if match = Match.create(user1_id: likee.id, user2_id: current_user.id)
                notification = Notification.new(user: current_user, recipient: likee, action: 'Match', text: '', read: false)
                notification.save

                serialized_data = ActiveModelSerializers::Adapter::Json.new(
                NotificationSerializer.new(notification)
                ).serializable_hash

                NotificationsChannel.broadcast_to likee, serialized_data
            end
            render json: { match: MatchSerializer.new(match), like: 0 }
        else
            if like = Like.create(likee: likee, liker: current_user)
                notification = Notification.new(user: current_user, recipient: likee, action: 'Like', text: '', read: false)
                notification.save

                serialized_data = ActiveModelSerializers::Adapter::Json.new(
                NotificationSerializer.new(notification)
                ).serializable_hash

                NotificationsChannel.broadcast_to likee, serialized_data
                
            end
            render json: { like: LikeSerializer.new(like), match: 0 }
        end
    end

    def index
        liked_users = current_user.likees
        matched_users = current_user.matched_users
        render json: { liked_users: ActiveModel::Serializer::CollectionSerializer.new(liked_users, each_serializer: UserSerializer), 
        matched_users: ActiveModel::Serializer::CollectionSerializer.new(matched_users, each_serializer: UserSerializer)}
    end

    def destroy
        like = Like.find_by(id: params[:id])
        render json: like.destroy().to_json()
    end
end
