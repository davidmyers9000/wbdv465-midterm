class CreateBooksReviews < ActiveRecord::Migration
  def change
    create_table :reviews do |t|
      t.references :book, index: true
      t.references :created_by, index: true
      t.integer :rating
      t.text :content

      t.timestamps
    end
  end
end
