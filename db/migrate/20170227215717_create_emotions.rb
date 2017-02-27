class CreateEmotions < ActiveRecord::Migration
  def change
    create_table :emotions do |t|
      t.decimal :surprise
      t.decimal :anger
      t.decimal :contempt
      t.decimal :disgust
      t.decimal :fear
      t.decimal :happiness
      t.decimal :neutral
      t.decimal :sadness
      t.decimal :happiness

      t.timestamps null: false
    end
  end
end
