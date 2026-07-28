// Helpers mínimos para construir SVG desde los renderers.
const NS = "http://www.w3.org/2000/svg"

export function svgEl(name, attrs = {}, text = null) {
  const node = document.createElementNS(NS, name)
  for (const [k, v] of Object.entries(attrs)) node.setAttribute(k, v)
  if (text != null) node.textContent = text
  return node
}

export function clear(canvas) {
  while (canvas.firstChild) canvas.removeChild(canvas.firstChild)
}

export function placeholder(canvas, text) {
  clear(canvas)
  canvas.appendChild(
    svgEl("text", { x: 230, y: 132, "text-anchor": "middle", class: "viz-placeholder" }, text)
  )
}
