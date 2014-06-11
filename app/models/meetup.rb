class Meetup < ActiveRecord::Base
  has_many :user_meetups
  has_many :users, through: :user_meetups
  has_many :events
  has_many :comments, through: :user_meetups

  validates :name, presence: true, uniqueness: true
  validates :description, presence: true, uniqueness: true

end
