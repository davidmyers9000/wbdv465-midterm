class ListBook < ActiveRecord::Base
  belongs_to :list
  belongs_to :book

  delegate :title, :author, :summary, :user, 
    to: :book

  delegate :title, :description,
    to: :list,
    prefix: true
end
