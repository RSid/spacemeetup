class UserMeetup < ActiveRecord::Base

      belongs_to :user
      belongs_to :meetup

      # def self.create(userid, meetupid)
      #   @userid = userid
      #   @meetupid = meetupid

      # end

end
