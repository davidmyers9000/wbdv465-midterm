class AddReviewableToReview < ActiveRecord::Migration
  def change
    change_table :reviews do |t|
      t.references :reviewable, polymorphic: true
    end

    Review.all.each do |review|
      review.update(reviewable_id: review.book_id, reviewable_type: "Book")
    end

    remove_column :reviews, :book_id
  end
end
