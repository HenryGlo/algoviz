# El directorio app/algorithms/ml/ define el módulo ML (acrónimo), no "Ml",
# y kmeans.rb define ML::KMeans.
Rails.autoloaders.main.inflector.inflect(
  "ml" => "ML",
  "kmeans" => "KMeans"
)
