import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="quests"
export default class extends Controller {
  static targets = ["activeQuestsTab", "pendingQuestsTab", "indivQuestsTab1", "indivQuestsTab2"]

  activeQuests() {
    this.activeQuestsTabTarget.classList.remove("d-none")
    this.pendingQuestsTabTarget.classList.add("d-none")
  }

  pendingQuests() {
    this.activeQuestsTabTarget.classList.add("d-none")
    this.pendingQuestsTabTarget.classList.remove("d-none")
  }

  indivQuests1() {
    this.indivQuestsTab1Target.classList.remove("d-none")
    this.indivQuestsTab2Target.classList.add("d-none")
  }

  indivQuests2() {
    this.indivQuestsTab1Target.classList.add("d-none")
    this.indivQuestsTab2Target.classList.remove("d-none")
  }
}
