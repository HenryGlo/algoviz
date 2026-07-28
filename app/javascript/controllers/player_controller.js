import { Controller } from "@hotwired/stimulus"
import * as renderers from "renderers"

// Un solo Player para todas las visualizaciones. No sabe nada del algoritmo:
// recibe un trace (array de pasos) por data attribute y delega el dibujo de
// cada paso a un renderer elegido por su id (`renderer` value == entry.viz).
export default class extends Controller {
  static values = {
    trace: Array,
    renderer: String,
    speed: { type: Number, default: 420 }
  }
  static targets = ["canvas", "playLabel", "progress"]

  connect() {
    this.i = -1
    this.render = renderers[this.rendererValue]
    this.draw()
  }

  disconnect() { this.pause() }

  toggle() { this.timer ? this.pause() : this.play() }

  play() {
    if (this.atEnd) this.i = -1               // re-arrancar si terminó
    this.timer = setInterval(() => this.step(), this.speedValue)
    this.setPlaying(true)
  }

  pause() {
    clearInterval(this.timer)
    this.timer = null
    this.setPlaying(false)
  }

  step() {
    if (this.i < this.traceValue.length - 1) {
      this.i++
      this.draw()
    } else {
      this.pause()
    }
  }

  reset() {
    this.pause()
    this.i = -1
    this.draw()
  }

  // <input type="range"> -> delay en ms (más a la derecha = más rápido).
  setSpeed(event) {
    const pct = Number(event.target.value)           // 0..100
    this.speedValue = Math.round(60 + (100 - pct) * 9) // ~960ms .. 60ms
    if (this.timer) { this.pause(); this.play() }
  }

  draw() {
    const step = this.i < 0 ? null : this.traceValue[this.i]
    if (this.render) this.render(this.canvasTarget, step)
    this.updateProgress()
  }

  get atEnd() { return this.i >= this.traceValue.length - 1 }

  setPlaying(on) {
    if (this.hasPlayLabelTarget) this.playLabelTarget.textContent = on ? "Pausa" : "Play"
  }

  updateProgress() {
    if (!this.hasProgressTarget) return
    const total = this.traceValue.length
    const shown = this.i < 0 ? 0 : this.i + 1
    this.progressTarget.textContent = `${shown} / ${total}`
  }
}
