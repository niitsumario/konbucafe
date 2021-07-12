class Post < ApplicationRecord
  belongs_to :user
  attachment :image
  has_one :spot, dependent: :destroy
  accepts_nested_attributes_for :spot
end
