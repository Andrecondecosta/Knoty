import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="audio"
export default class extends Controller {
  static targets = ["storyAudio"]

  playAudio() {
    if (this.storyAudioTarget.paused) {
      this.storyAudioTarget.play();
    } else {
      this.storyAudioTarget.pause();
    }
  }
}
