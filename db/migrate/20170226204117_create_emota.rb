class CreateEmota < ActiveRecord::Migration
  def change
    create_table :emota do |t|

      t.timestamps null: false
    end
  end
end
