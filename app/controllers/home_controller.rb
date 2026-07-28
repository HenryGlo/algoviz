class HomeController < ApplicationController
  def index
    @categories = Category.order(:name)
    @featured = Entry.animated.ordered.includes(:category).limit(4)
  end
end
