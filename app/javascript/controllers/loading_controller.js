import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="loading"
export default class extends Controller {
  static targets = [ 'loading' ];

  showLoading() {
    this.loadingTarget.classList.remove('hidden');
  }

  hideLoading(){
    this.loadingTarget.classList.add('hidden');
  }
}
