class UserMeetup < ActiveRecord::Base

  belongs_to :user
  belongs_to :meetup
  has_many :comments

  validates :user, presence: true
  validates :meetup,
    presence: true,
    uniqueness: {scope: :user}

end
