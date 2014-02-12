class CreateListBooks < ActiveRecord::Migration
  def change
    create_table :list_books do |t|
      t.references :list, index: true
      t.references :book, index: true

      t.timestamps
    end
  end
end
