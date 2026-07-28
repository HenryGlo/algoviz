import { Controller } from "@hotwired/stimulus"

// Los chips de subtipo filtran las tarjetas (client-side).
export default class extends Controller {
  pick(e) {
    const f = e.params.sub
    this.element.querySelectorAll(".chip").forEach(c => {
      c.classList.remove("on"); c.style.cssText = ""
    })
    e.currentTarget.classList.add("on")
    this.element.querySelectorAll(".entry-card").forEach(card => {
      card.style.display = (f === "all" || card.dataset.sub === f) ? "" : "none"
    })
  }
}
