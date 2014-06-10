class CreateUserMeetups < ActiveRecord::Migration
  def change
    create_table :user_meetups do |table|
      table.string :meetupqs
      table.integer :user_id, null: false
      table.integer :meetup_id, null: false

      table.timestamps
    end
    add_index :user_meetups, [:user_id, :meetup_id], unique: true
  end
end
