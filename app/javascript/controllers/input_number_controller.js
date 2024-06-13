import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="input-number"
export default class extends Controller {
  static targets = ["input"];

  decrease() {
    let currentValue = parseInt(this.inputTarget.value);
    if (currentValue > 0) {
      this.inputTarget.value = currentValue - 1;
    }
  }

  increase() {
    let currentValue = parseInt(this.inputTarget.value);
    this.inputTarget.value = currentValue + 1;
  }
}
