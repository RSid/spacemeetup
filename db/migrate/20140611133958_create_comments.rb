class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |table|
      table.string :comment, null: false
      table.integer :user_meetup_id, null: false

      table.timestamps
    end
  end
end
