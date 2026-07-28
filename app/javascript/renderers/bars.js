import { CL, el } from "renderers/_svg"
// bubble sort: barras, par comparado resaltado, cola ordenada en verde
export function bars(ctx, step) {
  const svg = ctx.svg
  svg.setAttribute("viewBox", "0 0 460 220"); svg.innerHTML = ""
  const arr = step ? step.array : []
  const bw = 44, gap = 14, x0 = (460 - (arr.length * bw + (arr.length - 1) * gap)) / 2
  arr.forEach((v, n) => {
    let col = "#85b7eb"
    if (step) {
      if (n >= step.sorted || step.type === "done") col = CL[1]
      if (n === step.i || n === step.k) col = CL[2]
    }
    const bh = v * 20 + 10, x = x0 + n * (bw + gap), y = 200 - bh
    svg.appendChild(el("rect", { x, y, width: bw, height: bh, rx: 6, fill: col }))
    const t = el("text", { x: x + bw / 2, y: y - 6, "text-anchor": "middle", "font-size": 13, fill: "#f3f2f2" })
    t.textContent = v; svg.appendChild(t)
  })
  if (step) ctx.readout([["paso", step.type], ["comparaciones", step.cmp]])
}
