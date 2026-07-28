import { Controller } from "@hotwired/stimulus"
import * as renderers from "renderers"

// El "VCR de Stimulus": maneja el tiempo, no sabe nada del algoritmo.
// Lee un trace (array de pasos) de un data attribute y lo reproduce.
export default class extends Controller {
  static targets = ["canvas", "scrub", "status", "readout", "play"]
  static values = {
    trace:    Array,
    points:   { type: Array,  default: [] }, // dataset estático para scatter
    renderer: String,
    speed:    { type: Number, default: 1 }
  }

  connect() {
    this.render = renderers[this.rendererValue]
    this.i = 0
    this.scrubTarget.max = this.traceValue.length - 1
    this.draw()
  }
  disconnect() { this.pause() }

  draw() {
    this.render(
      { svg: this.canvasTarget, points: this.pointsValue, readout: (r) => this.#readout(r) },
      this.traceValue[this.i]
    )
    this.scrubTarget.value = this.i
    this.statusTarget.textContent = `${this.i} / ${this.traceValue.length - 1}`
  }

  toggle() { this.timer ? this.pause() : this.play() }
  play() {
    if (this.timer) return
    if (this.i >= this.traceValue.length - 1) this.i = 0
    this.playTarget.classList.add("is-playing")
    this.timer = setInterval(() => {
      if (this.i >= this.traceValue.length - 1) return this.pause()
      this.i++; this.draw()
    }, 640 / this.speedValue)
  }
  pause() {
    clearInterval(this.timer); this.timer = null
    this.playTarget.classList.remove("is-playing")
  }
  step()  { this.pause(); if (this.i < this.traceValue.length - 1) { this.i++; this.draw() } }
  reset() { this.pause(); this.i = 0; this.draw() }
  seek(e) { this.pause(); this.i = +e.target.value; this.draw() }
  setSpeed(e) { this.speedValue = +e.target.value; if (this.timer) { this.pause(); this.play() } }

  #readout(rows) {
    this.readoutTarget.innerHTML = rows
      .map(([k, v]) => `<div class="stat"><div class="k">${k}</div><div class="v">${v}</div></div>`)
      .join("")
  }
}
