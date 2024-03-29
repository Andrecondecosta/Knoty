import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = [ "card" ]

  cards = this.cardTargets

  toggleCard(event){
    this.cards.forEach(card => card.classList.remove('app-card-active'))
    event.currentTarget.classList.add('app-card-active')
  }
}
