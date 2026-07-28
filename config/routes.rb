Rails.application.routes.draw do
  root "home#index"

  get "up" => "rails/health#show", as: :rails_health_check

  # Catálogo file-based (content/*.json vía AlgovizCatalog).
  get "c/:slug", to: "categories#show", as: :category
  get "a/:slug", to: "entries#show",    as: :entry
  get "p/:slug", to: "patterns#show",   as: :pattern
end
