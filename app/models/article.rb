require 'ipaddr'

class Article < ActiveRecord::Base
  belongs_to :category
  has_many :comments, dependent: :destroy

  validates :title, :content, :category_id, :date, presence: true
  validates :ip, format: {with: /\b(?:(?:2(?:[0-4][0-9]|5[0-5])|[0-1]?[0-9]?[0-9])\.){3}(?:(?:2([0-4][0-9]|5[0-5])|[0-1]?[0-9]?[0-9]))\b/}

  self.per_page = 10

  scope :search, lambda { |params|
    vars = []
    query = []

    params.each do |key, value|
      next if value.empty?
      case key
      when 'rating_from'
        query << 'rating >= ?'
        vars << value
      when 'rating_to'
        query << 'rating <= ?'
        vars << value
      when 'author'
        query << 'author LIKE ?'
        vars << "%#{value}%"
      when 'category_title'
        category = Category.where(title: value).first
        if category
          query << 'category_id = ?'
          vars << category.id
        end
      when 'date'
        begin
          parsed_date = Date.parse(value)
          query << 'date = ?'
          vars << parsed_date
        rescue ArgumentError
        end
      else
        query << "#{key} = ?"
        vars << value
      end
    end

    sanitized_join_condition = sanitize_sql_array([query.join(" AND "), vars].flatten)
    where(sanitized_join_condition)
  }

  scope :neighbors, lambda {
    where(ip: Article.select("ip").group("ip").having("COUNT(ip) > ?", 1))
  }

  def category_title
    category.try(:title)
  end

  def category_title=(title)
    self.category = Category.find_or_create_by(title: title) if title.present?
  end

  def ip=(ip_address)
    ip_integer = ip_address.is_a?(Integer) ? ip_address : IPAddr.new(ip_address).to_i
    write_attribute(:ip, ip_integer)
  end

  def ip
    IPAddr.new(read_attribute(:ip), Socket::AF_INET).to_s
  end
end
