class NotificationsController < ApplicationController
    def readall
        current_user.notifications.each do |notif|
            notif.read = true
            notif.save
            render json: { message: 'Success' }
        end
    end
end
