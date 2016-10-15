class Post < ApplicationRecord
  has_attached_file :image, s3_protocol: :https
  validates_attachment_presence :image
  validates_attachment_content_type :image, content_type: %r{\Aimage\/.*\Z}

  has_many :tag_posts
  has_many :tags, through: :tag_posts
end
