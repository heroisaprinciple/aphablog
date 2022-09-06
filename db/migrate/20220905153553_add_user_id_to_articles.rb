class AddUserIdToArticles < ActiveRecord::Migration[7.0]
  def change
    # add user_id column to articles table (as a foreign key)
    add_column :articles, :user_id, :integer
  end
end
