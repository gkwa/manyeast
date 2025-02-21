import React from "react"
import { createRoot } from "react-dom/client"

const Popup: React.FC = () => {
  return (
    <div>
      <h1>Chrome Extension Popup</h1>
      <p>Welcome to your new extension!</p>
    </div>
  )
}

const root = createRoot(document.getElementById("root")!)
root.render(<Popup />)
