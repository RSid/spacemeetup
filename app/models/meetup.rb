class Meetup < ActiveRecord::Base
  has_many :usermeetup
  has_many :event

  # def self.create(name,description)
  #   @name = name
  #   @description = description
  # end



end
