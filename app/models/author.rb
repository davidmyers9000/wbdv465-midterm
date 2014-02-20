class Author < ActiveRecord::Base

  has_many :books
  has_many :reviews, as: :reviewable

  validates :name, presence: true
  validates :bio,  presence: true
end
