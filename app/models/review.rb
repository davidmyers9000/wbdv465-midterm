class Review < ActiveRecord::Base
  belongs_to :book
  belongs_to :created_by, class_name: :User

  validates :book,        presence: true

  validates :created_by,  presence: true

  validates :rating,      presence: true,
                          numericality: true,
                          length: {minimum: 0, maximum: 5}

  validates :content,     presence: true,
                          length: {maximum: 500}

end
