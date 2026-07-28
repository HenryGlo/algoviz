class CategoriesController < ApplicationController
  def show
    @slug = params[:slug]
    @category = AlgovizCatalog.category(@slug) or return head(:not_found)
    @entries  = AlgovizCatalog.entries_in(@slug)
    @patterns = AlgovizCatalog.patterns_in(@slug)
    @subtypes = AlgovizCatalog.subtypes(@slug)
    @soon     = AlgovizCatalog::SOON.fetch(@slug, [])
  end
end
