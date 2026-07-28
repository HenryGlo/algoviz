class EntriesController < ApplicationController
  def show
    @slug = params[:slug]
    @entry = AlgovizCatalog.entry(@slug) or return head(:not_found)
    @category = AlgovizCatalog.category(@entry[:cat])

    if @entry[:viz].present?
      viz = AlgovizViz.build(@entry[:viz])
      @trace = viz[:trace]
      @points = viz[:points]
    else
      @trace = []
      @points = []
    end
  end
end
