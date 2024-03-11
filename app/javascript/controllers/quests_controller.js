import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="quests"
export default class extends Controller {
  static targets = ["exploreQuestsLink", "inProgressLink", "exploreQuestsTab", "inProgressTab", "activeQuestsTab", "pendingQuestsTab", "indivQuestsTab1", "indivQuestsTab2"]

  connect() {
    console.log("Quests controller connected")
  }

  exploreQuests() {
    this.exploreQuestsLinkTarget.classList.add("bg-opacity-50")
    this.inProgressLinkTarget.classList.remove("bg-opacity-50")
    this.exploreQuestsTabTarget.classList.remove("d-none")
    this.inProgressTabTarget.classList.add("d-none")
  }

  inProgress() {
    this.exploreQuestsLinkTarget.classList.remove("bg-opacity-50")
    this.inProgressLinkTarget.classList.add("bg-opacity-50")
    this.exploreQuestsTabTarget.classList.add("d-none")
    this.inProgressTabTarget.classList.remove("d-none")
  }

  activeQuests() {
    this.activeQuestsTabTarget.classList.remove("d-none")
    this.pendingQuestsTabTarget.classList.add("d-none")
    this.indivQuestsTab1Target.classList.add("d-none")
    this.indivQuestsTab2Target.classList.add("d-none")
  }

  pendingQuests() {
    this.activeQuestsTabTarget.classList.add("d-none")
    this.pendingQuestsTabTarget.classList.remove("d-none")
    this.indivQuestsTab1Target.classList.add("d-none")
    this.indivQuestsTab2Target.classList.add("d-none")
  }

  indivQuests1() {
    this.activeQuestsTabTarget.classList.add("d-none")
    this.pendingQuestsTabTarget.classList.add("d-none")
    this.indivQuestsTab1Target.classList.remove("d-none")
    this.indivQuestsTab2Target.classList.add("d-none")
  }

  indivQuests2() {
    this.activeQuestsTabTarget.classList.add("d-none")
    this.pendingQuestsTabTarget.classList.add("d-none")
    this.indivQuestsTab1Target.classList.add("d-none")
    this.indivQuestsTab2Target.classList.remove("d-none")
  }
}
