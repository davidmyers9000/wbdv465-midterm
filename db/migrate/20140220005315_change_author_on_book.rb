class ChangeAuthorOnBook < ActiveRecord::Migration
  def change
    change_table :books do |t|
      t.references :author, index: true
    end
    remove_column :books, :author
  end
end
