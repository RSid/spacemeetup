class UserMeetup < ActiveRecord::Base

  belongs_to :user
  belongs_to :meetup

  validates :user, presence: true
  validates :meetup,
    presence: true,
    uniqueness: {scope: :user}

end
