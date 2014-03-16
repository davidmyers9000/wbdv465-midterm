class Review < ActiveRecord::Base

  belongs_to :reviewable, polymorphic: true
  belongs_to :created_by, class_name: :User

  validates :reviewable,  presence: true

  validates :created_by,  presence: true

  validates :rating,      presence: true,
                          numericality: true,
                          length: {minimum: 0, maximum: 5}

  validates :content,     presence: true,
                          length: {maximum: 500}

  scope :for_books,   ->(){where(reviewable_type: "Book")}
  scope :for_authors, ->(){where(reviewable_type: "Author")}

end
