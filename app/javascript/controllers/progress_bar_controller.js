import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="progress-bar"
export default class extends Controller {
  static targets = ["progress", "circle"]
  static values = { currentScore: String }

  score = Number(this.currentScoreValue)
  scoreToDisplay = (this.score / 3) > 100 ? (this.score / 3 - 100) : this.score / 3
  progressBar = this.progressTarget
  stepCircles = this.circleTargets
  currentActive = 1

  connect() {
    this.#changeCurrentActive();
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

    this.progressBar.style.width = `${this.scoreToDisplay}%`;
  }

  // private
  #changeCurrentActive() {
    if (this.scoreToDisplay >= 100) {
      this.currentActive = 4;
    } else if (this.scoreToDisplay >= 66) {
      this.currentActive = 3;
    } else if (this.scoreToDisplay >= 33) {
      this.currentActive = 2;
    }
  }
}
