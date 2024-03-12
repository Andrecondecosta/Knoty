import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="form"
export default class extends Controller {
  static targets = ["form", "completionDateInput", "radios"]

  dateChosen = false;

  chooseDate(event) {
    event.preventDefault();
    this.#verifyForm();
    if (this.dateChosen) {
      this.formTarget.submit();
    } else {
      alert("You must choose a date");
    }
  }

  // private

  #verifyForm() {
    this.dateChosen = Array.from(this.radiosTarget.querySelectorAll('input[type="radio"]')).some(input => input.checked);
  }
}
