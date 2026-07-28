import { Controller } from "@hotwired/stimulus"

// Tabs de lenguaje (Python / Ruby) del bloque de código. Server-rendered:
// el resaltado ya viene de Rouge; esto sólo muestra/oculta el panel activo.
export default class extends Controller {
  static targets = ["tab", "panel"]

  select(event) {
    const lang = event.currentTarget.dataset.lang
    this.tabTargets.forEach(t => t.classList.toggle("code__tab--on", t.dataset.lang === lang))
    this.panelTargets.forEach(p => p.classList.toggle("code__panel--on", p.dataset.lang === lang))
  }
}
