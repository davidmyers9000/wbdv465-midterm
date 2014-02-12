class CreateLists < ActiveRecord::Migration
  def change
    create_table :lists do |t|
      t.references :book, index: true
      t.references :user, index: true
      t.string     :title
      t.string     :description

      t.timestamps
    end
  end
end
