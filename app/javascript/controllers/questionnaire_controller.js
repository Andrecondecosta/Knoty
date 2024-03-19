import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="questionnaire"
export default class extends Controller {
  static targets = ["optionsElem", "formElem", "questionNumber"]
  static values = { questions: Number }

  currentOptionIndex = 0
  hasChecked = false
  actsOfService = 0
  wordsOfAffirmation = 0
  receivingGifts = 0
  qualityTime = 0
  physicalTouch = 0

  next(event) {
    event.preventDefault()
    this.#checkForCheckedOptions()
    if (this.hasChecked === true) {
      this.currentOptionIndex++
      this.questionNumberTargets.forEach(n => {
        n.innerText = `${this.currentOptionIndex + 1}/${this.questionsValue}`
      })
      this.optionsElemTargets.forEach((element) => {
        if (Number(element.id) === this.currentOptionIndex) {
          element.classList.remove('d-none')
        } else {
          element.classList.add('d-none')
        }
      })
    } else {
      alert('Please select an option')
    }
  }

  back(event) {
    event.preventDefault()
    this.currentOptionIndex--
    this.questionNumberTarget.innerText = `${this.currentOptionIndex + 1}/${this.questionsValue}`
    this.optionsElemTargets.forEach((element) => {
      if (Number(element.id) === this.currentOptionIndex) {
        element.classList.remove('d-none')
      } else {
        element.classList.add('d-none')
      }
    })
  }

  assignValues(event) {
    event.preventDefault()
    this.optionsElemTargets.forEach((elem) => {
      elem.querySelectorAll('input').forEach((input) => {
        if (input.checked) {
          switch (input.value) {
            case 'acts_of_service':
              this.actsOfService++
              break
            case 'words_of_affirmation':
              this.wordsOfAffirmation++
              break
            case 'receiving_gifts':
              this.receivingGifts++
              break
            case 'quality_time':
              this.qualityTime++
              break
            case 'physical_touch':
              this.physicalTouch++
              break
          }
        }
      })
    })
    this.formElemTarget.querySelectorAll('input').forEach((input) => {
      switch (input.name) {
        case 'love_language[acts_of_service]':
          input.value = this.actsOfService
          break
        case 'love_language[words_of_affirmation]':
          input.value = this.wordsOfAffirmation
          break
        case 'love_language[receiving_gifts]':
          input.value = this.receivingGifts
          break
        case 'love_language[quality_time]':
          input.value = this.qualityTime
          break
        case 'love_language[physical_touch]':
          input.value = this.physicalTouch
          break
      }
    })
    this.formElemTarget.submit()
  }

  #checkForCheckedOptions() {
    this.hasChecked = Array.from(document.getElementById(this.currentOptionIndex).querySelectorAll('input')).some(input => input.checked);
  }
}
