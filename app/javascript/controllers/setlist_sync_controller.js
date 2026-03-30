import { Controller } from "@hotwired/stimulus"
import { createConsumer } from "@rails/actioncable"

export default class extends Controller {
  static values = { setlistId: Number }

  connect() {
    this.consumer = createConsumer()
    this.subscription = this.consumer.subscriptions.create(
      { channel: "SetlistChannel", setlist_id: this.setlistIdValue },
      {
        received: (data) => {
          // Another user made a change — update our DOM
          const target = document.getElementById("setlist-items-content")
          if (target && data.html) {
            // Use Turbo to morph in the new content so Stimulus controllers reconnect
            const tmp = document.createElement("div")
            tmp.innerHTML = data.html.trim()
            const newContent = tmp.firstElementChild
            if (newContent) {
              target.replaceWith(newContent)
            }
          }
        }
      }
    )
  }

  disconnect() {
    if (this.subscription) this.subscription.unsubscribe()
    if (this.consumer) this.consumer.disconnect()
  }
}
