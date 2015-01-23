class Comment < ActiveRecord::Base
	belongs_to :article

  validates :rating, numericality: {greater_than_or_equal_to: 1, less_than_or_equal_to: 5}

  after_save :set_article_data

private

  def set_article_data
    article.count_comments = article.comments.length
    article.rating = (article.comments.map(&:rating).reduce(:+)/article.count_comments).round(2) if article.count_comments > 0
    article.save
  end
end
