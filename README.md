# Do:PE - AI Product Engineering Lifecycle for Claude Code

🤖 **v2.6.0 Complete Validation Workflow** - Full development lifecycle: `/do:think` → `/do:validate` → `/do:plan` → `/do:design` → `/do:review` → `/do:build` with idea capture and lean validation methodology.

[![Version](https://img.shields.io/badge/version-2.6.0-blue.svg)](https://github.com/jmcopeland/ai-product-manager)
[![Claude Code](https://img.shields.io/badge/Claude%20Code-Compatible-green.svg)](https://claude.ai/code)
[![License](https://img.shields.io/badge/license-MIT-green.svg)](LICENSE)

## Overview

Do:PE AI adds intelligent product engineering capabilities to Claude Code via custom slash commands. It provides the complete development lifecycle from idea capture through validation to implementation, analyzing your project context, asking intelligent questions, and generating comprehensive deliverables (Ideas, Validation Documents, PRDs, Design Specs, Engineering Notes) that Claude Code can execute.

## Requirements

- [Claude Code CLI](https://claude.ai/code) - The AI coding assistant
- Git repository (recommended for context analysis)
- Markdown support (for PRD generation)

## Features

### 💡 Complete Development Lifecycle (NEW v2.6)
- **Idea Capture** - Rapid idea capture with `/do:think` and seamless workflow integration
- **Lean Validation** - Validate ideas before development with `/do:validate` using lean methodology
- **Smart Planning** - AI-powered PRD creation with codebase analysis
- **Design Integration** - UI/UX analysis and specifications
- **Engineering Review** - Technical analysis and implementation planning
- **Guided Implementation** - Context-rich feature development

### 🧠 AI-Powered Questioning
- **Smart Analysis** - Pre-answers questions by analyzing your codebase
- **Adaptive Conversation** - Asks only relevant questions, one at a time with context
- **User Control** - Skip questions, request explanations, or end early with "good to go"
- **Skip Mode** - Generate deliverables with assumptions when you want speed over detail

### 🏗️ Core Capabilities
- **Context Discovery** - Automatically analyzes project structure, git history, and documentation
- **Session Management** - Auto-saves progress, resume interrupted sessions
- **Validation Scoring** - Configurable scoring system for go/no-go decisions
- **File Integration** - Seamless handoff between workflow stages
- **Team Collaboration** - Share customized commands and question templates
- **Auto-Detection** - Claude Code automatically suggests development workflow for feature requests

## Quick Start

### 🚀 Automatic Installation
```bash
# Clone and install
git clone https://github.com/jmcopeland/ai-product-manager.git
cd ai-product-manager
./install.sh

# Start using immediately - complete workflow
/do:think "Add user authentication to my app"    # Capture idea
/do:validate idea-file.md                         # Validate business value
/do:plan validation-file.md                       # Create detailed PRD
```

### 🎯 Auto-Detection Installation (Recommended)
Enable Claude Code to automatically suggest `/do:plan` or `/do:validate` for feature requests:

```bash
# Install with auto-detection in current project
./install.sh --with-auto-detection

# Or add to existing project
/user:do:install --with-auto-detection
```

**What this does:**
- Adds CLAUDE.md guidance to detect feature requests
- Claude Code will suggest `/do:plan` or `/do:validate` when you ask for new features
- Example: "Add user auth" → Claude suggests complete workflow starting with `/do:think` or `/do:validate`
- Improves workflow by encouraging proper planning before coding

### 👥 Team Installation
```bash
# After individual install, add to your project with auto-detection:
/user:do:install --with-auto-detection

# Commit for team sharing (includes CLAUDE.md auto-detection)
git add .claude/commands/do/* CLAUDE.md
git commit -m "Add Do:PE AI for team use"
```

## Available Commands

### User Commands (Available Everywhere)
- `/user:do:think "idea"` - **NEW v2.6**: Rapid idea capture with workflow integration
- `/user:do:validate "requirement"` - **NEW v2.6**: Lean validation methodology for go/no-go decisions
- `/user:do:plan "requirement"` - AI-powered PRD creation with codebase analysis
- `/user:do:design <prd-file>` - UI/UX design analysis and specifications
- `/user:do:review <prd-file>` - Senior engineer AI review of PRD
- `/user:do:build <prd-file>` - Feature implementation from enhanced PRD
- `/user:do:continue <plan>` - Resume plan development
- `/user:do:list` - Show existing plans
- `/user:do:configure` - Manage settings
- `/user:do:status` - Show current state
- `/user:do:install` - Copy commands to current project
- `/user:do:update` - Update user-scope commands to latest version

### Project Commands (After Installation)
- `/do:think "idea"` - **NEW v2.6**: Capture ideas and list existing ideas
- `/do:validate "requirement" [--type=product|feature]` - **NEW v2.6**: Validate with configurable scoring
- `/do:plan "requirement" [--template=<name>]` - AI-powered PRD creation for project
- `/do:design <prd-file>` - UI/UX design analysis with design specifications
- `/do:review <prd-file>` - Senior engineer AI review of PRD
- `/do:build <prd-file>` - Feature implementation from enhanced PRD
- `/do:continue <plan>` - Resume plan or session
- `/do:list` - Show project plans and active sessions
- `/do:configure` - Project AI questioning settings
- `/do:status` - System health and cleanup recommendations
- `/do:update` - Update commands to latest version

## Example Usage

### 🎯 Complete Development Lifecycle (NEW v2.6)
```bash
# Start with idea capture
/do:think "Add user profile management with social login"

# Validate the business case
/do:validate idea-20250706-user-profile.md

# v2.6 validation system will:
# 1. 🎯 Detect product vs feature validation type
# 2. 🤔 Ask focused validation questions with lean methodology
# 3. 📊 Calculate validation score with configurable criteria
# 4. 📋 Generate Lean Validation Document (LVD) with go/no-go recommendation

# Plan the validated feature
/do:plan validation-20250706-user-profile.md

# v2 AI system will:
# 1. 🔍 Analyze your codebase (React? Django? existing auth?)
# 2. 🎯 Ask ~6-10 focused questions with context
# 3. 💬 Adapt based on your responses
# 4. 📋 Generate comprehensive PRD with assumptions
```

### ⚡ Quick Options for Speed
```bash
# Idea capture and list
/do:think "Add CRUD operations"    # Capture idea
/do:think                          # List all captured ideas

# Direct validation
/do:validate "Add user dashboard" --type=feature

# Generate with assumptions only
/do:plan "Add CRUD operations, skip questions"
/do:plan "Add user dashboard, make assumptions"
```

### 🔧 Implementation Flow
```bash
# Complete development lifecycle
/do:think "Feature idea"                    # 💡 Capture
/do:validate idea-file.md                   # ✅ Validate  
/do:plan validation-file.md                 # 📋 Plan
/do:design user-profile-20250706.md         # 🎨 Design
/do:review user-profile-20250706.md         # 🔍 Review
/do:build user-profile-20250706.md          # 🚀 Build

# Each step adds context for the next:
# - Validation provides business justification
# - Planning adds detailed requirements
# - Design adds UI/UX specifications  
# - Review adds technical implementation details
# - Build implements with complete context
```

### 🔄 Session Management
```bash
# Resume if interrupted
/do:continue user-auth-20250701-140000

# Check status and cleanup
/do:status
/do:list
```

## Installation Instructions

### Manual Installation
```bash
# Create directories
mkdir -p ~/.claude/commands/do

# Copy files
cp .claude/commands/do/*.md ~/.claude/commands/do/
```

### Team Setup
```bash
# In your project directory
/user:do:install

# Commit team commands
git add .claude/commands/do/*
git commit -m "Add Do:PE AI commands for team use"
```

## Directory Structure

After installation:
```
~/.claude/commands/
  do/
    do:think.md           # NEW v2.6: Rapid idea capture
    do:validate.md        # NEW v2.6: Lean validation methodology
    do:plan.md            # Main AI-powered planning command
    do:design.md          # UI/UX design analysis
    do:review.md          # Senior engineer AI review of PRD
    do:build.md           # Feature implementation from enhanced PRD
    do:list.md            # List plans and sessions
    do:continue.md        # Resume plan development
    do:configure.md       # AI questioning settings
    do:status.md          # System health dashboard
    do:install.md         # Project installation

# In your projects (after /user:do:install):
.claude/commands/         # Team-shared commands
.do/
  config.json              # AI questioning configuration
  ideas/                   # NEW v2.6: Captured ideas
    ideas.md               # Central list of all ideas
    idea-*.md              # Individual idea files
  validations/             # NEW v2.6: Lean Validation Documents
  plans/                   # Generated PRDs
  sessions/                # Active AI questioning sessions
  questions/               # Custom question templates
  templates/               # NEW v2.6: Validation scoring templates
```

## Generated PRD Format

Each PRD includes:
- **Context** - Feature background and rationale
- **User Stories** - "As a... I want... so that..." format
- **Core Requirements** - Detailed functional requirements
- **Acceptance Criteria** - Specific, testable criteria
- **Implementation Notes** - Technical considerations
- **Success Metrics** - Measurement criteria
- **TODOs** - Unresolved questions

## Configuration

### 🤖 AI Questioning Settings
Configure in `.do/config.json`:

```json
{
  "aiQuestioningOptions": {
    "useRelevanceFiltering": true,
    "priorityThreshold": "medium",
    "allowSkipQuestioning": true,
    "includeRationale": true,
    "adaptiveDepth": true
  }
}
```

### 📋 Custom Question Templates
Create domain-specific templates in `.do/questions/`:

```markdown
# questions/ecommerce.md
## Payment Processing
- What payment methods should be supported?
- How should refunds and disputes be handled?

## Inventory Management  
- How should stock levels be tracked?
- What happens when items go out of stock?
```

### 🎛️ Quick Configuration
```bash
# Interactive configuration
/do:configure

# Check current settings
/do:status
```

## Documentation

- [📖 AI Questioning Guide](docs/AI-QUESTIONING.md) - Complete v2 feature guide
- [🚀 Quick Start Examples](docs/EXAMPLES.md) - Common use cases

## Auto-Detection Feature

### 🎯 How Auto-Detection Works
When enabled, Claude Code automatically detects feature requests and suggests using `/do:plan`:

**Detected Patterns:**
- "Add [feature]" → Suggests complete workflow starting with `/do:think` or `/do:validate`
- "Create [component]" → Suggests `/do:think "Create [component]"`
- "Implement [system]" → Suggests validation and planning workflow
- "How do I add/build [feature]?" → Suggests complete development lifecycle

**User Experience:**
```
You: "Add user authentication to my app"
Claude: I can help you implement user authentication! Since this is a new 
        feature request, I recommend using Do:PE AI for the complete 
        development lifecycle.
        
        Complete workflow (NEW v2.6):
        1. /do:think "Add user authentication" - Capture and organize the idea
        2. /do:validate idea-file.md - Validate if this should be built
        3. /do:plan validation-file.md - Create detailed PRD
        
        Would you like to start with idea capture, validation, planning, 
        or prefer I begin coding immediately?
```

**What it WON'T detect:**
- Bug fixes and debugging
- Code refactoring 
- Questions about existing code
- Explicit "just code this" requests

### 🛠️ Technical Implementation
Auto-detection works via `CLAUDE.md` guidance that:
- Trains Claude Code to recognize feature request patterns
- Provides standardized response templates
- Maintains user choice between planning vs immediate coding
- Only applies to new feature development (not maintenance)


## Contributing

This tool is designed to be customized per team/project. Fork and modify the command templates to match your development workflow.

See [CONTRIBUTING.md](CONTRIBUTING.md) for development setup and guidelines.

## License

MIT License - Feel free to customize and distribute.