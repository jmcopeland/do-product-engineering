# Migration Guide: v1 to v2

This guide helps you upgrade from AI Product Manager v1 (template-based) to v2 (AI-powered questioning).

## Overview of Changes

### v1 (Template Mode)
- Fixed question sequences from templates
- Asked all template questions (20-50 per template)
- No codebase pre-analysis
- Simple linear flow

### v2 (AI-Powered Mode)
- Intelligent question selection based on codebase analysis
- Adaptive conversation flow (6-10 focused questions)
- Pre-answers questions from existing code
- User control signals and skip options

## Migration Steps

### 1. Backup Existing Data

Before upgrading, backup your existing plans:

```bash
# Backup existing plans
cp -r .claude-pm/plans/ .claude-pm/plans-backup/
```

### 2. Update Installation

```bash
# Update from git
git pull origin main

# Reinstall commands
./install.sh

# Or manually update
cp commands/pm.md ~/.claude/commands/
cp commands/pm/*.md ~/.claude/commands/pm/
```

### 3. Update Configuration

Your existing `.claude-pm/config.json` will work but won't have AI features. Update it:

**Old v1 config:**
```json
{
  "questioningDepth": "standard",
  "maxQuestions": 8,
  "autoSave": true,
  "prdTemplate": "standard"
}
```

**New v2 config:**
```json
{
  "questioningDepth": "standard",
  "maxQuestions": 8,
  "autoSave": true,
  "questioningMode": "ai-powered",
  "aiQuestioningOptions": {
    "useRelevanceFiltering": true,
    "questionsPerRound": 1,
    "adaptiveDepth": true,
    "includeRationale": true,
    "allowSkipQuestioning": true,
    "priorityThreshold": "medium"
  },
  "prdTemplate": "standard"
}
```

### 4. Create New Directory Structure

v2 adds new directories:

```bash
mkdir -p .claude-pm/{sessions,questions}
```

### 5. Optional: Copy Question Templates

If you want to customize AI questioning, copy the default templates:

```bash
# Copy from the repository
cp .claude-pm/questions/*.md your-project/.claude-pm/questions/
```

## Compatibility

### Backward Compatibility

✅ **Your existing plans remain unchanged**
- All `.claude-pm/plans/*.md` files work exactly the same
- `/pm:list` shows both old and new plans
- `/pm:continue` works with existing plans

✅ **All commands work the same**
- Same command syntax: `/pm "requirement"`
- Same output format and file structure
- Same team sharing and installation process

### Breaking Changes

❌ **None!** v2 is fully backward compatible.

## Migration Strategies

### Strategy 1: Gradual Migration (Recommended)

Keep using template mode for familiar workflows, try AI mode for new features:

```json
{
  "questioningMode": "template"
}
```

Try AI mode:
```bash
/pm:configure  # Change to "ai-powered"
/pm "Add new feature X"  # Test AI questioning
```

### Strategy 2: Immediate Migration

Switch to AI mode right away:

```json
{
  "questioningMode": "ai-powered"
}
```

All new PRDs will use AI questioning.

### Strategy 3: Hybrid Mode

Use both modes depending on the situation:

```bash
# For complex new features - use AI mode
/pm:configure  # Set to "ai-powered"
/pm "Add real-time collaboration"

# For simple, well-understood features - use template mode
/pm:configure  # Set to "template"  
/pm "Add delete button to posts"
```

## New v2 Features to Try

### 1. Codebase Analysis

v2 automatically analyzes your code before asking questions:

```bash
/pm "Add user authentication"
# Will detect: React app, existing auth patterns, database setup
```

### 2. Skip Questioning

For features you understand well:

```bash
/pm "Add CRUD operations for posts, skip questions"
/pm "Add user profile page, make assumptions"
```

### 3. Smart Question Filtering

AI asks only relevant questions:
- For auth feature: focuses on auth + user management questions
- For CRUD feature: focuses on data model + API questions
- Skips irrelevant template questions automatically

### 4. User Control Signals

During questioning:
- Say **"good to go"** when you have enough information
- Say **"skip"** to dismiss irrelevant questions  
- Say **"why are you asking"** to understand question purpose
- Say **"I don't know"** to get options (explore, defer, default, skip)

### 5. Session Management

AI questioning sessions are saved and resumable:

```bash
# If interrupted
/pm:continue user-auth-20250701-140000

# Check session status
/pm:status
```

## Troubleshooting Migration

### Common Issues

**"AI mode asks too many questions"**
```json
{
  "priorityThreshold": "high"  // Ask fewer, higher-priority questions
}
```

**"AI mode asks too few questions"**
```json
{
  "priorityThreshold": "low",   // Ask more detailed questions
  "useRelevanceFiltering": false  // Disable filtering
}
```

**"Want the old template behavior"**
```json
{
  "questioningMode": "template"  // Use v1 template mode
}
```

**"Analysis takes too long"**
```json
{
  "analyzeGitHistory": false,  // Disable git analysis
  "contextDepth": "surface"    // Faster analysis
}
```

### Performance Comparison

| Feature | v1 Template | v2 AI-Powered |
|---------|-------------|---------------|
| Questions asked | 20-50 | 6-10 |
| Setup time | Instant | 5-15 seconds (analysis) |
| Relevance | Fixed template | Adapted to project |
| User control | Linear flow | Full conversation control |
| Codebase awareness | None | Full analysis |

## Rollback Instructions

If you need to rollback to v1 behavior:

### 1. Temporary Rollback
```json
{
  "questioningMode": "template"
}
```

### 2. Full Rollback
```bash
# Restore v1 commands from backup
git checkout v1-branch
cp commands/pm.md ~/.claude/commands/
cp commands/pm/*.md ~/.claude/commands/pm/
```

## Team Migration

### For Team Leaders

1. **Test first**: Try v2 in a personal project before team rollout
2. **Gradual rollout**: Start with hybrid mode for the team
3. **Customize templates**: Edit `.claude-pm/questions/` for your domain
4. **Team training**: Share the [AI Questioning Guide](AI-QUESTIONING.md)

### Migration Timeline

**Week 1**: Install v2, test in template mode
**Week 2**: Try AI mode for new features  
**Week 3**: Customize question templates for your domain
**Week 4**: Switch team default to AI mode

### Team Configuration

Create shared team config:

```json
{
  "questioningMode": "ai-powered",
  "aiQuestioningOptions": {
    "priorityThreshold": "medium",
    "allowSkipQuestioning": true
  },
  "teamName": "Your Team",
  "customDomain": "fintech"  // Custom question focus
}
```

## Getting Help

- **Documentation**: [AI Questioning Guide](AI-QUESTIONING.md)
- **Status check**: `/pm:status` shows system health
- **Configuration**: `/pm:configure` for interactive setup
- **Issues**: [GitHub Issues](https://github.com/jmcopeland/ai-product-manager/issues)

## FAQ

### Will my existing PRDs still work?
✅ Yes, all existing PRDs remain unchanged and fully functional.

### Do I need to recreate my project setup?
❌ No, v2 uses the same directory structure with additions.

### Can I use both modes?
✅ Yes, you can switch between template and AI modes anytime.

### What if I don't like AI mode?
✅ Set `"questioningMode": "template"` to use v1 behavior.

### Are the commands different?
❌ No, all commands work exactly the same way.

### Will this break my team workflow?  
❌ No, v2 is designed for zero-disruption migration.