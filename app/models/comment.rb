class Comment < ActiveRecord::Base
  belongs_to :user_meetups

  validates :user_meetup_id, presence: true
  validates :comment, presence: true

end
