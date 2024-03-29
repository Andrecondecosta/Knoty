import { Controller } from "@hotwired/stimulus"
import { createConsumer } from "@rails/actioncable"

export default class extends Controller {
  static values = { chatroomId: Number, currentUserId: Number, currentUserAvatarUrl: String, partnerAvatarUrl: String }
  static targets = ["messages", "form", "input"]

  connect() {
    this.messagesTarget.scrollTo(0, this.messagesTarget.scrollHeight)
    this.subscription = createConsumer().subscriptions.create(
      { channel: "ChatroomChannel", id: this.chatroomIdValue },
      {
        received: data => {
          this.insertMessage(data.message, data.sender_id)
        }
      }
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

  insertMessage(message, senderId) {
    const currentUserIsSender = this.currentUserIdValue === senderId
    const messageElement = this.buildMessageElement(currentUserIsSender, message)
    this.messagesTarget.insertAdjacentHTML("beforeend", messageElement)
    this.scrollToBottom()
  }

  scrollToBottom() {
    this.messagesTarget.scrollTo(0, this.messagesTarget.scrollHeight)
  }

  buildMessageElement(currentUserIsSender, message) {
    const avatar = currentUserIsSender ? this.currentUserAvatarUrlValue : this.partnerAvatarUrlValue;
    const avatarMargin = currentUserIsSender ? 'margin-left:10px;' : 'margin-right:10px;'
    let receiverImageElem = '';
    let senderImageElem = ''
    const imageElem = `
    <img src="${avatar}" alt="avatar" style="width: 30px; height: 30px; border-radius: 50%; box-shadow: 0 0 5px rgba(0, 0, 0, 0.5); ${avatarMargin}"> `
    currentUserIsSender ? senderImageElem = imageElem : receiverImageElem = imageElem;

    return `
    <div class="message-row d-flex ${this.justifyClass(currentUserIsSender)}">
      ${receiverImageElem}
      <div class="${this.userStyleClass(currentUserIsSender)}">
        ${message}
      </div>
      ${senderImageElem}
    </div>
    `;
  }

  justifyClass(currentUserIsSender) {
    return currentUserIsSender ? "justify-content-end" : "justify-content-start";
  }

  userStyleClass(currentUserIsSender) {
    return currentUserIsSender ? "sender-style" : "receiver-style";
  }

  sendMessage(event) {
    if (event.key === 'Enter') {
      event.preventDefault()
      this.formTarget.requestSubmit()
    }
  }
}
