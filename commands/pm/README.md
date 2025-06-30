# Claude PM Commands - Team Customization Guide

This directory contains the AI Product Manager slash commands for Claude Code.

## Quick Start

### For Individual Use
Commands are automatically available as `/user:pm*` across all projects.

### For Team Use
1. **Install to project:** `/user:pm:install`
2. **Commit to git:** Add `.claude/commands/pm*` files
3. **Share config:** Commit `.claude-pm/config.json` for team settings

## Available Commands

- **`/pm "requirement"`** - Start new PRD creation
- **`/pm:list`** - Show existing plans  
- **`/pm:continue <plan>`** - Resume plan development
- **`/pm:configure`** - Manage settings
- **`/pm:status`** - Show current state
- **`/pm:install`** - Copy commands to project (user-scoped only)

## Customization Examples

### Custom Question Templates
Edit `pm.md` to add domain-specific questions:

```markdown
**For E-commerce Features:**
- What payment methods should be supported?
- How should inventory be managed?
- What shipping options are needed?
- How should we handle returns/refunds?
```

### Project-Specific Settings
Customize `.claude-pm/config.json`:

```json
{
  "questioningDepth": "thorough",
  "maxQuestions": 12,
  "prdTemplate": "agile",
  "teamName": "Frontend Team",
  "customQuestionTemplates": {
    "react": "questions/react-component.md",
    "api": "questions/api-integration.md"
  }
}
```

### Team Workflows
- **Planning Sprints:** Use `/pm` for backlog grooming
- **Feature Specs:** Generate PRDs before implementation
- **Documentation:** Keep plans in `.claude-pm/plans/` as living docs

## File Structure

```
.claude/
  commands/
    pm.md              # Main PM command
    pm/
      list.md         # List existing plans
      continue.md     # Resume plan development  
      configure.md    # Settings management
      status.md       # Current state overview
      install.md      # Project installation
      README.md       # This file

.claude-pm/
  config.json         # Project settings
  plans/             # Generated PRDs
    feature-name-YYYYMMDD-HHMMSS.md
```

## Best Practices

1. **Regular Updates:** Pull latest PM commands periodically
2. **Version Control:** Commit customizations but not sensitive plans
3. **Team Training:** Share common question patterns and templates
4. **Feedback Loop:** Iterate on questions based on implementation experience