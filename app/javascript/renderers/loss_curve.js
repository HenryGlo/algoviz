import { svgEl, clear, placeholder } from "renderers/svg"

// Renderer de gradient descent: dibuja la curva de pérdida L(w) = (w-3)²
// y la bolita que baja por la pendiente en cada paso del trace.
const W = 460, H = 260
const PAD_X = 34, TOP = 24, BASE = 230
const W_MIN = -2, W_MAX = 8, L_MAX = 26

const plotW = (460 - PAD_X * 2)
const plotH = (BASE - TOP)

const sx = (w) => PAD_X + ((w - W_MIN) / (W_MAX - W_MIN)) * plotW
const sy = (loss) => BASE - (Math.min(loss, L_MAX) / L_MAX) * plotH
const lossAt = (w) => (w - 3) ** 2

export function draw(canvas, step) {
  if (!step) return placeholder(canvas, "Presioná Play para descender")

  clear(canvas)

  // Ejes
  canvas.appendChild(svgEl("line", { x1: PAD_X, y1: BASE, x2: 460 - PAD_X, y2: BASE, class: "axis" }))
  canvas.appendChild(svgEl("line", { x1: PAD_X, y1: TOP, x2: PAD_X, y2: BASE, class: "axis" }))

  // Curva L(w)
  const pts = []
  for (let w = W_MIN; w <= W_MAX + 0.001; w += 0.2) pts.push(`${sx(w).toFixed(1)},${sy(lossAt(w)).toFixed(1)}`)
  canvas.appendChild(svgEl("polyline", { points: pts.join(" "), class: "loss-curve" }))

  // Mínimo (w = 3)
  canvas.appendChild(svgEl("circle", { cx: sx(3), cy: sy(0), r: 3, class: "loss-min" }))
  canvas.appendChild(svgEl("text", { x: sx(3), y: BASE + 15, "text-anchor": "middle", class: "bar-label" }, "w=3"))

  // Punto actual + proyección
  const cx = sx(step.w), cy = sy(step.loss)
  canvas.appendChild(svgEl("line", { x1: cx, y1: cy, x2: cx, y2: BASE, class: "drop-line" }))
  canvas.appendChild(svgEl("circle", { cx, cy, r: 7, class: `ball ${step.type === "done" ? "ball--done" : ""}` }))

  // Caption
  canvas.appendChild(svgEl("text", { x: PAD_X, y: 16, class: "viz-caption" },
    `w = ${step.w}   ·   L(w) = ${step.loss}${step.type === "done" ? "   ✓" : ""}`))
}
