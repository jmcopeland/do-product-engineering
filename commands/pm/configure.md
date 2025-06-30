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
- `maxQuestions`: Number of questions to ask (default: 8)
- `autoSave`: Save progress automatically (default: true)

**Output Preferences:**
- `prdTemplate`: "standard" | "agile" | "technical" (default: "standard")
- `complexityScale`: 1-5 or 1-10 scale (default: 1-5)
- `includeImplementationNotes`: Include technical details (default: true)

**Project Context:**
- `analyzeGitHistory`: Include git commit analysis (default: true)
- `maxGitCommits`: Number of recent commits to analyze (default: 20)
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
- Max Questions: [current value]
- Auto-save: [current value]

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