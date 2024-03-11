import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["overlay", "islandsImage", "bookButton"]

  toggleOverlay(event) {
    event.preventDefault();
    if (this.overlayTarget.classList.contains('d-none')) {
      this.overlayTarget.classList.remove('d-none');
      this.element.classList.add('no-slide');
      this.islandsImageTarget.classList.add('blurry-background');
      this.bookButtonTarget.classList.add('book-active');
    } else {
      this.overlayTarget.classList.add('d-none');
      this.element.classList.remove('no-slide');
      this.islandsImageTarget.classList.remove('blurry-background');
      this.bookButtonTarget.classList.remove('book-active');
    }
  }
}
