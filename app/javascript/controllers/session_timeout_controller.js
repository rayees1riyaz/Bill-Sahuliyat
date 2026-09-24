import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="session-timeout"
export default class extends Controller {
  static values = {
    duration: { type: Number, default: 30 * 60 * 1000 }, // 30 minutes in ms
    loginUrl: { type: String, default: "/users/sign_in" }
  }

  connect() {
    this.storageKey = "bill_sahuliyat_last_active"
    this.boundHandleActivity = this.handleActivity.bind(this)
    this.boundHandleStorage = this.handleStorage.bind(this)
    this.boundHandleVisibility = this.handleVisibility.bind(this)

    this.lastActivityTime = Date.now()
    this.syncActivityTime()

    // Listen for user interaction events to refresh inactivity countdown
    this.activityEvents = ["mousemove", "mousedown", "keydown", "scroll", "touchstart"]
    this.activityEvents.forEach((event) => {
      window.addEventListener(event, this.boundHandleActivity, { passive: true })
    })

    // Listen to changes in other tabs
    window.addEventListener("storage", this.boundHandleStorage)

    // Check immediately when tab becomes active again
    document.addEventListener("visibilitychange", this.boundHandleVisibility)

    // Periodic check every 10 seconds
    this.checkInterval = setInterval(() => {
      this.checkSession()
    }, 10000)
  }

  disconnect() {
    if (this.checkInterval) {
      clearInterval(this.checkInterval)
    }

    if (this.activityEvents) {
      this.activityEvents.forEach((event) => {
        window.removeEventListener(event, this.boundHandleActivity)
      })
    }

    window.removeEventListener("storage", this.boundHandleStorage)
    document.removeEventListener("visibilitychange", this.boundHandleVisibility)
  }

  handleActivity() {
    const now = Date.now()
    // Throttle localStorage writes to at most once every 5 seconds
    if (now - this.lastActivityTime > 5000) {
      this.lastActivityTime = now
      this.syncActivityTime()
    }
  }

  handleStorage(event) {
    if (event.key === this.storageKey && event.newValue) {
      const remoteTime = parseInt(event.newValue, 10)
      if (!isNaN(remoteTime) && remoteTime > this.lastActivityTime) {
        this.lastActivityTime = remoteTime
      }
    }
  }

  handleVisibility() {
    if (document.visibilityState === "visible") {
      this.checkSession()
    }
  }

  syncActivityTime() {
    try {
      localStorage.setItem(this.storageKey, this.lastActivityTime.toString())
    } catch (e) {
      // Ignore localStorage errors (e.g. private browsing restrictions)
    }
  }

  getLastActiveTime() {
    try {
      const stored = localStorage.getItem(this.storageKey)
      if (stored) {
        const parsed = parseInt(stored, 10)
        if (!isNaN(parsed)) return parsed
      }
    } catch (e) {
      // Fallback to in-memory timestamp
    }
    return this.lastActivityTime
  }

  checkSession() {
    const lastActive = this.getLastActiveTime()
    const now = Date.now()
    const elapsed = now - lastActive

    if (elapsed >= this.durationValue) {
      this.expireSession()
    }
  }

  expireSession() {
    if (this.checkInterval) {
      clearInterval(this.checkInterval)
    }

    try {
      localStorage.removeItem(this.storageKey)
    } catch (e) {}

    // Redirect to login page
    window.location.assign(this.loginUrlValue)
  }
}
