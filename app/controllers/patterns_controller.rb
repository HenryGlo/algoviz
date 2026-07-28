class PatternsController < ApplicationController
  def show
    @slug = params[:slug]
    @pattern = AlgovizCatalog.pattern(@slug) or return head(:not_found)
    @category = AlgovizCatalog.category(@pattern[:cat])
  end
end
