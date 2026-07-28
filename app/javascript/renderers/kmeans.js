import { CL, el } from "renderers/_svg"
// k-means: puntos coloreados por asignación, centroides con anillo. Usa ctx.points.
export function kmeans(ctx, step) {
  const svg = ctx.svg, pts = ctx.points
  svg.setAttribute("viewBox", "0 0 460 300"); svg.innerHTML = ""
  const px = x => 30 + x * 40, py = y => 282 - y * 25
  pts.forEach((p, i) => {
    const a = step && step.assign ? step.assign[i] : -1
    svg.appendChild(el("circle", {
      cx: px(p[0]), cy: py(p[1]), r: 5,
      fill: a < 0 ? "rgba(243,242,242,.45)" : CL[a], "fill-opacity": a < 0 ? .6 : .85
    }))
  })
  if (step) step.centroids.forEach((c, ci) => {
    svg.appendChild(el("circle", { cx: px(c[0]), cy: py(c[1]), r: 11, fill: "none", stroke: CL[ci], "stroke-width": 2.5 }))
    svg.appendChild(el("circle", { cx: px(c[0]), cy: py(c[1]), r: 3.5, fill: CL[ci] }))
  })
  if (step) {
    const label = { seed: "sembrar centroides", assign: "asignar al más cercano", move: "mover al promedio", done: "convergió" }[step.type]
    ctx.readout([["iteración", step.it], ["fase", label]])
  }
}
