# AI-Powered Questioning Guide

AI Product Manager v2 introduces intelligent, adaptive questioning that transforms vague requirements into detailed PRDs through conversation.

## Overview

The AI-powered questioning system combines:
- **Codebase analysis** to pre-answer questions from your existing code
- **Template-guided questions** to ensure comprehensive coverage
- **Adaptive conversation flow** that responds to your answers
- **Smart filtering** to ask only relevant questions

## How It Works

### 1. Requirement Analysis
When you run `/pm "Add user profile management"`, AI Product Manager:
- Analyzes your requirement for complexity and type
- Identifies relevant question categories (auth, CRUD, UI, API)
- Scans your codebase for existing patterns and technologies

### 2. Smart Question Selection
- Pre-answers questions from codebase analysis
- Filters questions by relevance to your specific requirement
- Prioritizes questions that can't be determined automatically
- Estimates 6-10 focused questions instead of 20-50 template questions

### 3. Conversational Flow
Questions are presented one at a time with context:

```
🗺️ Question 2 • User Authentication • Covered: requirements ✓ | Exploring: auth, data

How should users sign up for accounts? (email/username, social login, etc.)

🧠 Context: This determines the signup flow complexity and which auth libraries we'll need. Helps define the user onboarding section of the PRD.
```

### 4. User Control
You control the conversation flow:

- **Answer normally** → Continue to next logical question
- **"good to go"** → End questioning, generate PRD
- **"skip"** → Dismiss current question, move to next
- **"I don't know"** → Get options (explore, defer, use default, skip)
- **"why are you asking"** → Get detailed rationale

## Configuration Options

Configure AI questioning in `.claude-pm/config.json`:

```json
{
  "aiQuestioningOptions": {
    "useRelevanceFiltering": true,
    "questionsPerRound": 1,
    "adaptiveDepth": true,
    "includeRationale": true,
    "allowSkipQuestioning": true,
    "priorityThreshold": "medium"
  }
}
```

### Configuration Details

- **useRelevanceFiltering**: Filter out irrelevant questions (default: true)
- **questionsPerRound**: Questions per interaction (default: 1)
- **adaptiveDepth**: Adjust depth based on responses (default: true)
- **includeRationale**: Show why each question matters (default: true)
- **allowSkipQuestioning**: Enable "skip questions" mode (default: true)
- **priorityThreshold**: Minimum priority to ask ("low", "medium", "high")

## Skip Questioning Mode

For quick PRD generation, you can skip questioning entirely:

```bash
/pm "Add user authentication, skip questions"
```

or 

```bash
/pm "Add CRUD operations, make assumptions"
```

When questions are skipped, AI Product Manager:
- Analyzes your codebase thoroughly
- Uses industry best practices
- Documents all assumptions made
- Flags areas for future clarification

## Question Templates

AI questioning uses template guides in `.claude-pm/questions/`:

- **auth.md** - Authentication and user management (24 questions)
- **crud.md** - Create, read, update, delete operations (34 questions)
- **ui.md** - User interface and components (42 questions)
- **api.md** - API and integration features (48 questions)
- **general.md** - General feature development (48 questions)

These templates **guide** the AI but don't limit it. The AI can:
- Skip irrelevant template questions
- Generate new questions based on your responses
- Combine questions from multiple templates
- Create follow-up questions for complex answers

## Codebase Analysis

Before asking questions, AI Product Manager scans your project for:

### Project Structure
- Framework detection (React, Vue, Django, Laravel, etc.)
- Package managers and dependencies
- Directory structure and naming patterns

### Existing Features
- Authentication patterns and libraries
- CRUD operations and database models
- UI components and design systems
- API endpoints and integration patterns

### Technical Context
- Database setup and ORM
- Testing frameworks and patterns
- Build tools and deployment setup
- Security and performance patterns

## Session Management

AI questioning sessions are automatically saved to `.claude-pm/sessions/`:

### Session Persistence
- Auto-saves after every question/answer
- Can be resumed if interrupted: `/pm:continue [session-id]`
- Includes progress tracking and conversation history

### Session Format
```json
{
  "sessionId": "user-auth-20250701-140000",
  "requirement": "Add user authentication",
  "status": "in-progress",
  "codebaseAnalysis": {...},
  "questionQueue": [...],
  "responses": [...],
  "progress": {
    "questionsAsked": 3,
    "estimatedTotal": "6-8",
    "topicsCompleted": ["requirements"],
    "currentTopic": "auth"
  }
}
```

## Error Handling

The AI questioning system gracefully handles:

- **Missing templates**: Falls back to general questions
- **Large codebases**: Limits analysis to 30 seconds
- **Corrupted sessions**: Backs up and starts fresh
- **Permission errors**: Clear guidance on fixing access
- **Concurrent sessions**: Lets you choose which to continue

## Best Practices

### For Teams
1. **Commit templates**: Add `.claude-pm/questions/` to git for shared question sets
2. **Configure project settings**: Set `priorityThreshold` and other options in `.claude-pm/config.json`
3. **Custom templates**: Create domain-specific questions for your industry

### For Individuals
1. **Let it analyze**: Trust the codebase analysis to pre-answer questions
2. **Use control signals**: Say "good to go" when you have enough information
3. **Ask for rationale**: Use "why are you asking" to understand the purpose
4. **Skip when appropriate**: Use skip mode for routine features you understand well

## Troubleshooting

### Common Issues

**"Questions seem irrelevant"**
- Lower `priorityThreshold` to "low" for more questions
- Check if your requirement clearly states what you're building
- Use skip mode if you prefer assumption-based generation

**"Too many questions"**
- Raise `priorityThreshold` to "high" for fewer questions  
- Say "good to go" earlier in the conversation
- Enable skip mode for quick generation

**"Analysis takes too long"**
- Large codebases are limited to 30-second analysis
- Git history analysis limited to 10 recent commits
- Use `/pm:configure` to disable git analysis if needed

**"Session lost/corrupted"**
- Sessions auto-backup on corruption
- Use `/pm:status` to see session health
- Archive old sessions with cleanup recommendations

### Getting Help

- `/pm:status` - Check system health and recommendations
- `/pm:configure` - Adjust AI questioning settings
- `/pm:list` - See all sessions and their status

## Upgrading to v2.2.0+

If upgrading from earlier versions:

1. **Backup existing plans**: Copy `.claude-pm/plans/` 
2. **Update configuration**: The system now uses AI-powered questioning by default
3. **Customize templates**: Edit `.claude-pm/questions/` for your team's specific needs
4. **Configure questioning depth**: Use `questioningDepth` to control thoroughness

The AI-powered mode uses question templates as guides while providing intelligent filtering and adaptive conversation flow.