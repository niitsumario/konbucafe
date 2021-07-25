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
  has_many :tag_maps, dependent: :destroy
  has_many :tags, through: :tag_maps

  validates :shop_name, presence: true
  validates :image, presence: true
  validates :title, presence: true
  validates :introduction, presence: true

  def save_tag(sent_tags)
    current_tags = self.tags.pluck(:tag_name) unless self.tags.nil?
    old_tags = current_tags - sent_tags
    new_tags = sent_tags - current_tags
    old_tags.each do |old|
      self.tags.delete Tag.find_by(tag_name: old)
    end
    new_tags.each do |new|
      new_post_tag = Tag.find_or_create_by(tag_name: new)
      self.tags << new_post_tag
    end
  end

end
