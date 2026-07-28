# Carga el catálogo desde content/*.json — única fuente de verdad.
# Agregar un algoritmo = agregar un archivo JSON (+ PR). Sin DB, sin migración.
# (En development, reiniciá el server para tomar cambios de content/.)
require "json"

module AlgovizCatalog
  DIR = Rails.root.join("content")

  meta = JSON.parse(File.read(DIR.join("categories.json")), symbolize_names: true)

  CATEGORIES = meta[:categories].to_h { |c|
    [ c[:id], { name: c[:name], color: c[:color], desc: c[:desc], count: c[:count] } ]
  }.freeze
  FEATURED = meta[:featured].map(&:to_s).freeze
  SOON     = meta[:roadmap].transform_keys(&:to_s).transform_values { |v| v.map(&:to_s) }.freeze

  docs = Dir[DIR.join("*.json")]
           .reject { |f| File.basename(f).start_with?("categories", "_") }
           .map { |f| JSON.parse(File.read(f), symbolize_names: true) }

  ENTRIES = docs.reject { |e| %w[antipattern pattern].include?(e[:kind]) }.to_h { |e|
    [ e[:id], {
      cat: e[:category], sub: e[:subtype], level: e[:level], viz: e[:viz],
      kind: e[:kind], uses: (e[:uses] || []).map(&:to_s),
      title: e[:title], intuition: e[:tagline], note: e[:note],
      history: e[:history], use_cases: e[:useCases] || [],
      when_to_use: e[:whenToUse], when_not_to_use: e[:whenNotToUse],
      complexity: e[:complexity], legend: e[:legend],
      code: (e[:code] || {}).transform_keys(&:to_s)
    } ]
  }.freeze

  PATTERNS = docs.select { |e| %w[antipattern pattern].include?(e[:kind]) }.to_h { |e|
    [ e[:id], {
      cat: e[:category], title: e[:title], symptom: e[:tagline], kind: e[:kind],
      sub: e[:subtype], history: e[:history], signals: e[:useCases] || [],
      rule: e[:whenToUse], caveat: e[:whenNotToUse], note: e[:complexity],
      bad: e.dig(:codeContrast, :bad), good: e.dig(:codeContrast, :good)
    } ]
  }.freeze

  KIND_LABEL = {
    "primitive" => "building block", "model" => "model",
    "algorithm" => "algorithm", "antipattern" => "anti-pattern", "pattern" => "pattern"
  }.freeze

  module_function

  def entries_in(cat) = ENTRIES.select { |_, e| e[:cat] == cat }
  def patterns_in(cat) = PATTERNS.select { |_, p| p[:cat] == cat }
  def subtypes(cat)   = entries_in(cat).values.map { |e| e[:sub] }.uniq.compact
  def title_of(id)    = ENTRIES.dig(id, :title) || PATTERNS.dig(id, :title) || id
  def category(id)    = CATEGORIES[id]
  def entry(id)       = ENTRIES[id]
  def pattern(id)     = PATTERNS[id]
end
