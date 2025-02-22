import { defineConfig } from "vite"
import react from "@vitejs/plugin-react"
import { fileURLToPath } from "node:url"
import { dirname, resolve } from "node:path"
import { copyFile } from "node:fs/promises"

const __filename = fileURLToPath(import.meta.url)
const __dirname = dirname(__filename)

const target = process.env.BUILD_TARGET || "main"

// Content script configuration
const contentScriptConfig = {
  build: {
    outDir: "dist",
    lib: {
      entry: resolve(__dirname, "src/content/content-script.ts"),
      name: "contentScript",
      fileName: () => "content-script.js",
      formats: ["iife"],
    },
    emptyOutDir: false,
  },
}

// Main extension configuration
const mainConfig = {
  plugins: [
    react(),
    {
      name: "copy-extension-files",
      closeBundle: async () => {
        try {
          await copyFile(
            resolve(__dirname, "src/popup/index.html"),
            resolve(__dirname, "dist/popup.html"),
          )
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
    outDir: "dist",
    rollupOptions: {
      input: {
        popup: resolve(__dirname, "src/popup/index.tsx"),
        background: resolve(__dirname, "src/background/service-worker.ts"),
      },
      output: {
        entryFileNames: (chunkInfo) => {
          if (chunkInfo.name === "background") return "background.js"
          return "popup.js"
        },
      },
    },
  },
  resolve: {
    alias: {
      "@": resolve(__dirname, "./src"),
    },
  },
}

export default defineConfig(target === "content" ? contentScriptConfig : mainConfig)
