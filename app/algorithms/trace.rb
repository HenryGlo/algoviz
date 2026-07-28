# Junta los pasos que emite un algoritmo. El array se serializa a JSON en la
# vista y se lo pasa al player de Stimulus, que lo reproduce paso a paso.
class Trace
  def initialize = @steps = []

  # emit(:assign, centroids: c, it: i)  =>  { type: :assign, centroids: c, it: i }
  def emit(type, **data) = @steps << { type: type }.merge(data)

  def to_a = @steps
end
