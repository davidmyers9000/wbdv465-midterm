class AddPictureToAuthor < ActiveRecord::Migration
  def change
    change_table :authors do |t|
      t.attachment :picture
    end
  end
end
