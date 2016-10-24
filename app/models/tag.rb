class Tag < ApplicationRecord
  validates :name, uniqueness: true, length: { minimum: 1, maximum: 100 }

  has_many :tag_posts
  has_many :posts, -> { order(created_at: :desc) }, through: :tag_posts
end
