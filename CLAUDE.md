# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

Claude PM is an AI Product Manager extension for Claude Code that transforms vague business requirements into detailed, actionable PRDs through interactive questioning. It operates entirely through Claude Code's markdown-based slash command system.

## Architecture

**Command-based Architecture**: The system is built as modular slash commands stored in markdown files:
- `commands/pm.md` - Main PM command with interactive questioning logic
- `commands/pm/*.md` - Subcommands for specific functionality (list, continue, configure, status, install)

**Dual Installation Model**: 
- User-scoped commands (`/user:pm*`) installed to `~/.claude/commands/` work across all projects
- Project-scoped commands (`/pm*`) installed via `/user:pm:install` enable team sharing

**File-based State Management**: Uses `.claude-pm/` directory structure:
- `config.json` - Project settings and preferences
- `plans/` - Generated PRDs with timestamped filenames

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
/user:pm "Add user authentication to my web app"

# List existing plans
/user:pm:list

# Resume interrupted session
/user:pm:continue <plan-filename>

# Configure settings
/user:pm:configure

# Check current status
/user:pm:status
```

## Key Implementation Details

**Question Templates**: The main `pm.md` command contains domain-specific question sets:
- Authentication/User Management
- CRUD Operations  
- UI Components
- API Integration

**Context Discovery Process**: Each session begins by analyzing:
- Project structure (package.json, README, file tree)
- Recent git commits for patterns
- Existing documentation and conventions
- Related components or features

**PRD Generation**: Follows structured format with sections:
- Context, User Stories, Core Requirements
- Acceptance Criteria, Implementation Notes
- Success Metrics, TODOs

**Session Persistence**: Progress automatically saved during questioning to handle interruptions and enable resumption.

## File Structure

```
commands/
├── pm.md              # Main command with questioning logic
└── pm/
    ├── list.md        # Show existing plans
    ├── continue.md    # Resume plan development
    ├── configure.md   # Settings management
    ├── status.md      # Status overview
    ├── install.md     # Project installation
    └── README.md      # Team customization guide
```

Generated project structure:
```
.claude-pm/
├── config.json       # Project configuration
└── plans/            # Generated PRDs
    └── [feature-name]-[timestamp].md
```

## Customization

**Team Customization**: Teams can override question templates by editing `.claude/commands/pm.md` in their project.

**Configuration Options**: Modify `.claude-pm/config.json`:
- `questioningDepth`: "brief" | "standard" | "thorough"
- `maxQuestions`: Number of questions to ask
- `prdTemplate`: "standard" | "agile" | "technical"
- `analyzeGitHistory`: Include git commit analysis

**Domain-specific Templates**: Add custom question sets for specific industries or project types by modifying the question templates in `pm.md`.