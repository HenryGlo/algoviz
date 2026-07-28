export const CL = ["#b98bff", "#56d4a0", "#f5b544"]
const NS = "http://www.w3.org/2000/svg"
export function el(tag, attrs) {
  const n = document.createElementNS(NS, tag)
  for (const k in attrs) n.setAttribute(k, attrs[k])
  return n
}
