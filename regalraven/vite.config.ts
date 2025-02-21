import { defineConfig } from "vite"
import react from "@vitejs/plugin-react"
import { fileURLToPath } from "node:url"
import { dirname, resolve } from "node:path"
import { copyFile } from "node:fs/promises"

const __filename = fileURLToPath(import.meta.url)
const __dirname = dirname(__filename)

export default defineConfig({
  plugins: [
    react(),
    {
      name: "copy-extension-files",
      closeBundle: async () => {
        try {
          // Copy popup HTML
          await copyFile(
            resolve(__dirname, "src/popup/index.html"),
            resolve(__dirname, "dist/popup.html"),
          )

          // Copy manifest JSON
          await copyFile(
            resolve(__dirname, "src/manifest.json"),
            resolve(__dirname, "dist/manifest.json"),
          )
        } catch (error) {
          console.error("Failed to copy extension files:", error)
        }
      },
    },
  ],
  build: {
    rollupOptions: {
      input: {
        popup: resolve(__dirname, "src/popup/index.html"),
        background: resolve(__dirname, "src/background/service-worker.ts"),
        contentScript: resolve(__dirname, "src/content/content-script.ts"),
      },
      output: {
        entryFileNames: (chunkInfo) => {
          if (chunkInfo.name === "background") return "background.js"
          if (chunkInfo.name === "contentScript") return "content-script.js"
          return "[name].js"
        },
        chunkFileNames: "[name]-chunk.js",
        assetFileNames: (assetInfo: any) => {
          if (assetInfo.name?.includes("index.html")) return "popup.html"
          return "[name].[ext]"
        },
      },
    },
    outDir: "dist",
  },
  resolve: {
    alias: {
      "@": resolve(__dirname, "./src"),
    },
  },
})
