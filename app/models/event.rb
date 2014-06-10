class Event < ActiveRecord::Base
    validates :location, presence: true
    validates :date, presence: true
    validates :description, presence: true
    validates :meetup_id, presence: true
    belongs_to :meetup

end

