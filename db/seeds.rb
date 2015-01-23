# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

categories = [
  "Автожизнь",
  "Арт-ридус",
  "Архитектура и строительство",
  "Бизнес",
  "Взаимоотношения полов",
  "Видео дня",
  "Военное дело",
  "Городская среда",
  "Другое",
  "Животные",
  "Жизнь в картинках",
  "Заброшенный мир",
  "Здоровье",
  "Знаменитости",
  "Игромания",
  "Интернет",
  "История",
  "Катастрофы и катаклизмы",
  "Космос",
  "Культура и искусство",
  "Кухни мира",
  "Литература",
  "Наука",
  "Образование",
  "Покойся с миром",
  "Похоть",
  "Право",
  "Праздники и фестивали",
  "Преступность",
  "Происшествия",
  "РелигиоРидус",
  "Семья и дети",
  "СМИ",
  "Стиль",
  "Страны и путешествия",
  "Территория запрета",
  "Терроризм",
  "ТехноРидус",
  "ТранспортРидус",
  "Убеждения",
  "Уличные акции",
  "Фото дня",
  "Экономика"
]

authors = [
  'dima',
  'sasha',
  'petya',
  'vasya',
  'tolya',
  'masha',
  'inna',
  'oleg',
  'yaroslav',
  'mitya',
  'anna'
]

ips = [
  '220.232.44.24',
  '131.126.7.58',
  '19.145.64.6',
  '205.144.160.107',
  '22.128.80.98',
  '197.251.137.43',
  '94.233.85.143',
  '112.108.228.116',
  '104.148.228.196',
  '96.23.141.32'
]

Article.delete_all
100.times do
	article = Article.create(
    title: Forgery('name').first_name,
    content: Forgery('lorem_ipsum').paragraph,
    author: authors.sample,
    # ip: Forgery(:internet).ip_v4,
    ip: ips.sample,
    date: Forgery(:date).date,
    category_title: categories.sample
	)

  rand(2..10).times do
    Comment.create(
      content: Forgery('lorem_ipsum').words(10),
      rating: Forgery('basic').number(at_least: 1, at_most: 5),
      article_id: article.id
    )
  end
end