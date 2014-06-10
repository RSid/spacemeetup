class CreateUserMeetups < ActiveRecord::Migration
  def change
    create_table :usermeetups do |table|
      table.string :meetupqs

      table.timestamps
    end
  end
end
