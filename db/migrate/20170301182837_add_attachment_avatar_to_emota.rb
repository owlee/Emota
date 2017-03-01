class AddAttachmentAvatarToEmota < ActiveRecord::Migration
  def self.up
    change_table :emota do |t|
      t.attachment :avatar
    end
  end

  def self.down
    remove_attachment :emota, :avatar
  end
end
