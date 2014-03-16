class Author < ActiveRecord::Base

  has_many :books
  has_many :reviews, as: :reviewable

  has_attached_file :picture,
    styles: { medium: "320x320>", small: "210x210", thumb: "125x125>" },
    default_url: "/assets/missing.png"

  validates_attachment :picture, allow_blank: true,
    content_type: { content_type: ["image/jpg", "image/jpeg", "image/png"] }

  validates :name, presence: true
  validates :bio,  presence: true
end
