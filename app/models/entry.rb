class Entry < ApplicationRecord
  KINDS  = %w[animated code_contrast].freeze
  LEVELS = %w[basico intermedio avanzado].freeze

  # Registro slug -> PORO de algoritmo. El PORO es a la vez el código canónico
  # que se muestra y la fuente de la animación: su método #trace emite los pasos.
  ALGORITHMS = {
    "gradient-descent" => -> { GradientDescent.new },
    "bubble-sort"      => -> { BubbleSort.new([ 5, 3, 8, 1, 9, 2, 7 ]) }
  }.freeze

  belongs_to :category

  # code_snippets se guarda serializado como { "python" => "...", "ruby" => "..." }.
  serialize :code_snippets, coder: JSON, type: Hash

  validates :title, presence: true
  validates :slug, presence: true, uniqueness: { scope: :category_id }
  validates :kind, inclusion: { in: KINDS }
  validates :level, inclusion: { in: LEVELS }

  scope :animated,      -> { where(kind: "animated") }
  scope :code_contrast, -> { where(kind: "code_contrast") }
  scope :with_subtype,  ->(s) { s.present? ? where(subtype: s) : all }
  scope :ordered,       -> { order(:title) }

  # Slug es la clave pública en las rutas (/:category_slug/:entry_slug).
  def to_param = slug

  def animated?      = kind == "animated"
  def code_contrast? = kind == "code_contrast"

  def code_snippets = super || {}

  # El trace que consume el Player (Stimulus). Se resuelve desde el registro por slug.
  def trace
    builder = ALGORITHMS[slug]
    builder ? builder.call.trace : []
  end

  def traceable? = ALGORITHMS.key?(slug)
end
