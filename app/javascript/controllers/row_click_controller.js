import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="row-click"
export default class extends Controller {
    static values = { url: String }

    go(event) {
        // If the user clicked a link, button, form, or any interactive input, don't navigate the row
        if (event.target.closest('a') ||
            event.target.closest('button') ||
            event.target.closest('form') ||
            event.target.closest('input') ||
            event.target.closest('select')) {
            return
        }

        // Use Turbo to visit the URL if available, otherwise fallback to window.location
        if (window.Turbo) {
            window.Turbo.visit(this.urlValue)
        } else {
            window.location.href = this.urlValue
        }
    }
}
