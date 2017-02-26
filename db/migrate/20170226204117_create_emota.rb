class CreateEmota < ActiveRecord::Migration
  def change
    create_table :emota do |t|
      t.string :name
      t.boolean :on_server
      t.boolean :sent_to_api
      t.boolean :received_from_api
      t.boolean :stored_score

      t.timestamps null: false
    end
  end
end
