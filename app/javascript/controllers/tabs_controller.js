import { Controller } from "@hotwired/stimulus"

// Tabs de lenguaje para el bloque de código.
export default class extends Controller {
  static targets = ["code"]
  static values  = { code: Object }
  pick(e) {
    const lang = e.params.lang
    this.codeTarget.textContent = this.codeValue[lang]
    this.element.querySelectorAll(".tab").forEach(t => t.classList.remove("on"))
    e.currentTarget.classList.add("on")
  }
}
