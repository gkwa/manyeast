import browser from "webextension-polyfill"

// Define the message type
interface ContentScriptMessage {
  type: "contentScriptLoaded"
}

// Initialize message listener with proper typing
browser.runtime.onMessage.addListener((message: unknown, sender, sendResponse) => {
  // Type guard to verify the message structure
  const isContentScriptMessage = (msg: unknown): msg is ContentScriptMessage => {
    return (
      typeof msg === "object" && msg !== null && "type" in msg && msg.type === "contentScriptLoaded"
    )
  }

  if (isContentScriptMessage(message)) {
    console.log("Content script loaded in tab:", sender.tab?.id)
    return Promise.resolve({ received: true })
  }

  return true // Return true to indicate we'll send a response asynchronously
})

// Log when the service worker is initialized
console.log("Background service worker initialized")
