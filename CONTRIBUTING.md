# Contribuir a algoviz

¡Gracias por querer sumar! algoviz crece de dos formas, y las dos son bienvenidas.

## 1. Agregar tu lenguaje a una entrada existente

Es la forma más fácil de empezar. Cada entrada muestra el mismo algoritmo en
varios lenguajes; hoy tenemos **Python** (ML) y **Ruby** (algoritmos y patrones).

1. Encontrá la entrada en [`db/seeds.rb`](db/seeds.rb).
2. Sumá tu lenguaje a `code_snippets`. Por ejemplo, para agregar Rust a bubble sort:

   ```ruby
   code_snippets: {
     python: "...",
     ruby: "...",
     rust: <<~RUST
       fn bubble_sort(mut a: Vec<i32>) -> Vec<i32> {
           for i in 0..a.len() {
               for j in 0..a.len() - 1 - i {
                   if a[j] > a[j + 1] { a.swap(j, j + 1); }
               }
           }
           a
       }
     RUST
   }
   ```

3. Si tu lenguaje no aparece como tab, agregalo en
   [`app/views/entries/_code_tabs.html.erb`](app/views/entries/_code_tabs.html.erb).
   Rouge ya sabe resaltar decenas de lenguajes.

## 2. Agregar un algoritmo nuevo

El molde ya está hecho — el Player se reutiliza siempre.

1. **El trace** — creá un PORO en `app/algorithms/`. No anima nada: devuelve un
   array de pasos.

   ```ruby
   # app/algorithms/mi_algoritmo.rb
   class MiAlgoritmo
     def initialize(...) = ...
     def trace
       steps = []
       # steps << { type: "...", ... }  # un hash por paso
       steps
     end
   end
   ```

2. **El renderer** (sólo si es un tipo de visualización nuevo) — un módulo en
   `app/javascript/renderers/` que dibuja **un** paso en el `<svg>`:

   ```js
   // app/javascript/renderers/mi_viz.js
   import { svgEl, clear, placeholder } from "renderers/svg"
   export function draw(canvas, step) {
     if (!step) return placeholder(canvas, "Presioná Play")
     clear(canvas)
     // ...dibujar el paso...
   }
   ```

   Registralo en [`renderers/index.js`](app/javascript/renderers/index.js).
   Si reusás una viz existente (`bars`, `loss_curve`, ...) saltá este paso.

3. **La entrada** — agregá el registro del PORO en
   [`app/models/entry.rb`](app/models/entry.rb) (`ALGORITHMS`) y el seed en
   `db/seeds.rb` con `viz:` apuntando a tu renderer.

## 3. Agregar un patrón / anti-patrón de Rails

Son entradas `kind: "code_contrast"` (síntoma → por qué duele → antes/después).
No necesitan renderer. Copiá una existente en `db/seeds.rb` como molde. Basate en
fuentes serias (Rails AntiPatterns, POODR, la guía de Rails) y **escribí tus
propios ejemplos** — no copies texto de los libros.

## Flujo

```bash
bin/rails db:seed        # recarga tu entrada (idempotente)
bin/rails server         # verificá en el navegador
```

Después: fork → branch → PR. Mantené el estilo del código existente y un commit
claro. ¡Gracias! 🙌
