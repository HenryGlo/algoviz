# algoviz

Plataforma web pública que explica algoritmos de ML y patrones de software
**animándolos paso a paso**, con la implementación en Python y Ruby al lado.
Hecha en **Rails 8 + Hotwire**, todo server-rendered.

## La idea que hace que escale

El algoritmo (Ruby, en el server) **no anima nada**: sólo emite un `trace`
(un array de pasos). Ese trace se serializa a JSON, viaja al view como data
attribute, y un controller de Stimulus lo reproduce.

```
PORO de algoritmo  →  #trace (array de pasos)  →  JSON en data attribute
                                                         │
                          player_controller.js  ◄────────┘
                                    │  delega el dibujo de cada paso
                                    ▼
                          renderers/<viz>.js  →  <svg>
```

- **`app/algorithms/*.rb`** — cada algoritmo es un PORO con `#trace`. Es a la vez
  el código canónico que se muestra y la fuente de la animación.
- **`app/javascript/controllers/player_controller.js`** — un único Player
  (play / pausa / paso / reset / velocidad). Se reutiliza siempre.
- **`app/javascript/renderers/*.js`** — un renderer por tipo de visualización
  (`loss_curve`, `bars`). Dibujan un paso en un `<svg>`.

**Agregar un algoritmo = un PORO de trace + (si es una viz nueva) un renderer.**

## Stack

Rails 8 · Ruby 3.3 · Hotwire (Turbo + Stimulus) · Propshaft + importmap (sin Node)
· SQLite + Solid Queue/Cache/Cable · Rouge (highlight server-side) · commonmarker
(Markdown) · Deploy con Docker en Render.

## Correr en local

```bash
bin/rails db:prepare db:seed
bin/rails server
```

Abrí http://localhost:3000.

## Pantallas

- `/` — home: hero + grilla de categorías + destacados.
- `/:category_slug` — índice de categoría con filtro por subtipo vía **Turbo Frame**
  (re-render server-side, sin recargar).
- `/:category_slug/:entry_slug` — entrada: intuición → visualización (Player) →
  tabs Python/Ruby → nota de complejidad → prosa en Markdown.

## Deploy

Ver [`DEPLOY.md`](DEPLOY.md). En resumen: conectás el repo en Render como
Blueprint (`render.yaml`) y cargás `RAILS_MASTER_KEY`.
