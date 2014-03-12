class Book < ActiveRecord::Base

  acts_as_taggable_on :genres

  has_many :user_books
  has_many :users, through: :user_books
  has_many :reviews

  validates :title,       presence: true
  validates :author,      presence: true
  validates :summary,     presence: true
  validates :isbn,        presence: true,
                          length: {is: 10}


  def self.genres
    ActsAsTaggableOn::Tag.includes(:taggings).where("taggings.context = ?", 'genres').where("taggings.taggable_type = ?", "Book").distinct.references(:taggings)
  end

  def rating
    return @rating if @rating

    ratings   = reviews.pluck(:rating)
    @rating   = 0.0 if ratings.size < 1
    @rating ||= ratings.sum * 1.0 / ratings.size
  end

end
