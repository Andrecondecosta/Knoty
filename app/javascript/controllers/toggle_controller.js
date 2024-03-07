import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="toggle"
export default class extends Controller {
  static targets = ["toggleableElem", "genderInput", "maleAvatars", "femaleAvatars", "avatarUrlInput", "imgElem"]

  toggleElems(event) {
    event.preventDefault()
    this.toggleableElemTargets.forEach((toggleable) => {
      toggleable.classList.toggle('d-none')
    })
    if (this.genderInputTarget.value === 'Male') {
      this.maleAvatarsTarget.classList.remove('d-none')
      this.femaleAvatarsTarget.classList.add('d-none')
    } else if (this.genderInputTarget.value === 'Female') {
      this.maleAvatarsTarget.classList.add('d-none')
      this.femaleAvatarsTarget.classList.remove('d-none')
    } else {
      this.maleAvatarsTarget.classList.remove('d-none')
      this.femaleAvatarsTarget.classList.remove('d-none')
    }
  }

  selectAvatar(event) {
    this.imgElemTargets.forEach((img) => {
      img.classList.remove('avatar-selected')
    })
    event.currentTarget.classList.add('avatar-selected')
    const avatarUrl = event.currentTarget.src
    this.avatarUrlInputTarget.value = avatarUrl
  }
}
