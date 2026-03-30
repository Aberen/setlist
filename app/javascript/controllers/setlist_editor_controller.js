import { Controller } from "@hotwired/stimulus"
import Sortable from "sortablejs"
import { renderStreamMessage } from "@hotwired/turbo"

export default class extends Controller {
  static values = { setlistId: Number }

  connect() {
    this.sortable = Sortable.create(this.element, {
      handle: ".drag-handle",
      animation: 150,
      ghostClass: "setlist-item--dragging",
      onEnd: this.onSortEnd.bind(this)
    })
  }

  disconnect() {
    if (this.sortable) {
      this.sortable.destroy()
      this.sortable = null
    }
  }

  async onSortEnd(event) {
    const itemId    = event.item.dataset.itemId
    const newPos    = event.newIndex + 1
    const setlistId = this.setlistIdValue
    const csrf      = document.querySelector('meta[name="csrf-token"]').content

    try {
      const response = await fetch(`/setlists/${setlistId}/setlist_items/${itemId}`, {
        method: "PATCH",
        headers: {
          "Content-Type": "application/x-www-form-urlencoded",
          "X-CSRF-Token": csrf,
          "Accept": "text/vnd.turbo-stream.html, text/html"
        },
        body: new URLSearchParams({ "setlist_item[position]": newPos })
      })

      if (response.ok) {
        const html = await response.text()
        renderStreamMessage(html)
      } else {
        console.error("Reorder failed:", response.status)
      }
    } catch(e) {
      console.error("Reorder error:", e)
    }
  }
}
