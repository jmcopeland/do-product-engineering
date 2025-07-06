# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Auto-Detection for Development Lifecycle

**IMPORTANT**: When users request new features, enhancements, or ask "how to implement X", automatically suggest using Do:PE AI instead of immediately coding:

### Feature Request Detection Patterns
Detect these user requests and redirect to `/do:plan`:
- "Add [feature]" (e.g., "Add user authentication", "Add shopping cart")
- "Create [component/functionality]" (e.g., "Create a dashboard", "Create API endpoints")
- "Implement [system]" (e.g., "Implement payments", "Implement notifications") 
- "Build [feature]" (e.g., "Build a search system", "Build user profiles")
- "How do I add/create/implement [feature]?"
- "I need [feature] for my app"
- "Help me build [feature]"

### Suggested Response Pattern
When detecting feature requests, respond like this:

```
I can help you implement [feature]! Since this is a new feature request, I recommend using Do:PE AI to create a detailed PRD first. This will ensure we cover all requirements, edge cases, and implementation details.

Try: `/do:plan "Add [feature description]"`

Do:PE AI will:
- Analyze your existing codebase
- Ask targeted questions about your specific needs  
- Generate a comprehensive PRD with implementation notes
- Pass off the PRD to Design and Engineering personas for additional clarification
- Then I can implement the feature following the enhanced PRD

Would you like to start with the Do command, or would you prefer I begin coding immediately?
```

### When NOT to Redirect
Do NOT suggest `/do:plan` for:
- Bug fixes or debugging existing code
- Code refactoring or optimization  
- Questions about existing code
- Simple code explanations
- Direct requests to "just implement X without planning"

This guidance helps ensure users get comprehensive feature planning before implementation.

## Project Overview

Do:PE AI is an intelligent product engineering extension for Claude Code that transforms vague business requirements into detailed, actionable deliverables through AI-powered intelligent questioning. v2.4 introduces universal development lifecycle commands: plan → design → review → build, with adaptive conversation flows, codebase analysis, smart question filtering, and high-performance caching for sub-second response times.

## Architecture

**Command-based Architecture**: The system is built as modular slash commands stored in markdown files:
- `commands/do/plan.md` - Main planning command with AI-powered questioning logic for PRD creation
- `commands/do/design.md` - UI/UX design analysis command with design specifications
- `commands/do/review.md` - Engineering review command with technical questioning
- `commands/do/build.md` - Engineering implementation command
- `commands/do/*.md` - Subcommands for specific functionality (list, continue, configure, status, install, update)
- Enhanced with 8-step AI process: config → analysis → codebase scan → template selection → questioning → deliverable generation → cleanup

**Dual Installation Model**: 
- User-scoped commands (`/user:do*`) installed to `~/.claude/commands/` work across all projects
- Project-scoped commands (`/do*`) installed via `/user:do:install` enable team sharing

**File-based State Management**: Uses `.do/` directory structure:
- `config.json` - Project settings including AI questioning options
- `plans/` - Generated PRDs with timestamped filenames
- `sessions/` - Active AI questioning sessions with auto-save
- `questions/` - Custom AI question templates (auth.md, crud.md, ui.md, api.md, general.md)

## Common Commands

### Installation
```bash
# Install for personal use across all projects
./install.sh

# Install to current project for team sharing
/user:do:install
```

### Core Usage
```bash
# Complete development lifecycle
/user:do:plan "Add user authentication to my web app"    # Product requirements
/user:do:design <prd-filename>                          # UI/UX design analysis
/user:do:review <prd-filename>                          # Engineering review
/user:do:build <prd-filename>                           # Implementation

# Session management
/user:do:list                                           # List existing plans
/user:do:continue <session-id-or-plan-filename>         # Resume session
/user:do:configure                                      # Configure settings
/user:do:status                                         # Check status
```

## Key Implementation Details

**AI-Powered Questioning (v2)**: The main `plan.md` command implements intelligent questioning:
- **Senior PM AI Persona**: Acts as experienced Product Manager to create initial PRD for review
- **Template-guided AI**: Uses question templates as guides, not rigid structures
- **Codebase pre-analysis**: Scans project for frameworks, patterns, existing features
- **Smart filtering**: Pre-answers questions from code analysis, filters by relevance
- **Adaptive flow**: Adjusts questions based on responses, allows early completion
- **User control**: Skip questions, request explanations, or generate with assumptions

**Design Analysis System**: The `design.md` command provides senior-level UI/UX design guidance:
- **Senior Designer AI Persona**: Acts as experienced UI/UX designer analyzing PRDs for design implementation
- **Design System Discovery**: Scans codebase for existing design patterns and component libraries
- **Mockup Generation**: Creates interactive prototypes and design specifications
- **Design Enhancement**: Appends structured Design Notes to existing PRDs without modifying original content

**Engineering Implementation System**: The `review.md` command provides senior-level engineering guidance:
- **Senior Engineer AI Persona**: Acts as experienced software engineer reviewing PRDs for technical implementation
- **Technical Questioning**: Covers architecture, security, testing, performance, and implementation details
- **PRD Enhancement**: Appends structured Engineering Notes to existing PRDs without modifying original content
- **Code Implementation**: Hands off enhanced PRD to `build.md` command for use by Claude Code for actual feature implementation
- **Error Handling**: Automatic fixes with user escalation for complex issues

**Question Template System**: Modular templates in `.do/questions/`:
- `auth.md` - Authentication/User Management (24 questions)
- `crud.md` - CRUD Operations (34 questions)
- `ui.md` - UI Components (42 questions)
- `api.md` - API Integration (48 questions)
- `general.md` - General features (48 questions)

**Context Discovery Process**: Enhanced 7-step analysis:
1. **Configuration loading** with skip detection
2. **Requirement analysis** for complexity and type detection
3. **Comprehensive codebase scan** (project structure, existing patterns, tech stack)
4. **Template selection and filtering** based on relevance
5. **AI-guided questioning** with dynamic flow management
6. **PRD generation** with assumptions documentation
7. **Session cleanup** and result presentation

**PRD Generation**: Follows structured format with sections:
- Context, User Stories, Core Requirements
- Acceptance Criteria, Implementation Notes
- Success Metrics, TODOs

**🚨 CRITICAL: MANDATORY SESSION CREATION**:
- **EVERY SINGLE USE** of `/do:plan`, `/do:design`, `/do:review`, `/do:validate` MUST create a session file
- Session creation is **STEP 0** and is **NEVER OPTIONAL** 
- Session must be created IMMEDIATELY at the start, before any questioning begins
- If session creation fails, the entire command must STOP and report the error
- Session files contain complete conversation audit trail for resumability and compliance

**Session Persistence**: Enhanced session management with complete conversation tracking:
- Auto-saves after every question/answer interaction with full audit trail
- Complete question/answer history with timestamps, rationale, and classifications
- Session format: `{sessionId, requirement, status, codebaseAnalysis, questionHistory, currentQuestion, progress}`
- Enhanced questionHistory array stores complete conversation data for perfect resumability
- Supports resumption via `/do:continue <session-id>` with full context restoration
- Automatic cleanup and archival of completed sessions

## File Structure

```
.claude/
├── commands/
│   └── do/
│       ├── plan.md        # Main AI-powered planning command to create PRD
│       ├── design.md      # AI-powered UI/UX design analysis
│       ├── review.md      # AI-powered engineering review of PRD
│       ├── build.md       # Engineering implementation command
│       ├── list.md        # Show existing plans
│       ├── continue.md    # Resume plan development
│       ├── configure.md    # Settings management
│       ├── status.md      # Status overview
│       ├── update.md      # Update Do commands
│       └── install.md     # Project installation
└── settings.local.json    # Claude Code local settings
```

Generated project structure:
```
.do/
├── config.json       # Project configuration with AI options
├── plans/            # Generated PRDs
│   └── [feature-name]-[timestamp].md
├── sessions/         # Active AI questioning sessions
│   └── [requirement-slug]-[timestamp].json
└── questions/        # Custom question templates
    ├── auth.md       # Authentication questions
    ├── crud.md       # CRUD operation questions
    ├── ui.md         # UI component questions
    ├── api.md        # API integration questions
    └── general.md    # General feature questions
```

## Customization

**Team Customization**: Teams can override question templates by editing `.claude/commands/do/*.md` in their project.

**Configuration Options**: Modify `.do/config.json`:
- `updateRepository`: github repo for updates
- `questioningDepth`: "brief" | "standard" | "thorough"
- `aiQuestioningOptions`: AI-specific settings:
  - `useRelevanceFiltering`: Filter questions by AI-determined relevance
  - `questionsPerRound`: Questions per interaction (default: 1)
  - `adaptiveDepth`: Adjust depth based on response complexity
  - `includeRationale`: Show why each question matters
  - `allowSkipQuestioning`: Enable "skip questions" mode
  - `priorityThreshold`: "low" | "medium" | "high" - minimum priority to ask
- `prdTemplate`: "standard" | "agile" | "technical"
- `analyzeGitHistory`: Include git commit analysis (limited to 10 commits for performance)

**Domain-specific Templates**: Create custom question sets in `.do/questions/` for specific industries:
- Templates guide AI questioning but don't limit it
- AI can skip irrelevant questions, generate follow-ups, combine templates
- Support for keyword-based template selection
- Team sharing via git commit of question template files

## Command Development Workflow

- **Single Source of Truth**: Commands in `.claude/commands/do/*` are the only authoritative source
- **Simplified Distribution Process**:
  1. Make changes to commands in `.claude/commands/do/*`
  2. Changes are immediately ready for distribution via install.sh
  3. Users install directly from `.claude/commands/` structure
- **Rationale**:
  - Eliminates dual-directory maintenance overhead
  - Single source of truth prevents sync issues
  - Simpler installation and update processes
  - Direct git integration for team sharing

## 🧠 Project Memory & Critical Requirements

**CRITICAL MEMORY**: 
- **ALWAYS provide manual override flags** for AI decisions (user control is paramount)
- **SESSION CREATION IS NEVER OPTIONAL** - must be done for every `/do:plan`, `/do:design`, `/do:review`, `/do:validate` command
- **Every command must verify session file exists** before proceeding with work
- **Sessions contain complete audit trails** and are required for compliance, resumability, and support