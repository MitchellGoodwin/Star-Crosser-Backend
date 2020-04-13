class MessagesController < ApplicationController

    def create
        receiver = User.find_by(id: params[:receiver_id])
        if message = Message.create(sender: current_user, receiver: receiver, text: params[:text])
            notification = Notification.new(user: current_user, recipient: receiver, action: 'Message', text: message.text, read: false)
            notification.save

            serialized_data = ActiveModelSerializers::Adapter::Json.new(
            NotificationSerializer.new(notification)
            ).serializable_hash

            NotificationsChannel.broadcast_to receiver, serialized_data
        end
        render json: message.to_json(:include => {:receiver => {only: [:id, :picture, :firstName, :lastName]}})
    end

    def show
        receiver = User.find_by(id: params[:id])
        messages = Message.all.select{|message| (message.sender == receiver && message.receiver == current_user) || message.sender == current_user && message.receiver == receiver}
        render json: messages.to_json(:include => {:receiver => {only: [:id, :picture, :firstName, :lastName, :image_url]}})
    end
end
