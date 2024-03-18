import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="progress-bar"
export default class extends Controller {
  static targets = ["progress", "circle"]
  static values = { currentProgress: String }

  currentActive = Number(this.currentProgressValue)
  progressBar = this.progressTarget
  stepCircles = this.circleTargets

  connect() {
    this.update(this.currentActive);
  }

  update(currentActive) {
    this.stepCircles.forEach((circle, i) => {
      if (i < currentActive) {
        circle.classList.add("activated");
      } else {
        circle.classList.remove("activated");
      }
    });

    const activeCircles = document.querySelectorAll(".activated");
    this.progressBar.style.width =
      ((activeCircles.length - 1) / (this.stepCircles.length - 1)) * 100 + "%";
  }
}
