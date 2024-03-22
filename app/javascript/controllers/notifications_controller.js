import { Controller } from "@hotwired/stimulus"
import { createConsumer } from "@rails/actioncable"

// Connects to data-controller="notifications"
export default class extends Controller {
  static targets = ["btn"]

  connect() {
    const button = this.btnTarget;
    createConsumer().subscriptions.create("NotificationsChannel",
      {
        received(data) {
          // Update unread message count in real-time
          button.value = `${data} messages`;

          // Create an audio element
          const audio = new Audio("https://res.cloudinary.com/dvgcwuo68/video/upload/v1711123189/splash_rxfhxn.mp3");
          // Set the volume of the audio
          audio.volume = 0.5; // Adjust the value between 0 and 1 to control the volume
          // Play the audio
          audio.play();
        }
      });
  }
}
