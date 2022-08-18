class Article < ApplicationRecord # creating an articles table
  validates :title, presence: true
  validates :description, presence: true
end
