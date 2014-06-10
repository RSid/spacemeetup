class Meetup < ActiveRecord::Base
  has_many :usermeetup
  has_many :event

  validates :name, presence: true, uniqueness: true
  validates :description, presence: true, uniqueness: true

end
