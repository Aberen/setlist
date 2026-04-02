import { Controller } from "@hotwired/stimulus"
import { createConsumer } from "@rails/actioncable"

export default class extends Controller {
  static values = { setlistId: Number }
  static targets = ["viewerCount"]

  connect() {
    console.log("SetlistSyncController connected for setlist", this.setlistIdValue)
    this.consumer = createConsumer()
    this.subscription = this.consumer.subscriptions.create(
      { channel: "SetlistChannel", setlist_id: this.setlistIdValue },
      {
        received: (data) => {
          console.log("SetlistSyncController received:", data)
          // Handle viewer count updates
          if (data.type === "viewer_count_update") {
            console.log("Viewer count update:", data.viewer_count)
            this.updateViewerCount(data.viewer_count)
            return
          }

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

  updateViewerCount(count) {
    console.log("updateViewerCount called with:", count)
    if (!this.hasViewerCountTarget) {
      console.log("No viewerCountTarget found")
      return
    }
    
    const badge = document.getElementById("live-viewers-badge")
    const countEl = this.viewerCountTarget
    
    console.log("badge:", badge, "countEl:", countEl)
    
    if (count > 1) {
      countEl.textContent = count
      badge.style.display = "flex"
      console.log("Showing badge with count:", count)
    } else {
      badge.style.display = "none"
      console.log("Hiding badge (count <= 1)")
    }
  }

  disconnect() {
    console.log("SetlistSyncController disconnected")
    if (this.subscription) this.subscription.unsubscribe()
    if (this.consumer) this.consumer.disconnect()
  }
}
