import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="select-submit"
export default class extends Controller {
  static targets = ["select"]

  connect() {
    this.selectTarget.addEventListener("change", this.submitForm.bind(this))
  }

  submitForm() {
    this.element.requestSubmit()
  }
}
