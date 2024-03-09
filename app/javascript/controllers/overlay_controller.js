import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = [ "overlay" ]

  connect() {
    console.log("Overlay controller connected");
  }

  toggleOverlay(event) {
    event.stopPropagation();
    console.log("Toggle overlay action triggered");
    if (this.overlayTarget.classList.contains('d-none')) {
      this.overlayTarget.classList.remove('d-none');
      this.element.classList.add('no-slide');
    } else {
      this.overlayTarget.classList.add('d-none');
      this.element.classList.remove('no-slide');
    }
  }
}
