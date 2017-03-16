class CreateConversations < ActiveRecord::Migration
  def change
    create_table :conversations do |t|

      t.string :name
      t.decimal :duration
      t.text :mood
      t.text :deviations
      t.datetime :start_date
      t.datetime :end_date

      t.timestamps null: false
    end
  end
end
