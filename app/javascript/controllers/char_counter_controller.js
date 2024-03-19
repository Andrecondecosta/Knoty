import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="char-counter"
export default class extends Controller {
  static targets = ["input", "counterDisplay"]

  updateCounter() {
    if (this.inputTarget.value.length > 65) {
      this.inputTarget.classList.add('bg-danger-subtle');
      this.counterDisplayTarget.innerText = `Max exceeded by ${this.inputTarget.value.length - 65} characters`;
    } else {
      this.inputTarget.classList.remove('bg-danger-subtle');
      if (this.inputTarget.value.length === 0) {
        this.counterDisplayTarget.innerText = '';
      } else {
        this.counterDisplayTarget.innerText = `${this.inputTarget.value.length} characters`;
      }
    }
  }
}
