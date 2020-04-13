class NotificationSerializer < ActiveModel::Serializer
  attributes :id, :text, :read, :created_at, :action
  belongs_to :user, serializer: UserSerializer
end
