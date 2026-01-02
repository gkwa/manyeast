
# Interactive Product Selector Tool - Specification

## Overview

A product selection tool that enables users to select multiple products from e-commerce websites using vim-style keyboard navigation. Supports linear traversal, range selection, deselect mode, and batch export. Highlights selected items with visual feedback and tracks selections in memory.

## Problem Statement

Manually selecting individual products from a product listing is inefficient. Users need a way to:

- Navigate products without a mouse
- Select ranges of products quickly
- Refine selections by deselecting specific items
- Export selection data for use elsewhere

## Solution

A client-side tool that:

- Discovers product elements via configurable CSS selectors
- Provides keyboard-driven navigation through products
- Supports range selection and deselect mode for efficient batch operations
- Maintains selection state in memory
- Exports selected product data

---

## Core Concepts

### Product Discovery

Products are discovered using a CSS selector specified in site configuration. The selector returns a flat list of elements in DOM order (as returned by `querySelectorAll`). This list is the canonical ordering for all navigation and range operations.

```
Example selectors:
  [data-testid^="product-card-"]
  [data-component-type="s-search-result"]
  .product-card
  article[class*="ProductCard"]
```

### Cursor

The cursor represents the user's current position in the product list. Exactly one product has the cursor at any time after navigation begins.

- **Initial state**: No cursor until first navigation key is pressed, then cursor appears on first product
- **Persistence**: Cursor remains visible until tool is deactivated or page is left

### Selection Set

A set of products the user has marked for export. Products can be added or removed from this set. The set maintains insertion order for export purposes but selection operations use set semantics (no duplicates, O(1) lookup).

---

## Navigation

Products are traversed as a linear list in DOM order.

| Key | Action        |
| --- | ------------- |
| `h` | Previous item |
| `k` | Previous item |
| `j` | Next item     |
| `l` | Next item     |

**Boundary behavior**: Navigation stops at boundaries (does not wrap). Attempting to move past first/last item is a no-op.

**Rationale**: h/l and j/k are redundant intentionally. This accommodates both "horizontal" and "vertical" mental models without requiring the tool to infer visual layout. Users can use whichever pair feels natural.

---

## Visual States

Products can have the following visual states, which may combine:

| State             | Appearance                                 | Purpose                                       |
| ----------------- | ------------------------------------------ | --------------------------------------------- |
| Default           | No outline                                 | Not selected, not focused                     |
| Cursor            | Dashed outline (e.g., 3px blue)            | Current navigation position                   |
| Selected          | Solid outline (e.g., 3px red)              | In selection set                              |
| Cursor + Selected | Dashed outline over solid                  | Current position is also selected             |
| Range Preview     | Dimmed solid outline (e.g., 3px light red) | Pending range selection (while in range mode) |

Visual indicators use CSS `outline` and `outline-offset` to avoid disrupting page layout. Colors and widths are defined in display configuration.

### Mode Indicators

When a mode is active, a visual indicator signals the altered behavior:

| Mode          | Indicator                                                        |
| ------------- | ---------------------------------------------------------------- |
| Range mode    | Status badge or cursor color change (e.g., green cursor)         |
| Deselect mode | Status badge or background tint (e.g., body has subtle red tint) |

Modes are mutually exclusive — entering one mode exits the other.

---

## Selection Operations

### Single Select/Deselect

| Key     | Action                              |
| ------- | ----------------------------------- |
| `Space` | Toggle selection on cursor position |

**Precondition**: Cursor must exist. If no cursor exists, `Space` is ignored.

If the product at cursor is not selected, add it. If already selected, remove it.

### Range Selection

Range selection adds multiple contiguous products to the selection set.

| Key | Action                      |
| --- | --------------------------- |
| `v` | Toggle range selection mode |

**Precondition**: Cursor must exist (user must have navigated at least once). If no cursor exists, `v` is ignored.

**Workflow**:

1. Navigate to starting product (cursor now exists)
2. Press `v` to enter range mode — current position becomes the **anchor**
3. Navigate with h/j/k/l — cursor moves, range preview shown
4. Press `v` again to confirm — products from anchor to cursor (inclusive) are added to selection

**Example**:

```
Cursor on product 0
Press v           → enter range mode, anchor = 0
Press j j j j j j → cursor moves to product 6
Press v           → exit range mode, products 0-6 now selected (7 items)
```

**Properties**:

- Range selection is additive — does not clear previous selections
- Anchor is visually identical to cursor (no separate indicator)
- Direction doesn't matter — selecting backward (anchor > cursor) works
- Range preview: products in pending range shown with distinct style (e.g., dimmed selection color)

**Cancellation**:

| Key      | Action                            |
| -------- | --------------------------------- |
| `Escape` | Exit range mode without selecting |

### Deselect Mode

Deselect mode allows removing items from selection via navigation.

| Key | Action                      |
| --- | --------------------------- |
| `d` | Toggle deselect mode on/off |

**Precondition**: Cursor must exist. If no cursor exists, `d` is ignored.

**Behavior when active**:

- Navigation keys (h/j/k/l) remove items from selection as the cursor moves through them
- Only affects items that are selected (no-op on unselected items)
- `Space` also deselects (instead of toggling)

**Behavior when inactive**:

- Navigation does not affect selection
- Normal selection operations apply

### Bulk Operations

| Key | Action                                  |
| --- | --------------------------------------- |
| `a` | Select all products                     |
| `u` | Deselect all products (clear selection) |
| `i` | Invert selection (toggle all)           |

### Help

| Key | Action                         |
| --- | ------------------------------ |
| `?` | Display keyboard shortcut help |

---

## Data Export

### Console Commands

The tool exposes functions for data access and manipulation:

| Command                 | Description                                    |
| ----------------------- | ---------------------------------------------- |
| `getSelectedProducts()` | Returns array of selected product data objects |
| `getSelectedCount()`    | Returns number of selected products            |
| `getSelectedIndices()`  | Returns array of indices in DOM order          |
| `exportJSON()`          | Returns selection as JSON string               |
| `reset()`               | Clear selection and cursor state               |

### Product Data Structure

Each selected product is represented as:

```
{
  index: number           // Position in product list (0-based)
  html: string            // Raw HTML of product card element
  productUrl: string | null  // Extracted product URL (site-specific)
  parentPageUrl: string   // URL of page where product was found
  capturedAt: string      // ISO timestamp of capture
}
```

The tool captures the product card HTML as-is without attempting to parse or extract product-specific fields (name, price, etc.). Parsing is deferred to downstream systems, since each site has different HTML structure.

---

## Configuration

Configuration is defined in code by developers. There is no user-facing UI for configuration.

### Site Configuration

Each supported site requires a configuration object defined in the codebase:

```
SiteConfig {
  hostnames: string[]       // Domains where config applies
  selector: string          // CSS selector for product elements
  label: string             // Display name for site
}
```

Site configurations are maintained as a registry in source code. Adding support for a new site requires adding a new entry to this registry.

### URL Extractor

Each site requires a URL extractor function that derives the product page URL from a product card element:

```
UrlExtractor: (element: Element) => string | null
```

URL extractors are site-specific and encapsulate knowledge of where each site stores the product link within the card HTML. They are defined alongside site configurations in the codebase.

Returns `null` if no URL can be determined.

### Display Configuration

Visual styling is defined in code with sensible defaults:

```
DisplayConfig {
  cursorColor: string       // Outline color for cursor (default: "#0066cc")
  selectedColor: string     // Outline color for selection (default: "#cc0000")
  outlineWidth: number      // Outline width in pixels (default: 3)
  outlineOffset: number     // Outline offset in pixels (default: 2)
}
```

---

## State Management

### Internal State

The tool maintains:

- **Product list**: Ordered array of discovered elements (immutable after discovery)
- **Cursor index**: Current position in product list (null before first navigation)
- **Selection set**: Set of selected indices
- **Deselect mode flag**: Boolean
- **Range mode flag**: Boolean indicating if range selection is active
- **Range anchor**: Index where range mode was entered (null when not in range mode)

### State Invariants

- Cursor index is always valid (0 ≤ index < product count) or null
- Selection set contains only valid indices
- Selection set has no duplicates
- Modes (range, deselect) can only be active when cursor exists

### State Persistence

Current scope: in-memory only. Selections are lost on page refresh.

Future consideration: localStorage persistence, URL encoding, or sync storage.

---

## Initialization

On init:

1. Query DOM for products using configured selector
2. Build indexed product list
3. Attach keyboard event listeners
4. Inject CSS for visual states
5. Log summary (site name, product count)

If no products match the selector, log warning and remain dormant.

---

## Error Handling

| Condition                                 | Behavior                         |
| ----------------------------------------- | -------------------------------- |
| No matching products                      | Log warning, tool inactive       |
| Navigation at boundary                    | No-op (stay at current position) |
| Selection operation on empty list         | No-op                            |
| Selection keys (Space/v/d) without cursor | No-op (ignored)                  |
| Export with empty selection               | Return empty array/string        |

---

## Limitations

- Works only on pages where products match configured CSS selector
- Selections lost on page refresh (current scope)
- No mouse interaction for selection (keyboard only)
- Does not handle dynamically loaded products after init (would require re-init or mutation observer)

---

## Future Considerations

**Short term**:

- localStorage persistence
- Re-init command for dynamic pages

**Medium term**:

- Undo/redo stack
- Named selection presets
- Mouse click as alternative input
- Mutation observer for infinite scroll pages

**Long term**:

- Browser extension packaging
- Cross-page selection persistence
- Backend sync

---

## Keyboard Reference

```
Navigation
  h, k          Previous product
  j, l          Next product

Selection
  Space         Toggle select at cursor
  v             Toggle range selection mode
  d             Toggle deselect mode
  a             Select all
  u             Deselect all
  i             Invert selection

Other
  Escape        Cancel current mode (range/deselect)
  ?             Show help
```

