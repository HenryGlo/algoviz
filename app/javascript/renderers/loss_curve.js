import { CL, el } from "renderers/_svg"
// gradient descent: parábola + bolita en (w, loss)
export function lossCurve(ctx, step) {
  const svg = ctx.svg
  svg.setAttribute("viewBox", "0 0 460 260"); svg.innerHTML = ""
  const sx = v => 40 + (v + 2.2) / 10.4 * 400
  const sy = L => 222 - L / 26 * 202
  svg.appendChild(el("line", { x1: 40, y1: 20, x2: 40, y2: 222, stroke: "rgba(243,242,242,.25)" }))
  svg.appendChild(el("line", { x1: 40, y1: 222, x2: 446, y2: 222, stroke: "rgba(243,242,242,.25)" }))
  let pts = ""
  for (let v = -2.2; v <= 8.2; v += 0.1) pts += `${sx(v).toFixed(1)},${sy((v - 3) ** 2).toFixed(1)} `
  svg.appendChild(el("polyline", { points: pts, fill: "none", stroke: CL[0], "stroke-width": 2 }))
  if (step) {
    svg.appendChild(el("circle", { cx: sx(step.w), cy: sy(step.loss), r: 7, fill: CL[2] }))
    ctx.readout([["iteración", step.it], ["pérdida", step.loss.toFixed(3)], ["w", step.w.toFixed(3)]])
  }
}
