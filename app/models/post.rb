class Post < ApplicationRecord
  has_attached_file :image, s3_protocol: :https
  validates_attachment_presence :image
  validates_attachment_content_type :image, content_type: %r{\Aimage\/.*\Z}
  validates :body, presence: true, length: { maximum: 500 }
  validates :tags, presence: true

  before_validation :bulid_tags

  has_many :tag_posts
  has_many :tags, through: :tag_posts

  def bulid_tags
    already_tags = tags.pluck(:name)
    new_tags = body.scan(/#[^\s]+/)
    new_tags.each { |name| name.sub!(/^#/, '') }
    new_tags.reject! { |name| already_tags.include?(name) }
    tags << new_tags.map { |name| Tag.find_or_create_by(name: name) }
  end
end
