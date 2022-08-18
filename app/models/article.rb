class Article < ApplicationRecord # creating an articles table
  validates :title, presence: true, length: { minimum: 10, maximum: 50 }
  validates :description, presence: true, length: { minimum: 20, maximum: 200}
end
