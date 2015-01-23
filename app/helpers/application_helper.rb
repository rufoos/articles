module ApplicationHelper
	def link_to_add_ratings(name, f, association)
		new_object = f.object.send(association).klass.new
		id = new_object.object_id
		fields = f.fields_for(association, new_object, child_index: id) do |builder|
			render(association.to_s.singularize + "_fields", f: builder)
		end
		link_to(name, '#', id: "add_rating", data: {id: id, fields: fields.gsub("\n", "")})
	end

	def articles_title
		case action_name
		when "index" then t('title.index')
		when "search" then t('title.search')
		when "top10" then t('title.top10')
			else t('title.default')
		end
	end

	def top_menu
  	[
  		{text: t('menu.articles'), link: articles_path},
  		{text: t('menu.top_10_articles'), link: top10_articles_path},
  		{text: t('menu.neighbors_articles'), link: neighbors_articles_path}
  	]
  end
end
