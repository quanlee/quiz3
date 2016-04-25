class Idea < ActiveRecord::Base
  belongs_to :user
  has_many :users, through: :members
  has_many :likes, through: :likes
  has_many :liked_users, through: :likes, source: :users

  def member_for(user_id)
    users.find_by_user_id user_id
  end

  def like_for(user_id)
    likes.find_by_user_id user_id
  end
end
