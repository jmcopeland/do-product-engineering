# Do:PE - AI Product Engineering Lifecycle for Claude Code

🤖 **v2.7.0 Intelligent Workflow Router** - Smart routing with `/do` command that analyzes input and suggests optimal workflow entry point: think → validate → plan → design → review → build.

[![Version](https://img.shields.io/badge/version-2.7.0-blue.svg)](https://github.com/jmcopeland/do-product-engineering)
[![Claude Code](https://img.shields.io/badge/Claude%20Code-Compatible-green.svg)](https://claude.ai/code)
[![License](https://img.shields.io/badge/license-MIT-green.svg)](LICENSE)

## Overview

Do:PE AI adds intelligent product engineering capabilities to Claude Code via custom slash commands. It provides the complete development lifecycle from idea capture through validation to implementation, analyzing your project context, asking intelligent questions, and generating comprehensive deliverables (Ideas, Validation Documents, PRDs, Design Specs, Engineering Notes) that Claude Code can execute.

## Requirements

- [Claude Code CLI](https://claude.ai/code) - The AI coding assistant
- Git repository (recommended for context analysis)

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
git clone https://github.com/jmcopeland/do-product-engineering.git
cd do-product-engineering
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
/do:install --with-auto-detection
```

## Available Commands

### 🎯 Main Command (Smart Routing)
- **`/do "feature description"`** - **Intelligent workflow router** that analyzes your input and existing files to recommend the next logical step
  - Analyzes `.do/ideas/`, `.do/validations/`, and `.do/plans/` for related files
  - Suggests appropriate workflow step (think → validate → plan → design → review → build)
  - Presents interactive menu with all options for user choice
  - Defaults to "think" (idea capture) for new concepts

### 📋 Specific Commands (Direct Workflow Access)
- `/do:think` - List captured ideas
- `/do:think "my new idea"` - Quickly capture new ideas
- `/do:validate "requirement" OR <my-new-idea-file> [--type=product|feature]` - Validate with configurable scoring
- `/do:plan "requirement" [--template=<name>]` - AI-powered PRD creation for project
- `/do:design <prd-file>` - UI/UX design analysis with design specifications
- `/do:review <prd-file>` - Senior engineer AI review of PRD
- `/do:build <prd-file>` - Feature implementation from enhanced PRD
- `/do:continue <plan>` - Resume plan or session
- `/do:plan` (no arguments) - Show project plans and active sessions
- `/do:configure` - Project AI questioning settings
- `/do:status` - System health and cleanup recommendations
- `/do:install` - Copy commands to current project
- `/do:update` - Update commands to latest version

## Example Usage

### 🎯 Complete Development Lifecycle
```bash
# Use the intelligent router - it will guide you through the workflow
/do "Add user profile management with social login"

# The router will:
# 1. 🔍 Analyze your input and check for existing related files
# 2. 💡 Recommend the next logical step (likely "think" for new ideas)
# 3. 📋 Present interactive menu with all workflow options
# 4. 🚀 Execute your chosen step with proper context

# Example workflow the router might suggest:
# 1. Start with idea capture
/do:think "Add user profile management with social login"

# 2. Validate the business case  
/do:validate idea-20250706-user-profile.md

# 3. Plan the validated feature
/do:plan validation-20250706-user-profile.md

# 4. Design and implement
/do:design user-profile-20250706.md
/do:review user-profile-20250706.md
/do:build user-profile-20250706.md
```

### ⚡ Quick Options for Speed
```bash
# Use the smart router for any feature
/do "Add CRUD operations"         # Router will suggest starting with "think"
/do "Add user dashboard"          # Router analyzes and suggests next step

# Or use specific commands directly
/do:think "Add CRUD operations"   # Capture idea directly
/do:think                         # List all captured ideas

# Direct validation and planning
/do:validate "Add user dashboard" --type=feature
/do:plan "Add CRUD operations, skip questions"
```

### 🔄 Session Management
```bash
# Resume if interrupted
/do:continue user-auth-20250701-140000

# Check status and cleanup
/do:status
/do:plan
```

## Directory Structure

After installation:
```
~/.claude/commands/
  do.md                   # 🎯 Main intelligent routing command
  do/
    do:think.md           # Rapid idea capture
    do:validate.md        # Lean validation methodology
    do:plan.md            # Dual-mode planning and list view
    do:design.md          # Senior UI/UX design analysis
    do:review.md          # Senior engineer AI review of PRD
    do:build.md           # Feature implementation from enhanced PRD
    do:continue.md        # Resume plan development
    do:configure.md        # AI questioning settings
    do:status.md          # System health dashboard
    do:install.md         # Project installation

# In your projects (after /do:install):
.claude/commands/         # Team-shared commands
  do.md                   # 🎯 Main intelligent routing command
  do/                     # Specific workflow commands
.do/
  config.json              # AI questioning configuration
  ideas/                  # Captured ideas
    ideas.md              # Central list of all ideas
    idea-*.md             # Individual idea files
  validations/            # Lean Validation Documents
  plans/                  # Generated PRDs
  sessions/               # Active AI questioning sessions
  questions/              # Custom question templates
  templates/              # Validation scoring templates
```

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