# Seed idempotente: 2 categorías y 2 entradas (el molde del Milestone 1).
# Agregar un algoritmo = un PORO de trace + (si es viz nueva) un renderer.

ml = Category.find_or_create_by!(slug: "machine-learning") do |c|
  c.name = "Machine Learning"
  c.color = "#b98bff"
  c.description = "Optimización y modelos, animados paso a paso desde el trace que emite el algoritmo."
end

sorting = Category.find_or_create_by!(slug: "ordenamiento") do |c|
  c.name = "Ordenamiento"
  c.color = "#56d4a0"
  c.description = "Algoritmos de sorting clásicos: comparaciones, swaps y la cola ya ordenada."
end

# ---------------------------------------------------------------------------
Entry.find_or_initialize_by(category: ml, slug: "gradient-descent").update!(
  title: "Gradient Descent",
  subtype: "optimización",
  level: "basico",
  kind: "animated",
  viz: "loss_curve",
  intuition: "Bajás la colina de la pérdida a pasos proporcionales a la pendiente hasta tocar el mínimo.",
  complexity: "O(iteraciones) por dimensión",
  code_snippets: {
    python: <<~PY,
      def gradient_descent(w0=-1.0, lr=0.1, steps=24):
          loss = lambda w: (w - 3) ** 2
          grad = lambda w: 2 * (w - 3)
          w, trace = w0, []
          for _ in range(steps):
              w -= lr * grad(w)
              trace.append({"w": round(w, 4), "loss": round(loss(w), 4)})
          return trace
    PY
    ruby: <<~RB
      class GradientDescent
        def initialize(w0: -1.0, lr: 0.1, steps: 24)
          @w0, @lr, @steps = w0, lr, steps
        end

        def loss(w)     = (w - 3)**2
        def gradient(w) = 2 * (w - 3)

        def trace
          w = @w0
          Array.new(@steps) do
            w -= @lr * gradient(w)
            { w: w.round(4), loss: loss(w).round(4) }
          end
        end
      end
    RB
  },
  body: <<~MD
    ## La idea

    Queremos el `w` que minimiza la pérdida `L(w) = (w − 3)²`. No la resolvemos
    de forma cerrada: **descendemos**. En cada paso miramos la pendiente
    (el gradiente `2(w − 3)`) y damos un paso en contra, escalado por el
    *learning rate*.

    ## Qué mirar en la animación

    - La bolita arranca en `w = -1` y cae hacia `w = 3`, el mínimo.
    - Los pasos son grandes cuando la pendiente es empinada y se achican al acercarse.
    - Un `lr` muy grande haría que la bolita rebote y diverja.
  MD
)

# ---------------------------------------------------------------------------
Entry.find_or_initialize_by(category: sorting, slug: "bubble-sort").update!(
  title: "Bubble Sort",
  subtype: "comparación",
  level: "basico",
  kind: "animated",
  viz: "bars",
  intuition: "Recorrés el array comparando pares vecinos; el más grande 'burbujea' hasta el final.",
  complexity: "O(n²) comparaciones, O(1) memoria",
  code_snippets: {
    python: <<~PY,
      def bubble_sort(a):
          a = a[:]
          for i in range(len(a) - 1):
              for j in range(len(a) - 1 - i):
                  if a[j] > a[j + 1]:
                      a[j], a[j + 1] = a[j + 1], a[j]
          return a
    PY
    ruby: <<~RB
      class BubbleSort
        def initialize(array) = @array = array.dup

        def trace
          a, steps = @array.dup, []
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
        end
      end
    RB
  },
  body: <<~MD
    ## La idea

    En cada pasada comparamos elementos **vecinos** y los intercambiamos si están
    fuera de orden. Tras cada pasada, el elemento más grande de la parte no
    ordenada queda en su lugar definitivo — por eso la cola verde crece.

    ## Qué mirar en la animación

    - **Amarillo**: el par que se está comparando.
    - **Rojo**: un swap en curso.
    - **Verde**: la cola ya ordenada, que no se vuelve a tocar.
  MD
)

puts "Seed listo: #{Category.count} categorías, #{Entry.count} entradas."
