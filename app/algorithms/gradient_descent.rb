# Gradient descent sobre L(w) = (w - 3)², con gradiente 2(w - 3).
# Mismo patrón que BubbleSort: emite un trace de pasos { type: "step", w:, loss: }
# que el Player reproduce contra el renderer `loss_curve`.
class GradientDescent
  def initialize(w0: -1.0, lr: 0.1, steps: 24)
    @w0 = w0
    @lr = lr
    @steps = steps
  end

  def loss(w)     = (w - 3)**2
  def gradient(w) = 2 * (w - 3)

  def trace
    w = @w0
    trace = [ { type: "start", w: w.round(4), loss: loss(w).round(4) } ]
    @steps.times do
      w -= @lr * gradient(w)
      trace << { type: "step", w: w.round(4), loss: loss(w).round(4) }
    end
    trace << { type: "done", w: w.round(4), loss: loss(w).round(4) }
    trace
  end
end
