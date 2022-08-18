class Article < ApplicationRecord # creating an articles table
  validates :title, presence: true
end
