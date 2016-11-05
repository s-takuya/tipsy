class Tag < ApplicationRecord
  validates :name, uniqueness: true, length: { minimum: 1, maximum: 100 }

  has_many :tag_posts
  has_many :posts, -> { order(created_at: :desc) }, through: :tag_posts

  def self.where_or_create_by_names(names)
    tags = names.map { |name| Tag.new(name: name) }
    Tag.import(tags, on_duplicate_key_update: :name)
    Tag.where(name: names)
  end
end
