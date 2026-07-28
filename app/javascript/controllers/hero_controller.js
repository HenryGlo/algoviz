import { Controller } from "@hotwired/stimulus"
import { linearReg } from "renderers/linear_regression"

// Autoplay decorativo del trace de regresión lineal generado en el server.
export default class extends Controller {
  static targets = ["canvas"]
  static values  = { trace: Array, points: Array }
  connect() {
    let i = 0
    const ctx = { svg: this.canvasTarget, points: this.pointsValue, readout: () => {} }
    const tick = () => { linearReg(ctx, this.traceValue[i]); i = (i + 1) % this.traceValue.length }
    tick()
    this.timer = setInterval(tick, 140)
  }
  disconnect() { clearInterval(this.timer) }
}
