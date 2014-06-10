class CreateEvents < ActiveRecord::Migration
   def change
    create_table :events do |table|

      table.string :location, null: false
      table.string :date, null: false
      table.string :description, null: false

      table.timestamps

    end
  end
end
