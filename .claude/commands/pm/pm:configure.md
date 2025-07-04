# PM Configure - Manage Settings

Configure PM command settings and preferences.

## Task: Configuration Management

### 1. Check Current Configuration
- Look for `.claude-pm/config.json` in current project
- Display current settings if they exist
- Show default settings if no config exists

### 2. Configuration Options

**Questioning Preferences:**
- `questioningDepth`: "brief" | "standard" | "thorough" (default: "standard")
- `autoSave`: Save progress automatically (default: true)

**AI Questioning Options:**
- `aiQuestioningOptions.useRelevanceFiltering`: AI filters questions by relevance (default: true)
- `aiQuestioningOptions.questionsPerRound`: Questions per round (default: 1)
- `aiQuestioningOptions.adaptiveDepth`: Adjust depth based on responses (default: true)
- `aiQuestioningOptions.includeRationale`: Show why each question is asked (default: true)
- `aiQuestioningOptions.allowSkipQuestioning`: Allow skip to assumptions (default: true)
- `aiQuestioningOptions.priorityThreshold`: "low" | "medium" | "high" - minimum priority to ask (default: "medium")

**Output Preferences:**
- `prdTemplate`: "standard" | "agile" | "technical" (default: "standard")
- `complexityScale`: 1-5 or 1-10 scale (default: 5)
- `includeImplementationNotes`: Include technical details (default: true)

**Project Context:**
- `analyzeGitHistory`: Include git commit analysis (default: true)
- `maxGitCommits`: Number of recent commits to analyze (default: 10)
- `contextDepth`: "surface" | "standard" | "deep" (default: "standard")

**Team Settings (for shared configs):**
- `teamName`: Team identifier
- `defaultReviewer`: Default reviewer for PRDs
- `customQuestionTemplates`: Path to custom question sets

### 3. Interactive Configuration
Present current settings and allow updates:

```
## Current PM Configuration

**Questioning:**
- Depth: [current value]
- Auto-save: [current value]

**AI Questioning:**
- Use Relevance Filtering: [current value]
- Questions Per Round: [current value]
- Adaptive Depth: [current value]
- Include Rationale: [current value]
- Allow Skip: [current value]
- Priority Threshold: [current value]

**Output:**
- PRD Template: [current value]
- Complexity Scale: [current value]
- Implementation Notes: [current value]

**Project Context:**
- Git History Analysis: [current value]
- Git Commits to Analyze: [current value]
- Context Depth: [current value]

Which settings would you like to modify?
```

### 4. Save Configuration
- Create `.claude-pm/` directory if needed
- Write updated config to `.claude-pm/config.json`
- Validate configuration values
- Confirm changes with user

### 5. Team Configuration
If this is a shared project configuration:
- Explain that changes affect all team members
- Suggest adding `.claude-pm/config.json` to git for sharing
- Provide option to create user-specific overrides

Begin configuration process now.