import { runtime } from "webextension-polyfill"

// Background service worker logic
console.log("Background service worker initialized")

runtime.onInstalled.addListener(() => {
  console.log("Extension installed")
})
