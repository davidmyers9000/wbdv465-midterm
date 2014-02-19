class User < ActiveRecord::Base
  has_secure_password

  has_many :user_books
  has_many :books, through: :user_books

  ROLES = ["admin", "member"]

  validates :email,     presence: true,
                        uniqueness: true,
                        format: {with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i}

  validates :password,  presence: true,
                        confirmation: true,
                        length: {minimum: 6},
                        if: :_password_present?

  validates :role,      presence: true,
                        inclusion: {in: ROLES}

  after_initialize :_set_default_role

  def book_list
    user_books
  end

  private

    def _set_default_role
      self.role ||= "member"
    end

    def _password_present?
      self.password.present?
    end
end
