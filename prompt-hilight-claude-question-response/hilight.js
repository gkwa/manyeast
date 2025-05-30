// CSS Selectors for Claude.ai conversation elements
// Copy and paste this into Chrome DevTools Console for testing

// === USER MESSAGES (Questions) ===
const USER_MESSAGE_SELECTORS = {
  // Main container for user messages
  container: '[data-testid="user-message"]',
  
  // Alternative selectors for user messages
  containerAlt: '.group.relative.inline-flex.gap-2.bg-bg-300.rounded-xl',
  
  // User avatar (contains "TM" or user initials)
  avatar: '.bg-text-200.text-bg-100',
  
  // Message content within user messages
  content: '[data-testid="user-message"] .font-user-message',
  
  // Text content specifically
  text: '[data-testid="user-message"] p.whitespace-pre-wrap'
};

// === CLAUDE RESPONSES ===
const CLAUDE_MESSAGE_SELECTORS = {
  // Main container for Claude messages
  container: '.font-claude-message',
  
  // Alternative container selector
  containerAlt: '[data-is-streaming="false"]',
  
  // Content area within Claude messages
  content: '.font-claude-message .grid-cols-1.grid.gap-2\\.5',
  
  // Text paragraphs in Claude responses
  text: '.font-claude-message p.whitespace-normal.break-words',
  
  // Headers in Claude responses
  headers: '.font-claude-message h1, .font-claude-message h2, .font-claude-message h3',
  
  // Code blocks in Claude responses
  codeBlocks: '.font-claude-message pre, .font-claude-message code',
  
  // Lists in Claude responses
  lists: '.font-claude-message ul, .font-claude-message ol'
};

// === TESTING FUNCTIONS ===

function testSelectors() {
  console.log('=== TESTING CLAUDE.AI SELECTORS ===\n');
  
  // Test user messages
  console.log('🧑 USER MESSAGES:');
  const userMessages = document.querySelectorAll(USER_MESSAGE_SELECTORS.container);
  console.log(`Found ${userMessages.length} user messages`);
  
  userMessages.forEach((msg, index) => {
    const text = msg.textContent.trim().substring(0, 100) + '...';
    console.log(`  ${index + 1}: ${text}`);
  });
  
  console.log('\n🤖 CLAUDE RESPONSES:');
  const claudeMessages = document.querySelectorAll(CLAUDE_MESSAGE_SELECTORS.container);
  console.log(`Found ${claudeMessages.length} Claude responses`);
  
  claudeMessages.forEach((msg, index) => {
    const text = msg.textContent.trim().substring(0, 100) + '...';
    console.log(`  ${index + 1}: ${text}`);
  });
  
  return {
    userMessages: userMessages.length,
    claudeMessages: claudeMessages.length
  };
}

function highlightElements() {
  console.log('🎨 HIGHLIGHTING ELEMENTS...');
  
  // Remove previous highlights
  document.querySelectorAll('.selector-highlight').forEach(el => {
    el.classList.remove('selector-highlight');
    el.style.removeProperty('border');
    el.style.removeProperty('background-color');
  });
  
  // Highlight user messages in blue
  document.querySelectorAll(USER_MESSAGE_SELECTORS.container).forEach(el => {
    el.classList.add('selector-highlight');
    el.style.border = '3px solid #0066cc';
    el.style.backgroundColor = 'rgba(0, 102, 204, 0.1)';
  });
  
  // Highlight Claude messages in green
  document.querySelectorAll(CLAUDE_MESSAGE_SELECTORS.container).forEach(el => {
    el.classList.add('selector-highlight');
    el.style.border = '3px solid #00cc66';
    el.style.backgroundColor = 'rgba(0, 204, 102, 0.1)';
  });
  
  console.log('✅ User messages highlighted in BLUE');
  console.log('✅ Claude messages highlighted in GREEN');
}

function clearHighlights() {
  document.querySelectorAll('.selector-highlight').forEach(el => {
    el.classList.remove('selector-highlight');
    el.style.removeProperty('border');
    el.style.removeProperty('background-color');
  });
  console.log('🧹 Highlights cleared');
}

function extractConversation() {
  console.log('📄 EXTRACTING CONVERSATION...\n');
  
  const conversation = [];
  
  // Get all message containers in order
  const allMessages = document.querySelectorAll(`
    ${USER_MESSAGE_SELECTORS.container},
    ${CLAUDE_MESSAGE_SELECTORS.container}
  `);
  
  allMessages.forEach((msg, index) => {
    const isUser = msg.matches(USER_MESSAGE_SELECTORS.container);
    const text = msg.textContent.trim();
    
    conversation.push({
      index: index + 1,
      type: isUser ? 'user' : 'claude',
      text: text,
      element: msg
    });
    
    console.log(`${index + 1}. [${isUser ? 'USER' : 'CLAUDE'}] ${text.substring(0, 200)}...`);
  });
  
  return conversation;
}

function getPageContent() {
  const userMessages = Array.from(document.querySelectorAll(USER_MESSAGE_SELECTORS.container))
    .map(el => el.textContent.trim());
  
  const claudeMessages = Array.from(document.querySelectorAll(CLAUDE_MESSAGE_SELECTORS.container))
    .map(el => el.textContent.trim());
  
  return {
    title: document.title,
    url: window.location.href,
    userMessages,
    claudeMessages,
    timestamp: new Date().toISOString()
  };
}

// === UTILITY FUNCTIONS FOR CHROME EXTENSION ===

function getSelectedText() {
  return window.getSelection().toString().trim();
}

function getCurrentPageInfo() {
  return {
    title: document.title,
    url: window.location.href,
    selectedText: getSelectedText(),
    fullContent: document.body.innerText
  };
}

// === QUICK TEST COMMANDS ===
console.log('🚀 Claude.ai Selector Testing Loaded!');
console.log('Available commands:');
console.log('  testSelectors()     - Count and list messages');
console.log('  highlightElements() - Visually highlight messages');
console.log('  clearHighlights()   - Remove highlights');
console.log('  extractConversation() - Get full conversation');
console.log('  getPageContent()    - Get page content for extension');
console.log('');
console.log('Quick start: Run testSelectors() then highlightElements()');

// Export selectors for extension use
window.CLAUDE_SELECTORS = {
  USER_MESSAGE_SELECTORS,
  CLAUDE_MESSAGE_SELECTORS,
  testSelectors,
  highlightElements,
  clearHighlights,
  extractConversation,
  getPageContent,
  getCurrentPageInfo
};

