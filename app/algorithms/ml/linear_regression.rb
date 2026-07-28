# Descenso de gradiente que ajusta y = w·x + b. Emite pasos { w, b, loss, it }.
module ML
  class LinearRegression
    attr_reader :points

    def initialize(points, lr: 0.008)
      @points = points   # array de [x, y]
      @lr = lr
    end

    def trace
      t = Trace.new
      w = 0.0
      b = 0.0
      n = @points.size

      t.emit(:step, w: w, b: b, loss: mse(w, b), it: 0)
      1.upto(60) do |it|
        gw = @points.sum { |x, y| 2 * (w * x + b - y) * x } / n
        gb = @points.sum { |x, y| 2 * (w * x + b - y) } / n
        w -= @lr * gw
        b -= @lr * gb
        t.emit(:step, w: w, b: b, loss: mse(w, b), it: it)
      end
      t.to_a
    end

    private

    def mse(w, b) = @points.sum { |x, y| (w * x + b - y)**2 } / @points.size
  end
end
