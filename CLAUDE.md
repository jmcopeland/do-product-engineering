# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Auto-Detection for Product Management

**IMPORTANT**: When users request new features, enhancements, or ask "how to implement X", automatically suggest using the AI Product Manager instead of immediately coding:

### Feature Request Detection Patterns
Detect these user requests and redirect to `/pm:define`:
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
I can help you implement [feature]! Since this is a new feature request, I recommend using the AI Product Manager to create a detailed PRD first. This will ensure we cover all requirements, edge cases, and implementation details.

Try: `/pm:define "Add [feature description]"`

The AI Product Manager will:
- Analyze your existing codebase
- Ask targeted questions about your specific needs  
- Generate a comprehensive PRD with implementation notes
- Then I can implement the feature following the PRD

Would you like to start with the PM command, or would you prefer I begin coding immediately?
```

### When NOT to Redirect
Do NOT suggest `/pm:define` for:
- Bug fixes or debugging existing code
- Code refactoring or optimization  
- Questions about existing code
- Simple code explanations
- Direct requests to "just implement X without planning"

This guidance helps ensure users get comprehensive feature planning before implementation.

## Project Overview

AI Product Manager is an intelligent product management extension for Claude Code that transforms vague business requirements into detailed, actionable PRDs through AI-powered intelligent questioning. v2.1 introduces adaptive conversation flows, codebase analysis, smart question filtering, and high-performance caching for sub-second response times.

## Architecture

**Command-based Architecture**: The system is built as modular slash commands stored in markdown files:
- `commands/pm/define.md` - Main PM command with AI-powered questioning logic
- `commands/pm/*.md` - Subcommands for specific functionality (list, continue, configure, status, install, update)
- Enhanced with 7-step AI process: config → analysis → codebase scan → template selection → questioning → PRD generation → cleanup

**Dual Installation Model**: 
- User-scoped commands (`/user:pm*`) installed to `~/.claude/commands/` work across all projects
- Project-scoped commands (`/pm*`) installed via `/user:pm:install` enable team sharing

**File-based State Management**: Uses `.claude-pm/` directory structure:
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
/user:pm:install
```

### Core Usage
```bash
# Start new requirement gathering
/user:pm:define "Add user authentication to my web app"

# List existing plans
/user:pm:list

# Resume interrupted session or modify existing plan
/user:pm:continue <session-id-or-plan-filename>

# Configure settings
/user:pm:configure

# Check current status
/user:pm:status
```

## Key Implementation Details

**AI-Powered Questioning (v2)**: The main `define.md` command implements intelligent questioning:
- **Template-guided AI**: Uses question templates as guides, not rigid structures
- **Codebase pre-analysis**: Scans project for frameworks, patterns, existing features
- **Smart filtering**: Pre-answers questions from code analysis, filters by relevance
- **Adaptive flow**: Adjusts questions based on responses, allows early completion
- **User control**: Skip questions, request explanations, or generate with assumptions

**Question Template System**: Modular templates in `.claude-pm/questions/`:
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

**Session Persistence**: Enhanced session management with JSON format:
- Auto-saves after every question/answer interaction
- Includes codebase analysis, question queue, responses, and progress tracking
- Session format: `{sessionId, requirement, status, codebaseAnalysis, questionQueue, responses, progress}`
- Supports resumption via `/continue <session-id>` with full context restoration
- Automatic cleanup and archival of completed sessions

## File Structure

```
.claude/
├── commands/
│   └── pm/
│       ├── define.md       # Main AI-powered PM command
│       ├── list.md        # Show existing plans
│       ├── continue.md    # Resume plan development
│       ├── configure.md    # Settings management
│       ├── status.md      # Status overview
│       ├── update.md      # Update AI PM
│       └── install.md     # Project installation
└── settings.local.json    # Claude Code local settings
```

Generated project structure:
```
.claude-pm/
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

**Team Customization**: Teams can override question templates by editing `.claude/commands/pm.md` in their project.

**Configuration Options**: Modify `.claude-pm/config.json`:
- `updateRepository`: github repo for updates
- `questioningMode`: "ai-powered" | "template" | "hybrid"
- `questioningDepth`: "brief" | "standard" | "thorough"
- `maxQuestions`: Number of questions (template mode only)
- `aiQuestioningOptions`: AI-specific settings:
  - `useRelevanceFiltering`: Filter questions by AI-determined relevance
  - `questionsPerRound`: Questions per interaction (default: 1)
  - `adaptiveDepth`: Adjust depth based on response complexity
  - `includeRationale`: Show why each question matters
  - `allowSkipQuestioning`: Enable "skip questions" mode
  - `priorityThreshold`: "low" | "medium" | "high" - minimum priority to ask
- `prdTemplate`: "standard" | "agile" | "technical"
- `analyzeGitHistory`: Include git commit analysis (limited to 10 commits for performance)

**Domain-specific Templates**: Create custom question sets in `.claude-pm/questions/` for specific industries:
- Templates guide AI questioning but don't limit it
- AI can skip irrelevant questions, generate follow-ups, combine templates
- Support for keyword-based template selection
- Team sharing via git commit of question template files

## Command Development Workflow

- **Single Source of Truth**: Commands in `.claude/commands/pm*` are the only authoritative source
- **Simplified Distribution Process**:
  1. Make changes to commands in `.claude/commands/pm*`
  2. Changes are immediately ready for distribution via install.sh
  3. Users install directly from `.claude/commands/` structure
- **Rationale**:
  - Eliminates dual-directory maintenance overhead
  - Single source of truth prevents sync issues
  - Simpler installation and update processes
  - Direct git integration for team sharing