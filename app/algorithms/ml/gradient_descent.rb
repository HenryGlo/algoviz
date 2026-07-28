# Desciende L(w) = (w - 3)^2 por gradiente. Emite pasos { w, loss, it }.
module ML
  class GradientDescent
    def initialize(lr: 0.3) = @lr = lr

    def loss(w) = (w - 3)**2
    def grad(w) = 2 * (w - 3)

    def trace
      t = Trace.new
      w = -1.0
      t.emit(:step, w: w, loss: loss(w), it: 0)
      1.upto(40) do |it|
        w -= @lr * grad(w)
        w = w.clamp(-2.2, 8.2)
        t.emit(:step, w: w, loss: loss(w), it: it)
      end
      t.to_a
    end
  end
end
