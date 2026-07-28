Rails.application.routes.draw do
  root "home#index"

  # Health check para monitores/uptime (Render lo usa).
  get "up" => "rails/health#show", as: :rails_health_check

  # Índice de categoría (con filtro por subtipo vía Turbo Frame) y entrada.
  # Van al final: son las rutas "catch-all" públicas del portfolio.
  get ":category_slug", to: "categories#show", as: :category
  get ":category_slug/:entry_slug", to: "entries#show", as: :entry
end
