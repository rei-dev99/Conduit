class Article < ApplicationRecord
  has_many :taggings, dependent: :destroy
  has_many :tags,      through: :taggings
  belongs_to :user

  def create_tag(input_tags)
    input_tags.each do |tag|
      new_tag = Tag.find_or_create_by(name: tag)
      tags << new_tag
    end
  end

  def update_tags(input_tags)
    registered_tags = tags.pluck(:name)
    new_tags = input_tags - registered_tags
    destroy_tags = registered_tags - input_tags

    new_tags.each do |tag|
      new_tag = Tag.find_or_create_by(name: tag)
      tags << new_tag
    end

    destroy_tags.each do |tag|
      tag_id = Tag.find_by(name: tag)
      destroy_tagging = Tagging.find_by(tag_id: tag_id.id, article_id: id)
      destroy_tagging.destroy
    end
  end
end
