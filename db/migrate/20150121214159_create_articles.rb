class CreateArticles < ActiveRecord::Migration
  def change
    create_table :articles do |t|
      t.string :title, null: false
      t.text :content, null: false
      t.string :author
      t.string :ip, null: false
      t.float :rating, default: 0.0
      t.date :date
      t.integer :category_id
      t.integer :count_comments

      t.timestamps
    end

    add_index :articles, [:rating, :category_id, :count_comments, :author], name: 'rating_category_comments_author'
  end
end
