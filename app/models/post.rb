class Post < ApplicationRecord
  belongs_to :user
  attachment :image
  has_one :spot, dependent: :destroy
  accepts_nested_attributes_for :spot
  has_many :post_comments, dependent: :destroy
  has_many :likes, dependent: :destroy

  def liked_by?(user)
    likes.where(user_id: user.id).exists?
  end
  has_many :liked_users, through: :likes, source: :user
end
