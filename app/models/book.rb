class Book < ActiveRecord::Base

  acts_as_taggable_on :genres

  has_many :user_books
  has_many :users, through: :user_books

  validates :title,       presence: true
  validates :author,      presence: true
  validates :summary,     presence: true
  validates :isbn,        presence: true,
                          length: {is: 10}


  def self.genres
    ActsAsTaggableOn::Tag.includes(:taggings).where("taggings.context = ?", 'genres').where("taggings.taggable_type = ?", "Book").distinct.references(:taggings)
  end

end
