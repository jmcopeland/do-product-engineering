# Claude PM - AI Product Manager for Claude Code

Transform vague requirements into detailed, actionable PRDs through interactive AI questioning.

## Overview

Claude PM adds AI Product Manager capabilities to Claude Code via custom slash commands. It analyzes your project context, asks intelligent questions, and generates comprehensive Product Requirements Documents (PRDs) that Claude Code can execute.

## Features

- **Context Discovery** - Automatically analyzes project structure, git history, and documentation
- **Interactive Questioning** - Domain-specific question templates (auth, CRUD, UI, API)
- **Session Management** - Save progress and resume questioning sessions
- **Plan Management** - Generate structured PRDs in markdown format
- **Team Collaboration** - Share customized commands across team projects

## Quick Start

### Individual Installation
1. Copy all files from `commands/` to `~/.claude/commands/`
2. Commands are immediately available as `/user:pm*` across all projects

### Team Installation
1. Install individually first (above)
2. In your project: `/user:pm:install`
3. Commit `.claude/commands/pm*` files to share with team
4. Team gets project-scoped `/pm*` commands

## Available Commands

### User Commands (Available Everywhere)
- `/user:pm "requirement"` - Start new PRD creation
- `/user:pm:list` - Show existing plans
- `/user:pm:continue <plan>` - Resume plan development
- `/user:pm:configure` - Manage settings
- `/user:pm:status` - Show current state
- `/user:pm:install` - Copy commands to current project

### Project Commands (After Installation)
- `/pm "requirement"` - Project-specific PRD creation
- `/pm:list` - Show project plans
- `/pm:continue <plan>` - Resume project plan
- `/pm:configure` - Project settings
- `/pm:status` - Project PM status

## Example Usage

```bash
# Start requirement gathering
/user:pm "Add user authentication to my web app"

# The system will:
# 1. Analyze your project structure
# 2. Ask targeted questions about auth requirements
# 3. Generate a comprehensive PRD
# 4. Save it in .claude-pm/plans/ for future reference
```

## Installation Instructions

### Manual Installation
```bash
# Create directories
mkdir -p ~/.claude/commands/pm

# Copy files
cp commands/pm.md ~/.claude/commands/
cp commands/pm/*.md ~/.claude/commands/pm/
```

### Team Setup
```bash
# In your project directory
/user:pm:install

# Commit team commands
git add .claude/commands/pm*
git commit -m "Add Claude PM commands for team use"
```

## Directory Structure

After installation:
```
~/.claude/commands/
  pm.md                    # Main PM command
  pm/
    list.md               # List existing plans
    continue.md           # Resume plan development
    configure.md          # Settings management
    status.md             # Status overview
    install.md            # Project installation

# In your projects (after /user:pm:install):
.claude/commands/         # Team-shared commands
.claude-pm/
  config.json            # Project settings
  plans/                 # Generated PRDs
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

## Customization

### Question Templates
Edit `pm.md` to customize questions for your domain:

```markdown
**For E-commerce Features:**
- What payment methods should be supported?
- How should inventory be managed?
- What shipping options are needed?
```

### Project Settings
Customize `.claude-pm/config.json`:

```json
{
  "questioningDepth": "thorough",
  "maxQuestions": 12,
  "prdTemplate": "agile",
  "teamName": "Your Team"
}
```

## Requirements

- [Claude Code CLI](https://claude.ai/code) - The AI coding assistant
- Git repository (for context analysis)
- Markdown support (for PRD generation)

## Contributing

This tool is designed to be customized per team/project. Fork and modify the command templates to match your development workflow.

## License

MIT License - Feel free to customize and distribute.