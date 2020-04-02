class LikeSerializer < ActiveModel::Serializer
  attributes :id, :likee_id, :liker_id
end
