class CategoriesController < ApplicationController

	def index
		@categories = Category.order(:title).where("title LIKE ?", "%#{params[:term]}%")
		render json: @categories.map(&:title)
	end

end
