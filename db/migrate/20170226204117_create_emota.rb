class CreateEmota < ActiveRecord::Migration
  def change
    create_table :emota do |t|
      t.belongs_to :emotion, index: true
      t.string :path
      t.time :on_server
      t.time :preprocess
      t.time :sent_api
      t.time :received_api
      t.time :stored_score
      t.boolean :has_valid_face, default: false
      t.text :notes

      t.timestamps null: false
    end
  end
end
