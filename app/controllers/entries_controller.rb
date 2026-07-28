class EntriesController < ApplicationController
  def show
    @category = Category.find_by!(slug: params[:category_slug])
    @entry = @category.entries.find_by!(slug: params[:entry_slug])
  end
end
