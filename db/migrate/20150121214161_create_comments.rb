class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.string :title, null: false
      t.text :content, null: false
      t.integer :article_id, null: false
      t.integer :rating, default: 0

      t.timestamps
    end

    add_index :comments, [:rating, :article_id], name: 'rating_article'
  end
end
