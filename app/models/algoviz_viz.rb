# Resuelve el trace (y el dataset de puntos) que consume el player, según el
# id de visualización que declara la entrada en su JSON (`viz`).
module AlgovizViz
  # Puntos sintéticos deterministas, escalados a los renderers.
  LINREG_POINTS = [
    [ 0.5, 1.6 ], [ 1.0, 2.1 ], [ 1.7, 2.0 ], [ 2.3, 3.2 ], [ 3.0, 3.4 ],
    [ 3.7, 4.3 ], [ 4.4, 4.5 ], [ 5.1, 5.2 ], [ 5.8, 5.4 ], [ 6.5, 6.6 ],
    [ 7.2, 6.8 ], [ 8.0, 7.9 ], [ 8.7, 7.9 ], [ 9.4, 8.8 ]
  ].freeze

  KMEANS_POINTS = [
    [ 1.5, 8.0 ], [ 2.0, 8.6 ], [ 2.6, 7.6 ], [ 1.8, 7.9 ], [ 2.3, 8.3 ],
    [ 7.6, 8.1 ], [ 8.1, 8.6 ], [ 8.5, 7.8 ], [ 8.0, 7.5 ], [ 7.9, 8.4 ],
    [ 4.5, 2.6 ], [ 5.0, 2.0 ], [ 5.6, 3.0 ], [ 5.1, 3.1 ], [ 4.8, 2.2 ]
  ].freeze

  BUBBLE_ARRAY = [ 5, 3, 8, 1, 9, 2, 7 ].freeze

  module_function

  # => { trace: [...], points: [...] }
  def build(viz)
    case viz.to_s
    when "lossCurve"
      { trace: ::ML::GradientDescent.new.trace, points: [] }
    when "linearReg"
      { trace: ::ML::LinearRegression.new(LINREG_POINTS).trace, points: LINREG_POINTS }
    when "kmeans"
      { trace: ::ML::KMeans.new(KMEANS_POINTS).trace, points: KMEANS_POINTS }
    when "bars"
      { trace: ::Sorting::BubbleSort.new(BUBBLE_ARRAY).trace, points: [] }
    else
      { trace: [], points: [] }
    end
  end
end
