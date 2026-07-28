class HomeController < ApplicationController
  def index
    @categories = AlgovizCatalog::CATEGORIES
    hero = AlgovizViz.build("linearReg")
    @hero_trace = hero[:trace]
    @hero_points = hero[:points]
  end
end
