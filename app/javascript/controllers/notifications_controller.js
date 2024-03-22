import { Controller } from "@hotwired/stimulus"
import { createConsumer } from "@rails/actioncable"

// Connects to data-controller="notifications"
export default class extends Controller {
  static targets = ["badge"]
  static values = { count: String }

  connect() {
    const notifBadge = this.badgeTarget;
    if (Number(this.countValue) > 0) {
      notifBadge.innerText = this.countValue;
      notifBadge.classList.remove("d-none");
    } else {
      notifBadge.classList.add("d-none");
    }

    createConsumer().subscriptions.create("NotificationsChannel",
      {
        received(data) {
          if (data != 0 && !window.location.pathname.includes('chatrooms/')) {
            notifBadge.classList.remove("d-none");
            notifBadge.innerText = data < 99 ? data : '99+';

            const audio = new Audio("https://res.cloudinary.com/dvgcwuo68/video/upload/v1711123189/splash_rxfhxn.mp3");
            audio.volume = 0.5;

            if ([1, 3, 5, 7, 9].includes(data)) audio.play();
          }
        }
      });
  }
}
