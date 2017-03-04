class CreateEmota < ActiveRecord::Migration
  def change
    create_table :emota do |t|
      t.belongs_to :emotion, index: true

      t.decimal :image_processing_time, :precision => 3, :scale => 4
      t.decimal :api_roundtrip_time, :precision => 3, :scale => 4
      t.decimal :score_logging_time, :precision => 3, :scale => 4
      t.boolean :has_valid_face, default: false
      t.text :notes

      t.timestamps null: false
    end
  end
end
