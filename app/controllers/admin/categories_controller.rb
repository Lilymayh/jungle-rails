class Admin::CategoriesController < ApplicationController
  protect_from_forgery with: :exception
  before_action :authenticate

  def authenticate
    authenticate_or_request_with_http_basic do |username, password|
      username == "Jungle" && password == "book"
    end
  end

	def index
    @categories = Category.all
	end

	def new
		@category = Category.new 
	end

	def create
    @category = Category.new(category_params)

    if @category.save
      redirect_to [:admin, :categories], notice: 'Category created!'
    else
      render :new
    end
  end

  def category_params
    params.require(:category).permit(:name, :description, :other_attributes)
  end

end

