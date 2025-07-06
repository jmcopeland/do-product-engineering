# PRD: Do Design Command - UI/UX Design Analysis

**Generated**: 2025-07-04 10:45:32  
**Requirement**: "Create '/do:design' command for UI/UX design analysis"  
**Complexity**: 4/5  
**Status**: Ready for Review

## Context

The Do:PE AI system currently supports a plan → review → build workflow for transforming requirements into implemented features. This PRD introduces a new `/do:design` command that adds UI/UX design analysis capabilities, positioning it between the plan and review phases to create a more complete development lifecycle: plan → **design** → review → build → test → ship → learn.

The design command will act as a Senior UI/UX/Product Designer persona, analyzing PRDs and creating comprehensive design specifications including mockups, component architecture, and design system updates.

## User Stories

### As a Product Manager
- I want to ensure features have proper UI/UX design analysis before engineering review
- I want design decisions documented and mockups created to validate user experience
- I want to maintain design consistency across features through a shared design system

### As a Developer
- I want clear design specifications and mockups before implementation
- I want to understand which existing components to reuse and what's new
- I want design decisions that consider our current codebase and patterns

### As a Designer
- I want the AI to discover and respect our existing design system
- I want to iterate on mockups based on feedback
- I want all design decisions tracked for future reference

## Core Requirements

### 1. Command Integration
- **Command Name**: `/do:design <prd-filename>`
- **Workflow Position**: After `/do:plan`, before `/do:review`
- **Input**: PRD file from plan phase
- **Output**: Enhanced PRD with Design Specifications section

### 2. Design System Discovery
- **Automatic Codebase Scanning**:
  - Detect UI component files (React, Vue, etc.)
  - Find theme files, CSS, style configurations
  - Identify existing design tokens and patterns
  - Locate mockup tools and design assets

- **Screenshot Capability**:
  - Use Puppeteer MCP if available for web apps
  - Capture existing UI patterns for reference
  - Prompt user to install Puppeteer if not available

- **Design System Management**:
  - Create/update `.do/design-system/style-guide.json`
  - Track colors, typography, spacing, component inventory
  - Maintain single source of truth per project
  - Store incremental updates in PRD history

### 3. Guided Configuration
- **First Run Experience**:
  - Auto-trigger configuration on first `/do:design` use
  - Scan codebase for design assets
  - Ask about external design tools (Figma, Sketch, Adobe XD)
  - Save preferences to config.json

- **Manual Configuration**:
  - Trigger via `/do:design --config`
  - Update design tool integrations
  - Modify design preferences

- **Configuration Storage**:
  ```json
  "designOptions": {
    "scanCodebase": true,
    "captureScreenshots": true,
    "designSystemDiscovery": "auto",
    "mockupFormat": "adaptive",
    "designDepth": "standard",
    "componentInventory": true,
    "accessibilityChecks": true
  }
  ```

### 4. Design Analysis Flow
- **Adaptive Questioning** (reuse existing AI questioning framework):
  - Load design-specific question templates
  - Pre-answer from codebase analysis
  - Filter questions by feature relevance
  - Skip inapplicable questions intelligently

- **Question Categories**:
  1. **Design System** - Existing patterns, new tokens needed
  2. **Information Architecture** - Feature placement, navigation, user journey
  3. **Visual Design** - Component reuse, new patterns, consistency
  4. **Interactions** - Micro-interactions, states (error, loading, empty)
  5. **Accessibility** - WCAG compliance, keyboard navigation, screen readers

### 5. Mockup Generation
- **Format Selection**:
  - Prefer Figma if MCP available
  - Fall back to HTML/CSS/JS prototypes
  - Adapt format based on feature needs

- **Mockup Capabilities**:
  - Clickable prototypes with basic interactions
  - Demonstrate user flows and state changes
  - Include responsive design considerations
  - Show component composition

- **Iteration Support**:
  - Display mockup to user
  - Accept feedback and modification requests
  - Update mockup based on changes
  - Track iteration history in session

### 6. Session Management
- **Session Structure**:
  ```json
  {
    "sessionId": "design-[prd-name]-[timestamp]",
    "sessionType": "design",
    "prdFile": "[prd-filename]",
    "status": "in-progress|completed",
    "createdAt": "[ISO timestamp]",
    "lastUpdated": "[ISO timestamp]",
    "designSystemAnalysis": {
      "existingAssets": {},
      "designSystemStatus": "none|partial|complete",
      "recommendedApproach": "create-new|enhance-existing|use-existing"
    },
    "questionHistory": [
      {
        "questionId": "unique-id",
        "questionText": "Full question text",
        "rationale": "Why this matters",
        "category": "design-system|ia|visual|interaction|accessibility",
        "priority": "high|medium|low",
        "timestamp": "[when asked]",
        "userResponse": "User's answer",
        "responseClassification": "direct_answer|skip|clarification",
        "responseTimestamp": "[when answered]"
      }
    ],
    "designDecisions": {
      "placement": "navigation location",
      "componentReuse": ["existing components"],
      "newComponents": ["new components needed"],
      "styleGuideUpdates": {},
      "mockupReferences": ["mockup file paths"]
    },
    "iterationHistory": [
      {
        "version": 1,
        "timestamp": "[ISO timestamp]",
        "changes": ["list of changes"],
        "mockupSnapshot": "path/to/version"
      }
    ]
  }
  ```

- **Session Persistence**:
  - Auto-save after every question/answer
  - Maintain complete conversation audit trail
  - Archive completed sessions
  - Enable resumption via `/do:continue`

### 7. Design Specifications Output
- **PRD Enhancement Format**:
  ```markdown
  ## Design Specifications
  _Added by do:design from design-[prd-name]-[timestamp].json on [date]_

  ### Design System
  - Using existing component library with extensions
  - Style guide: .do/design-system/style-guide.json
  - New tokens added: [list]

  ### User Experience
  - User journey: [description]
  - Information architecture: [placement decisions]
  - Accessibility considerations: [WCAG compliance notes]

  ### Visual Design
  - Design approach: [wireframe|standard|high-fidelity]
  - Brand alignment: [how it fits brand guidelines]
  - Responsive breakpoints: [mobile, tablet, desktop specs]

  ### Component Architecture
  - Reused: [existing components list]
  - Modified: [components needing updates]
  - New: [new components with specifications]

  ### Mockups
  - Location: .do/mockups/[prd-name]/
  - Format: [Figma|HTML/CSS/JS]
  - Files:
    - [list of mockup files]
  - Iteration version: [current version number]

  ### Interaction Design
  - Micro-interactions: [list with descriptions]
  - State handling: [error, loading, empty, success states]
  - Transitions: [animation specifications]

  ### Design Rationale
  - [Key design decisions and reasoning]
  - [Trade-offs considered]
  - [Future considerations]
  ```

## Acceptance Criteria

1. **Command Execution**
   - [ ] `/do:design <prd-file>` loads and validates PRD
   - [ ] Handles missing files with helpful guidance
   - [ ] Checks for existing Design Specifications section

2. **Configuration**
   - [ ] First-run configuration triggers automatically
   - [ ] `/do:design --config` allows manual configuration
   - [ ] Settings persist in config.json
   - [ ] Design tool preferences are respected

3. **Design System Discovery**
   - [ ] Scans codebase for UI assets successfully
   - [ ] Creates/updates design system documentation
   - [ ] Captures screenshots when Puppeteer available
   - [ ] Handles missing tools gracefully

4. **Design Analysis**
   - [ ] Asks relevant questions based on feature type
   - [ ] Skips inapplicable questions intelligently
   - [ ] Saves all Q&A in session with timestamps
   - [ ] Allows early termination and resumption

5. **Mockup Generation**
   - [ ] Creates appropriate mockups (Figma or HTML)
   - [ ] Mockups are interactive and demonstrate flow
   - [ ] Supports iteration based on feedback
   - [ ] Versions are tracked in session

6. **PRD Enhancement**
   - [ ] Adds comprehensive Design Specifications section
   - [ ] Links to mockups and design system updates
   - [ ] Preserves original PRD content
   - [ ] Includes session reference

7. **Workflow Integration**
   - [ ] Integrates cleanly between plan and review
   - [ ] Hands off enhanced PRD to next phase
   - [ ] Session data supports troubleshooting

## Implementation Notes

### File Structure
```
.do/
├── design-system/
│   ├── style-guide.json
│   ├── components.json
│   └── tokens.json
├── mockups/
│   └── [prd-name]/
│       ├── v1/
│       ├── v2/
│       └── current/
├── sessions/
│   └── design-[prd-name]-[timestamp].json
└── questions/
    ├── design-system.md
    ├── information-architecture.md
    ├── visual-design.md
    ├── interactions.md
    └── accessibility.md
```

### Technical Considerations
- Reuse existing session management infrastructure
- Adapt AI questioning framework for design context
- Implement mockup generation as modular system
- Ensure design system updates are non-destructive
- Handle large mockup files efficiently

### Dependencies
- MCP Puppeteer for screenshots (optional)
- MCP Figma for design tool integration (optional)
- HTML/CSS/JS generation capabilities (fallback)
- Existing AI questioning framework
- Session management system

## Success Metrics

1. **Adoption**: Teams use design phase for >80% of features
2. **Quality**: Design specifications reduce implementation rework
3. **Efficiency**: Design analysis completes in <15 minutes average
4. **Consistency**: Design system adoption increases across features
5. **Satisfaction**: Positive feedback on mockup quality and iteration

## TODOs and Future Considerations

1. **Design Tool Integrations**:
   - [ ] Explore Sketch API integration
   - [ ] Add Adobe XD support
   - [ ] Consider Framer integration

2. **Advanced Capabilities**:
   - [ ] A/B testing mockup variants
   - [ ] Automated accessibility scoring
   - [ ] Design system lint rules
   - [ ] Component usage analytics

3. **Team Collaboration**:
   - [ ] Multi-user design sessions
   - [ ] Design review workflows
   - [ ] Version control for mockups
   - [ ] Design approval tracking

## Assumptions Made

**From Codebase Analysis:**
- Existing command structure can be extended for design
- Session management patterns are reusable
- Question template system supports design questions

**From Requirements Discussion:**
- Single design system per project is sufficient
- HTML/CSS/JS mockups are acceptable alternative to Figma
- Design phase is valuable for all feature types
- Iteration on mockups is critical for success

**Areas for Future Clarification:**
- Specific design tool API requirements
- Performance requirements for large mockup files
- Integration with existing design team workflows
- Handoff format preferences for developers