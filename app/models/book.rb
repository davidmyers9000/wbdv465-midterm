class Book < ActiveRecord::Base

  acts_as_taggable_on :genres

  has_attached_file :cover,
    styles: { small: "150x150>", large: "300x300>" },
    default_url: "/assets/missing.png"

  validates_attachment :cover, allow_blank: true,
    content_type: { content_type: ["image/jpg", "image/jpeg", "image/png"] }

  belongs_to :author

  has_many :user_books
  has_many :users, through: :user_books
  has_many :reviews, as: :reviewable

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

    if reviews.size > 0
      ratings   = reviews.pluck(:rating)
      @rating = ratings.sum * 1.0 / ratings.size
    else
      @rating   = 0.0
    end
  end

end
