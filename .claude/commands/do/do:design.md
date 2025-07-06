# Do Design - UI/UX Design Analysis

Act as a Senior UI/UX/Product Designer to analyze PRDs and create comprehensive design specifications through intelligent design questioning.

## Task: Design Analysis and Specification

Given the PRD filename: "$ARGUMENTS"

**BEFORE STARTING: Use TodoWrite to create a plan with all mandatory steps**

Use the TodoWrite tool to create todos for each mandatory step:
1. "🚨 CRITICAL: Create session file (NEVER SKIP)"
2. "Load and validate PRD file"
3. "Load configuration and design context"
4. "Run guided configuration if needed"
5. "Perform design system discovery"
6. "Conduct design questioning flow"
7. "Generate mockups and prototypes"
8. "Create design specifications and enhance PRD"
9. "Complete handoff and verify session exists"

Mark each step as "in_progress" when starting and "completed" when finished.

**🚨 IMPORTANT: ALL 8 STEPS BELOW ARE MANDATORY - NONE CAN BE SKIPPED**

### 🚨 CRITICAL: Session Creation (MANDATORY - DO NOT SKIP) 🚨
**⚠️ STOP! READ THIS FIRST! ⚠️**

**SESSION CREATION IS ABSOLUTELY MANDATORY. NO EXCEPTIONS. EVER.**

**YOU MUST CREATE A SESSION FILE BEFORE DOING ANYTHING ELSE.**

1. **Create session directory if needed**: Ensure `.do/sessions/` exists
2. **Generate session ID**: `design-[prd-name]-[YYYYMMDD-HHMMSS]`
3. **Create initial session file** immediately with status "initializing"
4. **If session creation fails**: STOP and report error to user
5. **VERIFY**: Session file exists before proceeding to Step 1

**IF YOU SKIP SESSION CREATION, YOU ARE VIOLATING A CRITICAL REQUIREMENT.**

### Step 1: PRD Loading and Validation (MANDATORY)
Load and validate the specified PRD file:

1. **Parse PRD filename and validate**:
   - Handle both full paths and just filenames
   - Add `.md` extension if missing
   - Check if file exists in `.do/plans/` directory

2. **Handle missing or invalid PRD files**:
   ```
   ❌ PRD file not found: [filename]
   
   Let me show you available PRDs:
   [Run /do:list command to show available files]
   
   💡 Options:
   • Use an existing PRD from the list above
   • Create a new PRD with: /do:plan "[your requirement]"
   • Check the exact filename and try again
   ```

3. **Load and parse PRD content**:
   - Extract user stories and acceptance criteria
   - Identify target users and use cases
   - Analyze functional requirements for design implications
   - Note any existing design constraints

4. **Check for existing Design Specifications**:
   - If Design Specifications already exist, offer to:
     - Continue with existing specs
     - Restart design analysis
     - Append additional design review

### Step 2: Load Configuration and Design Context (MANDATORY)
Configure the design analysis process:

1. **Load config** from `.do/config.json`
   - Use design-focused defaults if config missing
   - Check design questioning preferences
   - Set design depth level (brief/standard/thorough)

2. **Update session status** to "configuring"

3. **Check for first-time use**:
   - If no `designOptions` in config, trigger guided configuration
   - If `--config` flag provided, trigger configuration mode
   - Otherwise, use existing configuration

### Step 3: Guided Configuration (First Use or --config) (MANDATORY)
Run configuration wizard for design tool setup:

1. **Scan codebase for design assets**:
   ```
   🎨 Scanning for design assets...
   
   Found:
   • UI Components: [list of component files]
   • Stylesheets: [CSS/SCSS files]
   • Theme Files: [theme configurations]
   • Assets: [images, icons, fonts]
   ```

2. **Check for screenshot capability**:
   - Detect if Puppeteer MCP is available
   - If not available for web apps:
     ```
     📸 Screenshot capability not detected.
     
     For web applications, I can capture screenshots of your existing UI
     to better understand your design patterns. Would you like help
     setting up Puppeteer MCP?
     ```

3. **Ask about external design tools**:
   ```
   🛠️ Design Tool Integration
   
   Do you use any of these design tools? (I can integrate with them)
   • Figma (via MCP)
   • Sketch files
   • Adobe XD
   • Other design files
   
   Please specify which tools and any file locations.
   ```

4. **Save configuration**:
   ```json
   "designOptions": {
     "scanCodebase": true,
     "captureScreenshots": true,
     "designSystemDiscovery": "auto",
     "mockupFormat": "adaptive",
     "designDepth": "standard",
     "componentInventory": true,
     "accessibilityChecks": true,
     "externalTools": {
       "figma": false,
       "sketch": false,
       "adobeXD": false
     }
   }
   ```

### Step 4: Design System Discovery (MANDATORY)
Analyze existing design patterns and create/update design system:

1. **Update session** with design system analysis results

2. **Component inventory**:
   - Scan for UI component files
   - Identify component patterns
   - Document component hierarchy
   - Note reusable elements

3. **Style analysis**:
   - Extract color tokens
   - Identify typography scales
   - Document spacing systems
   - Find animation patterns

4. **Screenshot capture** (if available):
   - Capture key existing screens
   - Document current UI patterns
   - Save to `.do/design-system/screenshots/`

5. **Design system status**:
   - None: No design system found, will create
   - Partial: Some patterns found, will enhance
   - Complete: Comprehensive system exists, will use

6. **Create/Update design system**:
   - Save to `.do/design-system/style-guide.json`
   - Include discovered patterns
   - Set up component registry
   - Document design tokens

### Step 5: Design Questioning Flow (MANDATORY)
Conduct focused design questioning based on PRD and feature type:

1. **Initialize questioning context**:
   - Update session status to "questioning"
   - Load design question templates from `.do/questions/`
   - Pre-analyze PRD to filter relevant questions
   - Skip questions not applicable to feature type

2. **Present design context**:
   ```
   🎨 Design Analysis: "[Feature Name]"
   
   I've analyzed your design system and found:
   • Design System: [status]
   • Existing Components: [count and types]
   • Visual Style: [description]
   
   I'll ask targeted design questions to create comprehensive
   design specifications and mockups.
   
   🎯 Control options:
   • Answer questions to proceed
   • Say "skip" to bypass specific questions
   • Say "done" when ready to generate specs
   ```

3. **Question categories** (adaptive based on feature):
   
   **a) Information Architecture**:
   - Where should this feature be accessed?
   - How does it fit in the navigation?
   - What's the user journey to reach it?
   - How does it relate to existing features?
   
   **b) Visual Design**:
   - Which existing components can be reused?
   - What new patterns are needed?
   - How to maintain visual consistency?
   - What's the visual hierarchy?
   
   **c) Interactions**:
   - What are the micro-interactions?
   - How to handle loading states?
   - What about error states?
   - Empty state design?
   
   **d) Responsive Design**:
   - Mobile-first or desktop-first?
   - Breakpoint considerations?
   - Touch vs mouse interactions?
   - Performance implications?
   
   **e) Accessibility**:
   - Keyboard navigation flow?
   - Screen reader considerations?
   - Color contrast requirements?
   - ARIA labels needed?

4. **Save every Q&A to session**:
   ```json
   "questionHistory": [
     {
       "questionId": "ia-placement-1",
       "questionText": "Where should users access this feature?",
       "rationale": "Determines navigation and discoverability",
       "category": "information-architecture",
       "priority": "high",
       "timestamp": "[when asked]",
       "userResponse": "[user answer]",
       "responseClassification": "direct_answer",
       "responseTimestamp": "[when answered]"
     }
   ]
   ```

### Step 6: Mockup Generation (MANDATORY)
Create interactive mockups based on design decisions:

1. **Update session** status to "generating-mockups"

2. **Determine mockup format**:
   - If Figma MCP available: Create Figma designs
   - Otherwise: Generate HTML/CSS/JS prototypes
   - Adapt fidelity based on feature needs

3. **Create mockup structure**:
   ```
   .do/mockups/[prd-name]/
   ├── v1/
   │   ├── index.html
   │   ├── styles.css
   │   ├── interactions.js
   │   └── assets/
   └── current/ (symlink to latest)
   ```

4. **Generate interactive prototype**:
   - Include all major screens/states
   - Implement basic interactions
   - Show state transitions
   - Include responsive behavior

5. **Present mockup for review**:
   ```
   🎨 Mockup Ready for Review!
   
   📁 Location: .do/mockups/[prd-name]/v1/
   🖼️ Format: HTML/CSS/JS prototype
   
   The mockup includes:
   • [List of screens/components]
   • Interactive elements
   • Responsive design
   • State demonstrations
   
   To view: Open index.html in your browser
   
   Would you like to:
   1. Make changes (describe what to modify)
   2. Approve and continue
   3. Start over with different approach
   ```

6. **Handle iterations**:
   - Save each version (v1, v2, etc.)
   - Track changes in session
   - Update current symlink
   - Document iteration rationale

### Step 7: Design Specifications Generation (MANDATORY)
Create comprehensive design specs and enhance PRD:

1. **Update session** status to "generating-specifications"

2. **Compile design decisions**:
   - Information architecture choices
   - Visual design specifications
   - Component architecture
   - Interaction patterns
   - Accessibility requirements

3. **Generate Design Specifications section**:
   ```markdown
   ## Design Specifications
   _Added by do:design from design-[prd-name]-[timestamp].json on [date]_
   
   ### Design System
   - Status: [Created/Enhanced/Using existing]
   - Style guide: .do/design-system/style-guide.json
   - New tokens added: [list if any]
   
   ### User Experience
   - User journey: [description]
   - Information architecture: [placement and navigation]
   - Accessibility: [WCAG compliance level and considerations]
   
   ### Visual Design
   - Design approach: [wireframe/standard/high-fidelity]
   - Brand alignment: [how it maintains consistency]
   - Responsive strategy: [breakpoints and approach]
   
   ### Component Architecture
   - Reused components: [list with modifications needed]
   - New components: [list with specifications]
   - Component documentation: .do/design-system/components.json
   
   ### Mockups
   - Location: .do/mockups/[prd-name]/current/
   - Format: [Figma/HTML prototype]
   - Version: v[number] ([iteration count] iterations)
   - Key screens: [list]
   
   ### Interaction Design
   - Micro-interactions: [list with descriptions]
   - State handling:
     - Loading: [approach]
     - Error: [approach]
     - Empty: [approach]
     - Success: [approach]
   - Transitions: [animation specs]
   
   ### Design Rationale
   - Key decisions: [list major choices]
   - Trade-offs: [what was considered]
   - Future considerations: [extensibility notes]
   ```

4. **Update PRD file (CRITICAL - VERIFY)**:
   - Read original PRD content successfully
   - Generate complete Design Specifications section
   - Append to PRD without modifying existing content
   - MUST write updated PRD back to file
   - MUST verify file was updated successfully
   - If write/verification fails: STOP and report error
   - Preserve all existing content
   - Add metadata comment with session reference

5. **Update design system** if modified:
   - Save changes to style-guide.json
   - Update component registry
   - Document new patterns

### Step 8: Completion and Handoff (MANDATORY)
Finalize design phase and prepare for next steps:

1. **Update session** status to "completed"

2. **Archive session** to `.do/sessions/archive/`

3. **Present completion summary**:
   ```
   ✅ Design Analysis Complete!
   
   📋 **Design Deliverables:**
   • Design Specifications added to PRD
   • Mockups: .do/mockups/[prd-name]/
   • Design System: [Updated/Created]
   • Session: [session-id] (archived)
   
   🎨 **Design Summary:**
   • Placement: [key IA decision]
   • Visual: [key visual approach]
   • Interactions: [key patterns]
   • Components: [reused vs new ratio]
   
   🚀 **Next Steps:**
   1. **Engineering Review**: /do:review [prd-filename]
   2. **Direct to Build**: /do:build [prd-filename]
   3. **View Mockups**: Open mockup location
   4. **Iterate Design**: /do:continue design-[session-id]
   
   The enhanced PRD is ready for the next phase!
   ```

## Configuration-Driven Behavior

The design process adapts based on `.do/config.json` settings:

- **questioningDepth**: Controls depth of design questioning
- **designOptions**: All design-specific preferences
- **mockupFormat**: Preferred mockup output format
- **designDepth**: Level of design detail (wireframe/standard/high-fidelity)

## Error Handling and Fallbacks

### Session Creation Errors
- **CRITICAL**: If session cannot be created, STOP immediately
- Report exact error to user
- Do not proceed without session

### PRD Loading Errors
- File not found: Show available PRDs via /do:list
- Corrupted PRD: Attempt partial parsing
- Invalid format: Provide structure guidance

### Design Tool Errors
- Puppeteer not available: Offer setup help
- Figma connection failed: Fall back to HTML
- Screenshot errors: Continue without screenshots

### Mockup Generation Errors
- File write errors: Try alternative location
- Large file issues: Optimize or split files
- Browser compatibility: Note requirements

---

**BEFORE STARTING: Use TodoWrite to create a plan with all mandatory steps**

Use the TodoWrite tool to create todos for each mandatory step:
1. "🚨 CRITICAL: Create session file (NEVER SKIP)"
2. "Load and validate PRD file"
3. "Load configuration and design context"
4. "Run guided configuration if needed"
5. "Perform design system discovery"
6. "Conduct design questioning flow"
7. "Generate mockups and prototypes"
8. "Create design specifications and enhance PRD"
9. "Complete handoff and verify session exists"

Mark each step as "in_progress" when starting and "completed" when finished.

**Begin the design analysis process now with**: "$ARGUMENTS"