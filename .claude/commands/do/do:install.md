# PM Install - Copy PM Commands to Project

Copy PM commands from user directory to current project for team sharing and customization. Optionally enable auto-detection for feature requests.

## Task: Install PM Commands to Project

### 1. Pre-Installation Checks
- Verify we're in a valid project directory (has .git or other project indicators)
- Check if `.claude/commands/` directory exists, create if needed
- Check if PM commands already exist in project `.claude/commands/do/`, create directory if necessary

### 2. File Copy Operations
Copy these files from `~/.claude/commands/do/` to `./.claude/commands/do/`:
- `pm:plan.md` → `pm:plan.md`
- `pm:review.md` → `pm:review.md`
- `pm:build.md` → `pm:build.md`
- `pm:list.md` → `pm:list.md`
- `pm:continue.md` → `pm:continue.md`
- `pm:configure.md` → `pm:configure.md`
- `pm:status.md` → `pm:status.md`
- `pm:install.md` → `pm:install.md`
- `pm:update.md` → `pm:update.md`

### 3. Handle Existing Files
If PM commands already exist in the project:
- Show what files would be overwritten
- Ask user for confirmation:
  - "overwrite" - Replace all existing files
  - "skip" - Skip files that already exist
  - "diff" - Show differences between versions
  - "cancel" - Abort installation

### 4. Post-Installation Setup
After copying files:
- Create complete `.do/` directory structure:
  - `.do/config.json` - PM configuration
  - `.do/plans/` - Generated PRDs
  - `.do/sessions/` - Active AI questioning sessions
  - `.do/questions/` - AI question templates
- Copy question templates from user directory if they exist
- Create default config with AI-powered questioning enabled
- **Auto-Detection Setup**: If `--with-auto-detection` flag detected or user confirms:
  - Check if CLAUDE.md exists in current directory
  - If not, copy from AI Product Manager repository
  - Add auto-detection guidance for feature request recognition

### 5. Team Setup Instructions
Provide guidance for team usage:
```
## PM Commands Installed Successfully!

### Project Commands Available:
- `/do:plan "[requirement]"` - Create new PRD (project-scoped)
- `/do:review <prd-file>` - Senior engineering PRD review
- `/do:build <prd-file>` - Feature implementation from enhanced PRD
- `/do:list` - Show project plans
- `/do:continue <plan>` - Resume plan development
- `/do:configure` - Manage project settings
- `/do:status` - Show project PM status

### Team Setup:
1. Commit `.claude/commands/do/do:*` files to share with team
2. Add `.do/config.json` to git for shared settings
3. Commit `CLAUDE.md` for auto-detection (if enabled)
4. Consider adding `.do/plans/` to .gitignore if PRDs are sensitive

### Customization:
- Edit `.claude/commands/do/do:plan.md` to customize AI questioning flow
- Modify `.do/config.json` for project-specific settings
- Add custom question templates in `.do/questions/`
- Configure AI questioning behavior (depth, filtering, skip options)

### Fallback:
- User commands (`/user:pm*`) remain available as fallback
- Project commands take precedence when both exist
```

### 6. Error Handling
Handle common issues:
- No write permissions to `.claude/` directory
- Source files missing or corrupted
- Invalid project directory
- Git conflicts with existing files

## Begin Installation

1. **Verify Environment**
   - Check if we're in a project directory
   - Look for .git, package.json, or other project indicators

2. **Create Directory Structure**
   ```bash
   mkdir -p .claude/commands/pm
   mkdir -p .do/{plans,sessions,questions}
   ```

3. **Copy Command Files**
   ```bash
   cp ~/.claude/commands/do/do:*.md .claude/commands/do/
   ```

4. **Copy Question Templates** (for AI-powered mode)
   ```bash
   # Copy question templates if they exist in user directory
   if [ -d ~/.do/questions ]; then
     cp ~/.do/questions/*.md .do/questions/
   else
     echo "Note: Question templates not found in user directory"
     echo "AI questioning will use built-in templates" 
   fi
   ```

5. **Create Default Config** (AI-powered)
   ```json
   {
     "version": "<current version from VERSION file>",
     "updateRepository": "jmcopeland/ai-product-manager",
     "questioningDepth": "standard",
     "autoSave": true,
     "aiQuestioningOptions": {
       "useRelevanceFiltering": true,
       "questionsPerRound": 1,
       "adaptiveDepth": true,
       "includeRationale": true,
       "allowSkipQuestioning": true,
       "priorityThreshold": "medium"
     },
     "prdTemplate": "standard",
     "complexityScale": 5,
     "includeImplementationNotes": true,
     "analyzeGitHistory": true,
     "maxGitCommits": 10,
     "contextDepth": "standard"
   }
   ```

Begin installation process now.