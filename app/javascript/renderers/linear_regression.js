import { CL, el } from "renderers/_svg"
// regresión lineal: scatter + la recta ajustada actual. Usa ctx.points.
export function linearReg(ctx, step) {
  const svg = ctx.svg, pts = ctx.points
  svg.setAttribute("viewBox", "0 0 460 280"); svg.innerHTML = ""
  const px = x => 34 + x * 40, py = y => 250 - y * 22
  svg.appendChild(el("line", { x1: 34, y1: 20, x2: 34, y2: 250, stroke: "rgba(243,242,242,.25)" }))
  svg.appendChild(el("line", { x1: 34, y1: 250, x2: 446, y2: 250, stroke: "rgba(243,242,242,.25)" }))
  pts.forEach(p => svg.appendChild(el("circle", { cx: px(p[0]), cy: py(p[1]), r: 4.5, fill: CL[1], "fill-opacity": .8 })))
  if (step) {
    svg.appendChild(el("line", {
      x1: px(0), y1: py(step.b), x2: px(10), y2: py(step.w * 10 + step.b),
      stroke: CL[2], "stroke-width": 2.5
    }))
    ctx.readout([["iteración", step.it], ["MSE", step.loss.toFixed(3)], ["w", step.w.toFixed(2)], ["b", step.b.toFixed(2)]])
  }
}
