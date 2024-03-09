import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="toggle"
export default class extends Controller {
  static targets = ["toggleableElem", "genderInput", "maleAvatars", "femaleAvatars", "avatarUrlInput", "imgElem", "firstDateInput", "secondDateInput", "thirdDateInput", "firstDateInputContainer", "secondDateInputContainer", "thirdDateInputContainer", "addDateButton1", "addDateButton2", "removeDateButton2", "currentUserElem", "partnerUserElem", "currentUserTab", "partnerUserTab"]

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

  showSecondDate(event) {
    event.preventDefault()
    if (this.firstDateInputTarget.value === '') {
      return alert('Please fill in the first date before adding a second date')
    }
    this.firstDateInputContainerTarget.classList.remove('col-10')
    this.secondDateInputContainerTarget.classList.remove('d-none')
    this.addDateButton1Target.classList.add('d-none')
    this.addDateButton2Target.classList.remove('d-none')
  }

  showThirdDate(event) {
    event.preventDefault()
    if (this.secondDateInputTarget.value === '') {
      return alert('Please fill in the second date before adding a third date')
    }
    this.secondDateInputContainerTarget.classList.remove('col-10')
    this.thirdDateInputContainerTarget.classList.remove('d-none')
    this.addDateButton2Target.classList.add('d-none')
    this.removeDateButton2Target.classList.remove('d-none')
  }

  removeThirdDate(event) {
    event.preventDefault()
    this.thirdDateInputTarget.value = null
    this.thirdDateInputContainerTarget.classList.add('d-none')
    this.secondDateInputContainerTarget.classList.add('col-10')
    this.addDateButton2Target.classList.remove('d-none')
    this.removeDateButton2Target.classList.add('d-none')
  }

  partnerUserProfile(){
    this.currentUserTabTarget.classList.remove('active')
    this.partnerUserTabTarget.classList.add('active')
    this.currentUserElemTarget.classList.add('d-none')
    this.partnerUserElemTarget.classList.remove('d-none')
  }

  currentUserProfile(){
    this.currentUserTabTarget.classList.add('active')
    this.partnerUserTabTarget.classList.remove('active')
    this.currentUserElemTarget.classList.remove('d-none')
    this.partnerUserElemTarget.classList.add('d-none')
  }
}
