import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="island-slide"
export default class extends Controller {
  static targets = ["parentElem"]


  handleMouseDown(event) {
    event.preventDefault();
    this.isDragging = true;
    this.startX = event.clientX;
    this.scrollLeft = this.parentElemTarget.scrollLeft;
  }

  handleMouseMove(event) {
    if (!this.isDragging) return;
    const x = event.clientX - this.startX;
    this.parentElemTarget.scrollLeft = this.scrollLeft - x;
  }

  handleMouseUp() {
    this.isDragging = false;
  }

  handleMouseLeave() {
    this.isDragging = false;
  }
}
