class CreateEmota < ActiveRecord::Migration
  def change
    create_table :emota do |t|
      t.string :path
      t.time :on_server
      t.time :preprocess
      t.time :sent_api
      t.time :received_api
      t.time :stored_score
      t.text :description

      t.timestamps null: false
    end
  end
end
