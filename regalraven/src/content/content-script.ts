import browser from "webextension-polyfill"

// Content script logic
console.log("Content script loaded")

// Example of sending a message to the background script
browser.runtime.sendMessage({ type: "contentScriptLoaded" })
