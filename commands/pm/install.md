# PM Install - Copy PM Commands to Project

Copy PM commands from user directory to current project for team sharing and customization.

## Task: Install PM Commands to Project

### 1. Pre-Installation Checks
- Verify we're in a valid project directory (has .git or other project indicators)
- Check if `.claude/commands/` directory exists, create if needed
- Check if PM commands already exist in project

### 2. File Copy Operations
Copy these files from `~/.claude/commands/` to `./.claude/commands/`:
- `pm.md` → `pm.md`
- `pm/list.md` → `pm/list.md`
- `pm/continue.md` → `pm/continue.md`
- `pm/configure.md` → `pm/configure.md`
- `pm/status.md` → `pm/status.md`
- `pm/install.md` → `pm/install.md`

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
- Create `.claude-pm/` directory structure if it doesn't exist
- Create default `.claude-pm/config.json` if it doesn't exist
- Add `.claude-pm/plans/` directory for storing PRDs

### 5. Team Setup Instructions
Provide guidance for team usage:
```
## PM Commands Installed Successfully!

### Project Commands Available:
- `/pm "[requirement]"` - Create new PRD (project-scoped)
- `/pm:list` - Show project plans
- `/pm:continue <plan>` - Resume plan development
- `/pm:configure` - Manage project settings
- `/pm:status` - Show project PM status

### Team Setup:
1. Commit `.claude/commands/pm*` files to share with team
2. Add `.claude-pm/config.json` to git for shared settings
3. Consider adding `.claude-pm/plans/` to .gitignore if PRDs are sensitive

### Customization:
- Edit `.claude/commands/pm.md` to customize questioning templates
- Modify `.claude-pm/config.json` for project-specific settings
- Create domain-specific question templates in `.claude/commands/pm/`

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
   mkdir -p .claude-pm/plans
   ```

3. **Copy Files**
   ```bash
   cp ~/.claude/commands/pm.md .claude/commands/
   cp ~/.claude/commands/pm/*.md .claude/commands/pm/
   ```

4. **Create Default Config**
   ```json
   {
     "questioningDepth": "standard",
     "maxQuestions": 8,
     "autoSave": true,
     "prdTemplate": "standard",
     "complexityScale": 5,
     "includeImplementationNotes": true,
     "analyzeGitHistory": true,
     "maxGitCommits": 20,
     "contextDepth": "standard"
   }
   ```

Begin installation process now.