import { Controller } from "@hotwired/stimulus"
import { createConsumer } from "@rails/actioncable"

export default class extends Controller {
  static values = { chatroomId: Number, currentUserId: Number }
  static targets = ["messages"]

  connect() {
    this.messagesTarget.scrollTo(0, this.messagesTarget.scrollHeight)
    this.subscription = createConsumer().subscriptions.create(
      { channel: "ChatroomChannel", id: this.chatroomIdValue },
      { received: data => this.insertMessageOrDate(data) } // Updated callback function
    )
  }

  resetForm(event) {
    event.target.reset()
  }

  disconnect() {
    console.log("Unsubscribed from the chatroom")
    this.subscription.unsubscribe()
  }

  // private methods

  insertMessageOrDate(data) { // Updated method name
    if (data.message) {
      this.insertMessage(data.message, data.sender_id)
    } else if (data.date) {
      this.insertDate(data.date)
    }
  }

  insertMessage(message, senderId) { // New method to insert message
    const currentUserIsSender = this.currentUserIdValue === senderId
    const messageElement = this.buildMessageElement(currentUserIsSender, message)
    this.messagesTarget.insertAdjacentHTML("beforeend", messageElement)
    this.scrollToBottom()
  }

  insertDate(date) { // New method to insert date
    const dateElement = this.buildDateElement(date)
    this.messagesTarget.insertAdjacentHTML("beforebegin", dateElement)
  }

  scrollToBottom() { // New method to scroll to bottom
    this.messagesTarget.scrollTo(0, this.messagesTarget.scrollHeight)
  }

  buildMessageElement(currentUserIsSender, message) {
    return `
      <div class="message-row d-flex ${this.justifyClass(currentUserIsSender)}">
        <div class="${this.userStyleClass(currentUserIsSender)}">
          ${message}
        </div>
      </div>
    `;
  }

  buildDateElement(date) { // New method to build date element
    return `
      <div class="common-header">
        ${date}
      </div>
    `;
  }

  justifyClass(currentUserIsSender) {
    return currentUserIsSender ? "justify-content-end" : "justify-content-start";
  }

  userStyleClass(currentUserIsSender) {
    return currentUserIsSender ? "sender-style" : "receiver-style";
  }
}
