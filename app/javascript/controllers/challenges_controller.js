import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="form-check"
export default class extends Controller {
  static targets = ["challengeBriefing", "form", "challengeDate"]

  formFilled = false;

  connect() {
    console.log(this.challengeDateTarget)
  }

  beginChallenge() {
    this.challengeBriefingTarget.classList.add('d-none');
    this.challengeDateTarget.classList.remove('d-none');
  }

  backToBriefing(event) {
    event.preventDefault()
    this.challengeBriefingTarget.classList.remove('d-none');
    this.challengeDateTarget.classList.add('d-none');
  }

  checkInput(event) {
    event.preventDefault()
    this.#verifyForm();
    if (this.formFilled) {
      this.formTarget.submit();
    } else {
      alert('Please fill in at least one date field.');
    }
  }

  // private

  #verifyForm() {
    this.formFilled = Array.from(this.formTarget.querySelectorAll('input.date')).some(input => input.value);
  }
}
