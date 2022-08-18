class CreateArticles < ActiveRecord::Migration[7.0]
  def change
    create_table :articles do |t|
      t.string :title # creating attributes for our tables in db
      t.text :description # for updating our table, we should rollback the migration and add everything
      # again
      t.timestamps
    end
  end
end
