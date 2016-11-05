class Post < ApplicationRecord
  has_attached_file :image, styles: { medium: '320x320>' }, convert_options: { medium: '-gravity center -background white -extent 320x320' }
  validates_attachment_presence :image
  validates_attachment_content_type :image, content_type: %r{\Aimage\/.*\Z}
  validates :body, presence: true, length: { maximum: 500 }
  validates :tags, presence: true

  before_validation :save_tags

  belongs_to :user
  has_many :tag_posts, dependent: :destroy
  has_many :tags, through: :tag_posts

  def save_tags
    delete_post_relation
    tags << Tag.where_or_create_by_names(scan_tag_names)
  end

  def delete_post_relation
    tag_posts.delete_all
  end

  def scan_tag_names
    body.scan(/#[^\s]+/).each { |name| name.sub!(/^#/, '') }
  end
end
