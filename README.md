# Do:PE - AI Product Engineering Lifecycle for Claude Code

🤖 **v2.5.0 Template Flag Enhancement** - `/do:plan` → `/do:design` → `/do:review` → `/do:build` workflow with command-line template override support.

[![Version](https://img.shields.io/badge/version-2.5.0-blue.svg)](https://github.com/jmcopeland/ai-product-manager)
[![Claude Code](https://img.shields.io/badge/Claude%20Code-Compatible-green.svg)](https://claude.ai/code)
[![License](https://img.shields.io/badge/license-MIT-green.svg)](LICENSE)

## Overview

Do:PE AI adds intelligent product engineering capabilities to Claude Code via custom slash commands. It analyzes your project context, asks intelligent questions, and generates comprehensive deliverables (PRDs, Design Specs, Engineering Notes) that Claude Code can execute.

## Features

### 🧠 AI-Powered Questioning (v2)
- **Smart Analysis** - Pre-answers questions by analyzing your codebase
- **Adaptive Conversation** - Asks only relevant questions, one at a time with context
- **User Control** - Skip questions, request explanations, or end early with "good to go"
- **Skip Mode** - Generate PRDs with assumptions when you want speed over detail

### 🏗️ Core Capabilities
- **Context Discovery** - Automatically analyzes project structure, git history, and documentation
- **Session Management** - Auto-saves progress, resume interrupted sessions
- **Plan Management** - Generate structured PRDs with implementation notes
- **Engineering Review** - Senior engineer AI reviews PRDs and provides additional technical details
- **Team Collaboration** - Share customized commands and question templates
- **Auto-Detection** - Claude Code automatically suggests `/do:plan` for feature requests

## Quick Start

### 🚀 Automatic Installation
```bash
# Clone and install
git clone https://github.com/jmcopeland/ai-product-manager.git
cd ai-product-manager
./install.sh

# Start using immediately
/do:plan "Add user authentication to my app"
```

### 🎯 Auto-Detection Installation (Recommended)
Enable Claude Code to automatically suggest `/do:plan` for feature requests:

```bash
# Install with auto-detection in current project
./install.sh --with-auto-detection

# Or add to existing project
/user:do:install --with-auto-detection
```

**What this does:**
- Adds CLAUDE.md guidance to detect feature requests
- Claude Code will suggest `/do:plan` when you ask for new features
- Example: "Add user auth" → Claude suggests `/do:plan "Add user authentication"`
- Improves workflow by encouraging proper planning before coding

### 👥 Team Installation
```bash
# After individual install, add to your project with auto-detection:
/user:do:install --with-auto-detection

# Commit for team sharing (includes CLAUDE.md auto-detection)
git add .claude/commands/pm/* CLAUDE.md
git commit -m "Add Do:PE AI for team use"
```

## Available Commands

### User Commands (Available Everywhere)
- `/user:do:plan "requirement"` - Start new PRD creation
- `/user:do:review <prd-file>` - Senior engineer AI review of PRD
- `/user:do:build <prd-file>` - Feature implementation from enhanced PRD
- `/user:do:continue <plan>` - Resume plan development
- `/user:do:list` - Show existing plans
- `/user:do:configure` - Manage settings
- `/user:do:status` - Show current state
- `/user:do:install` - Copy commands to current project
- `/user:do:update` - Update user-scope commands to latest version

### Project Commands (After Installation)
- `/do:plan "requirement" [--template=<name>]` - AI-powered PRD creation for project
- `/do:review <prd-file>` - Senior engineer AI review of PRD
- `/do:build <prd-file>` - Feature implementation from enhanced PRD
- `/do:continue <plan>` - Resume plan or session
- `/do:list` - Show project plans and active sessions
- `/do:configure` - Project AI questioning settings
- `/do:status` - System health and cleanup recommendations
- `/do:update` - Update commands to latest version

## Example Usage

### 🎯 AI-Powered Flow
```bash
# Start with any requirement
/do:plan "Add user profile management"

# v2 AI system will:
# 1. 🔍 Analyze your codebase (React? Django? existing auth?)
# 2. 🎯 Ask ~6-10 focused questions with context
# 3. 💬 Adapt based on your responses
# 4. 📋 Generate comprehensive PRD with assumptions
```

### ⚡ Skip Mode for Speed
```bash
# Generate with assumptions only
/do:plan "Add CRUD operations, skip questions"
/do:plan "Add user dashboard, make assumptions"
```

### 🔧 Implementation Flow
```bash
# After creating a PRD, review it with engineering guidance
/do:review user-profile-20250701-140000.md

# Senior engineer AI will:
# 1. 🔍 Review PRD and analyze technical context
# 2. 🤔 Ask architecture, security, and testing questions
# 3. 📝 Add Engineering Notes to the PRD

# Then implement the enhanced PRD
/do:build user-profile-20250701-140000.md
# 4. 🚀 Implement feature using enhanced PRD context
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
mkdir -p ~/.claude/commands/pm

# Copy files
cp .claude/commands/pm/*.md ~/.claude/commands/pm/
```

### Team Setup
```bash
# In your project directory
/user:do:install

# Commit team commands
git add .claude/commands/pm/*
git commit -m "Add Do:PE AI commands for team use"
```

## Directory Structure

After installation:
```
~/.claude/commands/
  pm/
    plan.md               # Main AI-powered PM command
    review.md             # Senior engineer AI review of PRD
    build.md              # Feature implementation from enhanced PRD
    list.md               # List plans and sessions
    continue.md           # Resume plan development
    configure.md           # AI questioning settings
    status.md             # System health dashboard
    install.md            # Project installation

# In your projects (after /user:do:install):
.claude/commands/         # Team-shared commands
.do/
  config.json              # AI questioning configuration
  plans/                  # Generated PRDs
  sessions/               # Active AI questioning sessions
  questions/              # Custom question templates
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
/user:do:configure

# Check current settings
/user:do:status
```

## Requirements

- [Claude Code CLI](https://claude.ai/code) - The AI coding assistant
- Git repository (recommended for context analysis)
- Markdown support (for PRD generation)

## Documentation

- [📖 AI Questioning Guide](docs/AI-QUESTIONING.md) - Complete v2 feature guide
- [🚀 Quick Start Examples](docs/EXAMPLES.md) - Common use cases

## Auto-Detection Feature

### 🎯 How Auto-Detection Works
When enabled, Claude Code automatically detects feature requests and suggests using `/do:plan`:

**Detected Patterns:**
- "Add [feature]" → Suggests `/do:plan "Add [feature]"`
- "Create [component]" → Suggests `/do:plan "Create [component]"`
- "Implement [system]" → Suggests `/do:plan "Implement [system]"`
- "How do I add/build [feature]?" → Suggests using PM workflow

**User Experience:**
```
You: "Add user authentication to my app"
Claude: I can help you implement user authentication! Since this is a new 
        feature request, I recommend using Do:PE AI to create 
        a detailed PRD first.
        
        Try: /do:plan "Add user authentication"
        
        Would you like to start with the PM command, or would you prefer 
        I begin coding immediately?
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