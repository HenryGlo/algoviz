# Bubble sort. No anima nada: sólo emite un trace (array de pasos) que el
# Player (Stimulus) reproduce contra el renderer `bars`.
class BubbleSort
  def initialize(array) = @array = array.dup

  def trace
    a = @array.dup
    steps = []
    (a.size - 1).times do |i|
      (a.size - 1 - i).times do |j|
        steps << { type: "compare", i: j, k: j + 1, array: a.dup, sorted: a.size - i }
        if a[j] > a[j + 1]
          a[j], a[j + 1] = a[j + 1], a[j]
          steps << { type: "swap", i: j, k: j + 1, array: a.dup, sorted: a.size - i }
        end
      end
    end
    steps << { type: "done", array: a.dup, sorted: 0 }
    steps
  end
end
