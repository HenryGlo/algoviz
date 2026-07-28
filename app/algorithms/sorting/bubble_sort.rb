# Bubble sort: emite compare / swap / done con el estado del array.
module Sorting
  class BubbleSort
    def initialize(array) = @array = array.dup

    def trace
      t = Trace.new
      a = @array.dup
      cmp = 0
      (a.size - 1).times do |i|
        (a.size - 1 - i).times do |j|
          cmp += 1
          t.emit(:compare, i: j, k: j + 1, array: a.dup, sorted: a.size - i, cmp: cmp)
          if a[j] > a[j + 1]
            a[j], a[j + 1] = a[j + 1], a[j]
            t.emit(:swap, i: j, k: j + 1, array: a.dup, sorted: a.size - i, cmp: cmp)
          end
        end
      end
      t.emit(:done, array: a.dup, sorted: 0, cmp: cmp)
      t.to_a
    end
  end
end
