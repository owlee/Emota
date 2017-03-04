class CreateEmota < ActiveRecord::Migration
  def change
    create_table :emota do |t|
      t.belongs_to :emotion, index: true

      t.decimal :image_processing_time
      t.decimal :api_roundtrip_time
      t.decimal :score_logging_time
      t.boolean :has_valid_face, default: false
      t.text :notes

      t.timestamps null: false
    end
  end
end
