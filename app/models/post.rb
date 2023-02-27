class Post < ApplicationRecord
  belongs_to :author, class_name: 'Member'
  has_many :comments
  has_many :likes
  validates :title, presence: true, length: { maximum: 250, too_long: '%<count>s characters is the maximum allowed' }
  validates :comments_counter, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  validates :likes_counter, numericality: { only_integer: true, greater_than_or_equal_to: 0 }

  after_save :update_member_counter
  after_destroy :update_member_counter

  def recent_comments
    comments.includes(:author).order(created_at: :desc).first(5)
  end

  def update_member_counter
    author.update(post_counter: author.posts.count)
  end
end
