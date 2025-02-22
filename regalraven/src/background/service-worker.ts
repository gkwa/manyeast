import browser from "webextension-polyfill"

// Initialize message listener
browser.runtime.onMessage.addListener((message, sender) => {
  if (message.type === "contentScriptLoaded") {
    console.log("Content script loaded in tab:", sender.tab?.id)
    return Promise.resolve({ received: true })
  }
  return false
})

// Log when the service worker is initialized
console.log("Background service worker initialized")
