class Post < ApplicationRecord
  has_attached_file :image
  validates_attachment_presence :image
  validates_attachment_content_type :image, content_type: %r{\Aimage\/.*\Z}
  validates :body, presence: true, length: { maximum: 500 }
  validates :tags, presence: true

  before_validation :bulid_tags

  belongs_to :user
  has_many :tag_posts, dependent: :destroy
  has_many :tags, through: :tag_posts

  def bulid_tags
    tag_posts.delete_all
    tag_names = body.scan(/#[^\s]+/)
    tag_names.each { |name| name.sub!(/^#/, '') }
    tag_objects = tag_names.map { |name| Tag.new(name: name) }
    Tag.import(tag_objects, on_duplicate_key_update: :name)
    tags << Tag.where(name: tag_names)
  end
end
