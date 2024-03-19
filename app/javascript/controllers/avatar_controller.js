// avatar_controller.js
import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["overlay", "avatar", "avatarField"]

  toggleOverlay(event) {
    event.preventDefault();
    this.overlayTarget.classList.toggle('d-none');
  }

  selectAvatar(event) {
    event.preventDefault();
    this.avatarTarget.src = event.currentTarget.src;
    this.avatarFieldTarget.value = event.currentTarget.src;
    this.overlayTarget.classList.add('d-none');
  }
}
