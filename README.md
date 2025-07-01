# AI Product Manager for Claude Code

🤖 **v2.1 AI-Powered Questioning + Performance** - Transform vague requirements into detailed, actionable PRDs through intelligent conversation with lightning-fast performance.

[![Version](https://img.shields.io/badge/version-2.1-blue.svg)](https://github.com/jmcopeland/ai-product-manager)
[![Claude Code](https://img.shields.io/badge/Claude%20Code-Compatible-green.svg)](https://claude.ai/code)
[![License](https://img.shields.io/badge/license-MIT-green.svg)](LICENSE)

## Overview

AI Product Manager adds intelligent product management capabilities to Claude Code via custom slash commands. It analyzes your project context, asks intelligent questions, and generates comprehensive Product Requirements Documents (PRDs) that Claude Code can execute.

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
- **Team Collaboration** - Share customized commands and question templates

### ⚡ Performance (v2.1)
- **Sub-Second Listing** - `/pm:list` responds in <1 second (was 3+ minutes)
- **Smart Caching** - Automatic cache invalidation when plans are modified
- **Native Display** - Beautiful output directly in Claude Code interface
- **Zero Friction** - No user prompts or permission requests required

## Quick Start

### 🚀 Automatic Installation
```bash
# Clone and install
git clone https://github.com/jmcopeland/ai-product-manager.git
cd ai-product-manager
./install.sh

# Start using immediately
/user:pm "Add user authentication to my app"
```

### 👥 Team Installation
```bash
# After individual install, add to your project:
/user:pm:install

# Commit for team sharing
git add .claude/commands/pm*
git commit -m "Add AI Product Manager v2 for team"
```

## Available Commands

### User Commands (Available Everywhere)
- `/user:pm "requirement"` - Start new PRD creation
- `/user:pm:list` - Show existing plans
- `/user:pm:continue <plan>` - Resume plan development
- `/user:pm:configure` - Manage settings
- `/user:pm:status` - Show current state
- `/user:pm:install` - Copy commands to current project

### Project Commands (After Installation)
- `/pm "requirement"` - AI-powered PRD creation for project
- `/pm:list` - Show project plans and active sessions
- `/pm:continue <plan>` - Resume plan or session
- `/pm:configure` - Project AI questioning settings
- `/pm:status` - System health and cleanup recommendations

## Example Usage

### 🎯 AI-Powered Flow
```bash
# Start with any requirement
/user:pm "Add user profile management"

# v2 AI system will:
# 1. 🔍 Analyze your codebase (React? Django? existing auth?)
# 2. 🎯 Ask ~6-10 focused questions with context
# 3. 💬 Adapt based on your responses
# 4. 📋 Generate comprehensive PRD with assumptions
```

### ⚡ Skip Mode for Speed
```bash
# Generate with assumptions only
/user:pm "Add CRUD operations, skip questions"
/user:pm "Add user dashboard, make assumptions"
```

### 🔄 Session Management
```bash
# Resume if interrupted
/user:pm:continue user-auth-20250701-140000

# Check status and cleanup
/user:pm:status
/user:pm:list
```

## Installation Instructions

### Manual Installation
```bash
# Create directories
mkdir -p ~/.claude/commands/pm

# Copy files
cp .claude/commands/pm.md ~/.claude/commands/
cp .claude/commands/pm/*.md ~/.claude/commands/pm/
```

### Team Setup
```bash
# In your project directory
/user:pm:install

# Commit team commands
git add .claude/commands/pm*
git commit -m "Add AI Product Manager commands for team use"
```

## Directory Structure

After installation:
```
~/.claude/commands/
  pm.md                    # Main AI-powered PM command
  pm/
    list.md               # List plans and sessions
    continue.md           # Resume plan development
    configure.md          # AI questioning settings
    status.md             # System health dashboard
    install.md            # Project installation

# In your projects (after /user:pm:install):
.claude/commands/         # Team-shared commands
.claude-pm/
  config.json            # AI questioning configuration
  plans/                 # Generated PRDs
  sessions/              # Active AI questioning sessions
  questions/             # Custom question templates
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
Configure in `.claude-pm/config.json`:

```json
{
  "questioningMode": "ai-powered",
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
Create domain-specific templates in `.claude-pm/questions/`:

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
/user:pm:configure

# Check current settings
/user:pm:status
```

## Requirements

- [Claude Code CLI](https://claude.ai/code) - The AI coding assistant
- Git repository (recommended for context analysis)
- Markdown support (for PRD generation)

## Documentation

- [📖 AI Questioning Guide](docs/AI-QUESTIONING.md) - Complete v2 feature guide
- [🔄 Migration Guide](docs/MIGRATION.md) - Upgrading from v1
- [🚀 Quick Start Examples](docs/EXAMPLES.md) - Common use cases

## What's New in v2

### 🧠 AI-Powered Questioning
- **Smart pre-answering** from codebase analysis
- **Relevance filtering** - no more irrelevant questions
- **Adaptive conversation** that responds to your expertise level
- **Skip mode** for quick PRD generation with assumptions

### 🎯 Better User Experience
- **One question at a time** with clear rationale
- **Progress indicators** by topic, not rigid question counts
- **User control signals** - "good to go", "skip", "explain why"
- **Session auto-save** and recovery

### ⚡ Performance Improvements
- **Faster codebase analysis** with smart timeouts
- **Targeted searches** for relevant patterns only
- **Session management** for handling interruptions

## Upgrading from v1

Existing v1 commands work unchanged. v2 adds AI-powered mode as the new default.

```bash
# Update your installation
git pull origin main
./install.sh

# Try AI mode
/user:pm "Add feature X"

# Or keep template mode
/user:pm:configure  # Set questioningMode: "template"
```

## Contributing

This tool is designed to be customized per team/project. Fork and modify the command templates to match your development workflow.

See [CONTRIBUTING.md](CONTRIBUTING.md) for development setup and guidelines.

## License

MIT License - Feel free to customize and distribute.