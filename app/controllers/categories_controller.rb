class CategoriesController < ApplicationController
  def show
    @category = Category.find_by!(slug: params[:category_slug])
    @subtype = params[:subtype].presence
    @entries = @category.entries.with_subtype(@subtype).ordered
    # El template completo se re-renderiza; Turbo extrae sólo el frame "catalog"
    # cuando el request viene de un chip de filtro. Sin recarga de página.
  end
end
