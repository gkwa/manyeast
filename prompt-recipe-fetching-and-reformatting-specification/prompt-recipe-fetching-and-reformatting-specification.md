# Recipe Fetching and Reformatting Specification

## Input Requirements
- **Primary Input**: Recipe webpage URL
- **URL of interest**: `{{ .RecipeURL }}`

## Overview
This specification defines the process for extracting recipe data from web URLs through direct AI analysis, not automated scripting. The AI will manually analyze webpage content and extract key information into a standardized JSON format.

## Execution Method
**IMPORTANT**: This process should be performed manually by AI analysis, not through automated scripts or code generation. The AI should:
1. Directly fetch and analyze the webpage content
2. Manually extract the required data fields
3. Format the output as specified JSON

## Fallback for Blocked Access
When direct fetching is blocked (robots.txt, access restrictions, etc.):
1. Request the user to copy-paste the webpage HTML content
2. Instruct the AI to analyze the provided HTML as if it had fetched the page directly
3. Continue with the same extraction process using the pasted content

## Multi-Step Fetching Process
This specification requires a multi-step manual analysis approach:

1. **Initial Recipe Page Analysis**: AI directly fetches and analyzes recipe page content
2. **Creator Page Analysis**: AI follows creator URL to manually extract additional author information and photos
3. **Social Media Links Collection**: Extract social media links from both recipe page and creator page
4. **Google Images Search Fallback (if needed)**: If creator page lacks photos, use Google Images search URL format: `https://www.google.com/search?udm=2&q=[creator-name]`
5. **Data Consolidation**: AI manually compiles recipe and creator data into final JSON format

### Manual Analysis Dependencies
- Recipe extraction performed through direct AI content analysis
- Creator information gathered through manual AI review of creator pages
- Social media links collected from both recipe and creator pages
- No automated scripts or code generation involved in the process

### Blocked Access Handling
If AI cannot access the primary recipe URL or creator URL:
1. **Primary Recipe Page**: Request user to copy-paste the recipe page HTML
2. **Creator Page**: Request user to copy-paste the creator page HTML if needed
3. **Continue Processing**: AI analyzes pasted content as if directly fetched

## Data Extraction Requirements

### 1. Recipe Count Detection
- Determine the total number of recipes present on the given webpage
- Handle both single-recipe and multi-recipe pages
- Return count as integer value

### 2. Per-Recipe Data Extraction
For each recipe identified on the page, extract the following fields:

#### Required Fields
- **Recipe Title**: The main title/name of the recipe
- **Recipe Author/Creator**: Name of the person who created the recipe (may require secondary fetch)
- **Recipe URL**: The canonical URL of the specific recipe
- **Creator URL**: Link to the author's profile, website, or about page (discovered from recipe page)
- **Recipe Ingredients**: Complete list of ingredients with quantities
- **Recipe Instructions**: Step-by-step cooking instructions
- **Recipe Image URL**: Primary image associated with the recipe
- **Social Media Links**: Array of social media profile URLs for the creator

#### Creator Information (Secondary Fetch)
Additional creator details that may require fetching the creator URL:
- **Extended Author Bio**: Detailed information about the recipe creator
- **Author Avatar/Photo**: Profile image, family photo, or personal picture of the creator
- **Author Social Links**: Links to social media profiles (combined with recipe page findings)
- **Author Credentials**: Professional background or expertise areas

#### Social Media Links Collection
Extract social media profile URLs from both the recipe page and creator page. Look for links to:

**Primary Platforms to Identify:**
- **Facebook**: facebook.com, fb.com
- **Instagram**: instagram.com, instagr.am
- **Twitter/X**: twitter.com, x.com
- **Pinterest**: pinterest.com, pinterest.co.uk
- **LinkedIn**: linkedin.com
- **YouTube**: youtube.com, youtu.be
- **TikTok**: tiktok.com
- **Snapchat**: snapchat.com

**Secondary Platforms:**
- **Blog/Personal Website**: Non-recipe personal websites
- **Newsletter**: Substack, ConvertKit, Mailchimp signup links
- **Podcast**: Spotify, Apple Podcasts, podcast hosting platforms
- **Other Cooking Platforms**: Allrecipes, Food.com, Epicurious profiles

**Social Media Link Detection Strategy:**
1. **Recipe Page Analysis**: Look for social media icons, follow buttons, or profile links in:
   - Header/navigation areas
   - Sidebar widgets
   - Footer sections
   - Author bio boxes within recipe posts
   - "Follow me" or "Connect with me" sections

2. **Creator/About Page Analysis**: Extract additional social links from:
   - About page social media sections
   - Contact pages
   - Author profile pages
   - Bio sections with social media icons

3. **Link Validation**: Ensure extracted URLs are:
   - **ONLY links that actually exist on the pages** - never guess or construct URLs
   - Direct profile links (not generic platform homepages)
   - Extracted exactly as found on the source pages
   - Properly formatted with full URLs

**Social Media URL Formatting:**
- **CRITICAL: Only extract URLs that actually exist on the source pages**
- **Never guess, construct, or infer social media URLs that are not explicitly present**
- **If no social media links are found, leave the array empty rather than guessing**
- Extract complete URLs exactly as they appear, including https:// protocol
- Prefer full URLs over shortened/redirect links when both are present
- Convert mobile URLs to desktop equivalents only if the mobile URL is what's actually found
- Remove tracking parameters while preserving profile identifiers, but only from URLs that actually exist

#### Creator Visual Identification
To establish visual connection with the creator, extract:
- **Primary Creator Image**: Avatar, headshot, or profile picture from about page
- **Personal Photos**: Family photos, kitchen photos, or lifestyle images that represent the creator
- **Professional Photos**: Chef photos, cooking action shots, or food preparation images

#### Creator Image URL Detection
When analyzing image URLs for creator photos, use URL text analysis to differentiate between personal and recipe images:

**Positive indicators (likely creator photos):**
- URLs containing: "about", "author", "profile", "headshot", "bio", "team", "staff", "chef", "founder"
- Personal names in URL paths
- "avatar", "portrait", "photo-of-[name]"

**Negative indicators (avoid these - likely food/recipe images):**
- URLs containing: "recipe", "lunch", "dinner", "breakfast", "food", "dish", "cooking", "kitchen-scene"
- Food-related terms: "cake", "bread", "soup", "salad", etc.
- Recipe step indicators: "step-1", "process", "preparation"
- Generic food photography: "food-photo", "dish-1", "meal"

**Example to avoid:**
`https://thebeachhousekitchen.com/wp-content/uploads/2022/02/Lunch-Photo-1-of-1.jpg`
This clearly indicates a lunch recipe photo, not a creator image.

#### Creator Image Sources (in order of preference)
1. **Creator About Page**: Primary source for author photos and personal images
2. **Creator Profile/Bio Section**: Look for headshots or professional photos
3. **Social Media Links**: Extract profile images from linked social accounts
4. **Google Images Search Fallback**: If no creator images found in above sources, use Google Images search

#### Google Images Search Fallback Process
When creator images cannot be located from the primary sources, construct a Google Images search URL using this format:

**Search URL Format**: `https://www.google.com/search?q=[creator-name]&udm=2`

**Examples**:
- For creator "Urvashi Pitre": `https://www.google.com/search?q=urvashi+pitre&udm=2`
- For creator "John Smith": `https://www.google.com/search?q=john+smith&udm=2`
- For creator "Maria Garcia-Lopez": `https://www.google.com/search?q=maria+garcia-lopez&udm=2`

**URL Construction Rules**:
- Replace spaces in creator name with `+` symbols
- Keep hyphens and other punctuation as-is
- Use lowercase for consistency
- Add `&udm=2` parameter to specify image search
- Do not include site domain in the search query (this produces better results than the original "[Creator Name] + [Site Domain]" approach)

**When to Use Google Images Search**:
- Creator about page exists but contains no personal photos
- Creator URL is inaccessible or returns 404 error
- Creator page has only recipe/food images, no personal photos
- Social media links are unavailable or don't contain profile images
- Any scenario where primary sources fail to yield creator images

**Implementation in Output**:
- When using Google Images search fallback, set `creator_image_url` to the constructed Google search URL
- This allows the consumer of the data to perform the image search and select appropriate results
- The search URL serves as a fallback mechanism rather than trying to guess specific image URLs

#### Data Format Specifications
- All text fields should be trimmed of leading/trailing whitespace
- URLs should be absolute (fully qualified) rather than relative
- Ingredients should be preserved as a list/array of strings
- Instructions should be preserved as a list/array of ordered steps
- Social media links should be returned as an array of URL strings
- Handle cases where some fields may be missing or unavailable

## Output Format Structure

### JSON Blog Format
The output should be a single JSON blob embedded in a code block with no additional text, preambles, or summary statements. Return only the raw JSON array containing recipe dictionaries.

### Single Recipe Response

```json
[
    {
        "title": "Indian Mint Sauce Recipe",
        "author": "Chef Name",
        "recipe_url": "https://www.jcookingodyssey.com/indian-mint-sauce-recipe/",
        "creator_url": "https://example.com/author-profile",
        "creator_image_url": "https://example.com/author-photo.jpg",
        "image_url": "https://example.com/recipe-image.jpg",
        "social_media_links": [
            "https://www.instagram.com/chefname",
            "https://www.facebook.com/chefnameofficial",
            "https://www.pinterest.com/chefname",
            "https://www.youtube.com/c/chefnamechannel"
        ],
        "ingredients": [
            "1 cup fresh mint leaves",
            "2 green chilies, chopped",
            "1 tsp ginger, minced",
            "2 tbsp lemon juice",
            "1 tsp sugar",
            "Salt to taste"
        ],
        "instructions": [
            "Wash and roughly chop the mint leaves",
            "Combine mint, chilies, and ginger in a blender",
            "Add lemon juice and a splash of water",
            "Blend until smooth paste forms",
            "Add sugar and salt, blend again",
            "Serve immediately or refrigerate for up to 3 days"
        ]
    }
]
```

### Multiple Recipe Response
```json
[
    {
        "title": "Indian Mint Sauce Recipe",
        "author": "Chef Name",
        "recipe_url": "https://example.com/recipe-1",
        "creator_url": "https://example.com/author-profile",
        "creator_image_url": "https://example.com/author-photo.jpg",
        "image_url": "https://example.com/recipe-1-image.jpg",
        "social_media_links": [
            "https://www.instagram.com/chefname",
            "https://www.facebook.com/chefnameofficial"
        ],
        "ingredients": [
            "1 cup fresh mint leaves",
            "2 green chilies, chopped"
        ],
        "instructions": [
            "Wash and roughly chop the mint leaves",
            "Combine ingredients in blender"
        ]
    },
    {
        "title": "Spicy Mint Chutney Variation",
        "author": "Chef Name", 
        "recipe_url": "https://example.com/recipe-2",
        "creator_url": "https://example.com/author-profile",
        "creator_image_url": "https://example.com/author-photo.jpg",
        "image_url": "https://example.com/recipe-2-image.jpg",
        "social_media_links": [
            "https://www.instagram.com/chefname",
            "https://www.facebook.com/chefnameofficial"
        ],
        "ingredients": [
            "1 cup fresh mint leaves",
            "3 green chilies, chopped",
            "1 tbsp tamarind paste"
        ],
        "instructions": [
            "Prepare mint leaves as above",
            "Add extra chilies for heat",
            "Include tamarind for tanginess"
        ]
    }
]
```

## Technical Implementation Notes

### Manual Content Analysis Strategy
- AI should manually identify structured data (JSON-LD, microdata, RDFa) when present
- Manually locate recipe content through visual inspection of HTML structure
- Recognize common recipe schema formats (Recipe schema.org markup)
- **Ingredients Extraction**: Manually identify ingredient lists in various formats (ul/ol, recipe cards, structured data)
- **Instructions Extraction**: Manually parse cooking steps from numbered lists, paragraphs, or structured formats
- **Image Extraction**: Manually identify primary recipe images (avoid generic site headers/footers)
- **Social Media Extraction**: Manually scan for social media icons, links, and follow buttons across page sections
- **No automated parsing tools or scripts** - rely on AI content comprehension

### Access Issues and Fallback Handling
- When AI cannot access recipe or creator URLs due to blocking/restrictions:
  - **Request HTML copy-paste** from user for blocked pages
  - **Continue analysis** using pasted content as source material
  - **Treat pasted content** as if it were directly fetched
- Manage cases where recipe data is incomplete or missing in provided content
- **Handle creator URL access failures gracefully** (continue with basic author name from recipe page)
- **Extract social media links from available sources only** (don't fail if creator page inaccessible)
- **No automated retry mechanisms** - rely on manual AI analysis and user assistance for blocked content

### Edge Cases to Consider
- Pages with no recipes found
- Recipes without clear authorship attribution
- Multiple authors per recipe
- Recipes that are part of larger articles or blog posts
- Dynamic content loaded via JavaScript
- **Ingredients without measurements** (handle descriptive ingredients)
- **Instructions in paragraph form** vs numbered steps
- **Multiple images per recipe** (prioritize main/featured image)
- **Missing ingredients or instructions** (mark as incomplete)
- **Embedded recipe cards** vs full-page recipes
- **Creator URLs that are invalid or return 404 errors**
- **Creator pages that don't contain expected author information**
- **Cross-domain creator URLs** (different domain than recipe site)
- **Creator URLs requiring authentication or returning paywalled content**
- **Creator pages with no personal images** (use Google Images search fallback)
- **Creator names that are too generic for effective image search** (e.g., "Admin", "Chef")
- **Social media links that are broken or redirect to generic platform pages**
- **Duplicate social media platforms** (consolidate to primary profile)
- **Social media icons without accompanying URLs** (skip these)
- **Private or restricted social media profiles** (include URL but note accessibility)

## Validation Requirements
- Verify extracted URLs are valid and accessible
- Ensure recipe titles are non-empty strings
- **Validate ingredients array is not empty**
- **Validate instructions array is not empty** 
- **Check image URLs return valid image content**
- **Ensure social media URLs are properly formatted and accessible**
- **Ensure social media links are stored as simple URL strings**
- Ensure proper ordering of instruction steps
- Verify ingredient list formatting consistency
- **Output validation**: Ensure final output is valid JSON with no additional text or formatting

## Future Considerations
- Support for additional recipe metadata (cook time, servings, etc.)
- Handling of recipe variations or modifications
- Support for different output formats (CSV, XML, etc.)
- Caching mechanisms for frequently accessed URLs
- **Caching creator information** to avoid redundant fetches for the same author
- **Batch processing** for multiple recipes from the same creator
- **Parallel fetching strategies** to optimize performance when processing multiple recipes
- **Database storage** for creator information to reduce API calls
- **Social media profile verification** to ensure links lead to authentic creator accounts
- **Social media engagement metrics** collection for creator influence assessment
