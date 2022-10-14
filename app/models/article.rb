class Article < ApplicationRecord # creating an articles table
  has_many :article_categories
  has_many :categories, through: :article_categories

  validates :title, presence: true, length: { minimum: 10, maximum: 50 }
  validates :description, presence: true, length: { minimum: 20, maximum: 200}

  belongs_to :user
end


