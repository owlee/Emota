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

      t.decimal :surprise_p
      t.decimal :anger_p
      t.decimal :contempt_p
      t.decimal :disgust_p
      t.decimal :fear_p
      t.decimal :happiness_p
      t.decimal :neutral_p
      t.decimal :sadness_p
      t.decimal :happiness_p

      t.timestamps null: false
    end
  end
end
