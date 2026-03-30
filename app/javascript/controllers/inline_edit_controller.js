import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["display", "form", "input"]

  connect()  { this.showDisplay() }
  edit()     { this.showForm(); this.inputTarget?.focus() }
  cancel()   { this.showDisplay() }
  submit()   { this.formTarget?.querySelector("form")?.requestSubmit() }

  handleKey(e) {
    if (e.key === "Enter" && !e.shiftKey) { e.preventDefault(); this.submit() }
    if (e.key === "Escape") this.cancel()
  }

  showDisplay() {
    if (this.hasDisplayTarget) this.displayTarget.style.display = ""
    if (this.hasFormTarget)    this.formTarget.style.display    = "none"
  }

  showForm() {
    if (this.hasDisplayTarget) this.displayTarget.style.display = "none"
    if (this.hasFormTarget)    this.formTarget.style.display    = ""
  }
}
