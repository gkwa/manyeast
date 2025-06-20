Lets make a chrome extension named {{ .ProjectName }}.

# Link Capture Chrome Extension - Specification

## Goal
Create a Chrome extension that allows users to easily capture and store links from any webpage using a simple hold-and-click interaction, maintaining a personal database of collected links with their context.

## Core Functionality

### Link Capture Mechanism
- **Activation**: User holds down the 'C' key to enter capture mode
- **Visual Feedback**: When 'C' is held, provide clear indication that capture mode is active
- **Link Capture**: While holding 'C', clicking on any link captures it instead of navigating to it
- **Data Stored**: For each captured link, store:
  - Current page URL (where the link was found)
  - Target link URL (the link being captured)
  - Current date/time timestamp

### User Experience
- **Mode Indication**: Clear visual cues when capture mode is active
- **Capture Confirmation**: Brief feedback when a link is successfully captured
- **Non-Interference**: Normal browsing behavior is completely unchanged when 'C' is not held
- **Context Awareness**: Ignore capture attempts when user is typing in text fields

### Data Storage
- Use IndexedDB with RxDB for local storage
- Store captured links persistently across browser sessions
- No external servers or cloud storage required

### User Interface
- Minimal impact on webpage appearance during normal browsing
- Temporary visual indicators only appear during capture mode
- Consider future features like viewing/managing captured links

## Technical Requirements
- Works on all websites (content script injection)
- Handles dynamically loaded content
- Prevents default link navigation during capture
- Respects user input contexts (don't interfere with typing)

## Success Criteria
- Users can capture links quickly without disrupting normal browsing
- Captured data persists reliably
- Extension works consistently across different websites
- Interface feels intuitive and responsive

{{ include "../webui-common/webui-common.md" . | trim }}"

