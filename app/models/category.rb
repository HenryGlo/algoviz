class Category < ApplicationRecord
  has_many :entries, dependent: :destroy

  validates :name, presence: true
  validates :slug, presence: true, uniqueness: true

  # Slug es la clave pública en las rutas (/:category_slug).
  def to_param = slug

  # Subtipos presentes en esta categoría, para los chips del índice filtrable.
  def subtypes
    entries.where.not(subtype: [ nil, "" ]).distinct.order(:subtype).pluck(:subtype)
  end
end
