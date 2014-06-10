class CreateUserMeetups < ActiveRecord::Migration
  def change
    create_table :user_meetups do |table|
      table.string :meetupqs
      table.belongs_to :user
      table.belongs_to :meetup
      # table.integer :user_id, null: false
      # table.integer :meetup_id, null: false

      table.timestamps
    end
  end
end
