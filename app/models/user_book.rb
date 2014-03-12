class UserBook < ActiveRecord::Base
  belongs_to :user
  belongs_to :book

  STATUSES = ["to be read", "reading", "read"]

  validates :user,      presence: true
  validates :book,      presence: true
  validates :status,    presence: true,
                        inclusion: {in: STATUSES}

  delegate :title, :author, :summary, :page_count, :isbn,
    to: :book

  delegate :email,
    to: :user,
    prefix: true

  after_initialize :set_defaults

  scope :to_be_read, ->(){where(status: "to be read")}
  scope :read, ->(){where(status: "read")}
  scope :reading, ->(){where(status: "reading")}

  private

    def set_defaults
      self.status ||= STATUSES.first
    end
end
