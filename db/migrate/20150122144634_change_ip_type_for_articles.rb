class ChangeIpTypeForArticles < ActiveRecord::Migration
  def change
    change_column :articles, :ip, "INT(11) UNSIGNED"
  end
end
