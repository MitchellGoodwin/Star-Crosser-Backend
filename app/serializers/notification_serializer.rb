class NotificationSerializer < ActiveModel::Serializer
  attributes :id, :text, :read, :created_at, :user
end
