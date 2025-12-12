// =============================================================================
// URL EXTRACTORS - Pure functions, easily testable
// =============================================================================

const urlExtractors = {
  target: (card) => {
    const link = card.querySelector('a[href*="/p/"]')
    if (!link) return null
    return `https://www.target.com${link.pathname}`
  },

  wholefoods: (card) => {
    const link = card.querySelector('a[href*="/product/"]')
    return link?.href ?? null
  },

  amazon: (card) => {
    const asin = card.dataset.asin
    if (!asin) return null
    return `https://www.amazon.com/dp/${asin}`
  },

  lamsseafood: (card) => {
    const title = card.querySelector('[class*="ProductTitle"]')?.textContent?.trim()
    if (!title) return null
    return `https://seattle.lamsseafood.com/search?filter%5Betext%5D=${btoa(title)}&filter%5Bwidget%5D=1`
  },

  safeway: (card) => {
    const link = card.querySelector('a[href*="/shop/product-details"]')
    if (link) return `https://www.safeway.com${link.getAttribute("href")}`
    const bpn = card.querySelector("[data-bpn]")?.getAttribute("data-bpn")
    if (!bpn) return null
    return `https://www.safeway.com/shop/product-details.${bpn}.html`
  },

  qfc: (card) => {
    const link = card.querySelector('a[href*="/p/"]')
    if (!link) return null
    return `https://www.qfc.com${link.getAttribute("href")}`
  },

  fredmeyer: (card) => {
    const link = card.querySelector('a[href*="/p/"]')
    if (!link) return null
    return `https://www.fredmeyer.com${link.getAttribute("href")}`
  },

  hmart: (card) => {
    const link = card.querySelector('a[href*="/p"]')
    if (!link) return null
    return `https://www.hmart.com${link.getAttribute("href")}`
  },

  pcc: (card) => {
    const link = card.querySelector('a[href*="/products/"]')
    if (!link) return null
    return `https://delivery.pccmarkets.com${link.getAttribute("href")}`
  },

  traderjoes: (card) => {
    const link = card.querySelector('a[href*="/home/products/pdp/"]')
    if (!link) return null
    return `https://www.traderjoes.com${link.getAttribute("href")}`
  },

  walmart: (card) => {
    const link = card.querySelector("a[link-identifier]")
    if (!link) return null
    const href = link.getAttribute("href")
    const rdMatch = href.match(/[?&]rd=([^&]+)/)
    if (rdMatch) return decodeURIComponent(rdMatch[1]).split("?")[0]

    if (href.includes("/ip/")) return href.split("?")[0]

    return null
  },

  chefstore: (card) => {
    const link = card.querySelector('a.product-tile-link[href*="/p/"]')
    if (!link) return null
    return `https://www.chefstore.com${link.getAttribute("href")}`
  },
}

// =============================================================================
// SITE CONFIGS - Pure data, no logic
// =============================================================================

const siteConfigs = {
  target: {
    hostnames: ["www.target.com", "target.com"],
    selector: '[data-test="@web/site-top-of-funnel/ProductCardWrapper"]',
    label: "TARGET",
  },
  wholefoods: {
    hostnames: ["www.wholefoodsmarket.com", "wholefoodsmarket.com"],
    selector: ".w-pie--product-tile",
    label: "WHOLE FOODS",
  },
  amazon: {
    hostnames: ["www.amazon.com", "amazon.com"],
    selector: '[data-component-type="s-search-result"]',
    label: "AMAZON",
  },
  lamsseafood: {
    hostnames: ["seattle.lamsseafood.com"],
    selector: '[class*="ProductCardWrapper"]',
    label: "LAMS SEAFOOD",
  },
  safeway: {
    hostnames: ["www.safeway.com", "safeway.com"],
    selector: 'product-item-al-v2[data-qa="prd-itm"]',
    label: "SAFEWAY",
  },
  qfc: {
    hostnames: ["www.qfc.com", "qfc.com"],
    selector: '[data-testid="auto-grid-cell"] .ProductCard',
    label: "QFC",
  },
  fredmeyer: {
    hostnames: ["www.fredmeyer.com", "fredmeyer.com"],
    selector: '[data-testid="auto-grid-cell"] .ProductCard',
    label: "FRED MEYER",
  },
  hmart: {
    hostnames: ["www.hmart.com", "hmart.com"],
    selector: '[class*="galleryItem"]',
    label: "HMART",
  },
  pcc: {
    hostnames: ["delivery.pccmarkets.com"],
    selector: '[aria-label="Product"][role="group"]',
    label: "PCC",
  },
  traderjoes: {
    hostnames: ["www.traderjoes.com", "traderjoes.com"],
    selector: 'article[class*="SearchResultCard_searchResultCard"]',
    label: "TRADER JOES",
  },
  walmart: {
    hostnames: ["www.walmart.com", "walmart.com"],
    selector: '[role="group"][data-item-id]',
    label: "WALMART",
  },
  chefstore: {
    hostnames: ["www.chefstore.com", "chefstore.com"],
    selector: ".product-tile[data-tile]",
    label: "CHEF STORE",
  },
}

// =============================================================================
// ACTIONS - Pluggable behaviors triggered on key + click
// =============================================================================

const defaultActions = [
  {
    name: "clipboard",
    onTrigger: async (card, payload) => {
      await navigator.clipboard.writeText(JSON.stringify(payload, null, 2))
    },
  },
  {
    name: "console",
    onTrigger: async (card, payload) => {
      console.warn(`✓ [${payload.site}] Copied`, payload.url || "(no URL)")
    },
  },
]

// =============================================================================
// CORE ENGINE - Composes configs + extractors + actions via DI
// =============================================================================

function createProductCardCopier(configs, extractors, options = {}) {
  const {
    actions = defaultActions,
    triggerKey = "x",
    flashClass = "copied",
    flashDuration = 300,
    onInit = (label, count) => console.warn(`🛒 ${label}: ${count} products found`),
    hostname = window.location.hostname,
  } = options

  // Filter configs to only those matching current hostname
  const activeConfigs = Object.entries(configs).reduce((acc, [name, config]) => {
    if (config.hostnames.includes(hostname)) {
      acc[name] = config
    }
    return acc
  }, {})

  if (Object.keys(activeConfigs).length === 0) {
    console.warn(`⚠️ No site config matches hostname: ${hostname}`)
    return { sites: {}, init: () => {} }
  }

  // Validate that all active configs have matching extractors
  // Note: explicit `null` in extractors = intentional (no warning)
  //       key missing entirely = likely a bug (warn)
  const missingExtractors = Object.keys(activeConfigs).filter((key) => !(key in extractors))
  if (missingExtractors.length > 0) {
    console.error("Missing URL extractors for:", missingExtractors)
  }

  // Build combined site registry
  const sites = Object.entries(activeConfigs).reduce((acc, [name, config]) => {
    acc[name] = {
      ...config,
      getUrl: extractors[name] || (() => null),
    }
    return acc
  }, {})

  // Track trigger key state
  let triggerKeyHeld = false

  return { sites, init }

  function init() {
    if (actions.length === 0) {
      console.warn("⚠️ No actions configured")
      return
    }

    initKeyTracking()
    injectStyles(sites)
    attachHandlers(sites)
    logSummary(sites, onInit)

    console.warn(`🎯 Trigger: hold "${triggerKey}" + click`)
    console.warn(`📋 Actions: ${actions.map((a) => a.name).join(", ")}`)
  }

  function initKeyTracking() {
    document.addEventListener("keydown", (e) => {
      if (e.key !== triggerKey || e.repeat) return
      triggerKeyHeld = true
      document.body.classList.add("trigger-mode-active")
    })

    document.addEventListener("keyup", (e) => {
      if (e.key !== triggerKey) return
      triggerKeyHeld = false
      document.body.classList.remove("trigger-mode-active")
    })

    // Handle edge case: key released while window not focused
    window.addEventListener("blur", () => {
      triggerKeyHeld = false
      document.body.classList.remove("trigger-mode-active")
    })
  }

  function injectStyles(sites) {
    const selectors = Object.values(sites).map((s) => s.selector)
    const hover = selectors.map((s) => `body.trigger-mode-active ${s}:hover`).join(", ")
    const flash = selectors.map((s) => `${s}.${flashClass}`).join(", ")

    const style = document.createElement("style")
    style.textContent = `
      ${hover} {
        outline: 3px solid #0066cc !important;
        outline-offset: 2px !important;
        background-color: rgba(0, 102, 204, 0.05) !important;
        transition: all 0.2s ease !important;
        position: relative !important;
        z-index: 10 !important;
        cursor: pointer !important;
      }
      ${flash} {
        outline: 3px solid #00cc00 !important;
        outline-offset: 2px !important;
      }
    `
    document.head.appendChild(style)
  }

  function attachHandlers(sites) {
    Object.values(sites).forEach(({ selector, label, getUrl }) => {
      document.querySelectorAll(selector).forEach((card, index) => {
        card.addEventListener(
          "click",
          async (e) => {
            if (!triggerKeyHeld) return // Let normal click through

            e.preventDefault()
            e.stopPropagation()

            const payload = {
              html: card.outerHTML,
              url: getUrl(card),
              site: label,
              index,
            }

            // Run all actions in sequence
            for (const action of actions) {
              try {
                await action.onTrigger(card, payload)
              } catch (err) {
                console.error(`Action "${action.name}" failed:`, err)
              }
            }

            // Visual feedback
            card.classList.add(flashClass)
            setTimeout(() => card.classList.remove(flashClass), flashDuration)
          },
          true,
        )
      })
    })
  }
}

function logSummary(sites, onInit) {
  Object.values(sites).forEach(({ selector, label }) => {
    const count = document.querySelectorAll(selector).length
    if (count > 0) onInit(label, count)
  })
}

// =============================================================================
// INITIALIZATION
// =============================================================================

const copier = createProductCardCopier(siteConfigs, urlExtractors)
copier.init()

// =============================================================================
// EXPORTS (for testing or extension use)
// =============================================================================

// Uncomment if using as a module:
// export { siteConfigs, urlExtractors, defaultActions, createProductCardCopier };
