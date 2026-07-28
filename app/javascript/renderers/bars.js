import { svgEl, clear, placeholder } from "renderers/svg"

// Renderer de sorting: dibuja el array como barras y resalta comparaciones,
// swaps y la cola ya ordenada según el paso del trace.
const W = 460, H = 260
const PAD_X = 18, TOP = 26, BASE = 232, GAP = 6

export function draw(canvas, step) {
  if (!step) return placeholder(canvas, "Presioná Play para ordenar")

  clear(canvas)
  const a = step.array
  const n = a.length
  const max = Math.max(...a, 1)
  const bandW = (W - PAD_X * 2) / n
  const barW = bandW - GAP
  const usableH = BASE - TOP

  a.forEach((value, idx) => {
    const h = Math.max(4, (value / max) * usableH)
    const x = PAD_X + idx * bandW + GAP / 2
    const y = BASE - h

    canvas.appendChild(svgEl("rect", {
      x, y, width: barW, height: h, rx: 4,
      class: `bar ${barClass(step, idx, n)}`
    }))
    canvas.appendChild(svgEl("text", {
      x: x + barW / 2, y: BASE + 16, "text-anchor": "middle", class: "bar-label"
    }, value))
  })

  canvas.appendChild(svgEl("text", {
    x: PAD_X, y: 18, class: "viz-caption"
  }, caption(step)))
}

function barClass(step, idx, n) {
  const sorted = step.sorted ?? n
  if (step.type === "done" || idx >= sorted) return "bar--sorted"
  if (idx === step.i || idx === step.k) {
    return step.type === "swap" ? "bar--swap" : "bar--compare"
  }
  return ""
}

function caption(step) {
  switch (step.type) {
    case "compare": return `Comparo ${step.i} y ${step.k}`
    case "swap":    return `Intercambio ${step.i} y ${step.k}`
    case "done":    return "Ordenado ✓"
    default:        return ""
  }
}
