# Do Status - Show Current Session State

Display the current state of PM sessions and plans.

## Task: Status Overview

### 1. Project Status
Check and display:
- Current project PM configuration and mode
- Number of existing plans and active sessions
- Most recent plan/session activity
- .do directory structure

### 2. Session Status
Show current AI questioning session information:
- Active sessions count and details
- Session health (recent, valid, corrupted)
- Last session worked on
- Average session completion rate

### 3. Plan Summary
Provide overview of all plans:
- Total number of plans
- Plans by status (Ready, In Progress, Needs Review, Completed)
- Plans by complexity level (1-5 scale)
- Most recently created/modified plans

### 4. Configuration Status
Display current settings:
- Active configuration source (project vs user defaults)
- AI questioning options and settings
- Template availability and health
- Any configuration issues or recommendations

### 5. System Health
Check PM system health:
- Directory structure integrity (.do/sessions/, /questions/, /plans/)
- Template file availability and validity
- Session file integrity
- File permissions
- Any corrupted or unreadable plans/sessions

### 6. AI Questioning Statistics
- Average questions asked per session
- Most common question categories used
- Session completion vs abandonment rate
- Question template usage statistics

### 7. Cleanup Recommendations
Show actionable items for maintaining system health:
- **Old sessions** that can be archived (> 7 days)
- **Stale sessions** that may need cleanup (> 24 hours, no activity)
- **Large session directory** that may need archival
- **Missing template updates** if templates are outdated
- **Configuration drift** if settings seem suboptimal

**Cleanup suggestions format:**
```
### Recommended Actions
⚠️  3 old sessions ready for archival (saving 45KB)
🧹 1 stale session from 3 days ago - likely abandoned
💾 Session directory: 12 files, 128KB (consider archival)
✅ All templates up to date
⚙️  Consider increasing priorityThreshold to "high" (current: low)
```

### Display Format:
```
## PM Status Dashboard

**Project:** [Current directory]
**Configuration:** [Source and key settings]

### Plans Overview
- Total Plans: [count]
- Ready for Development: [count]
- In Progress: [count]
- Completed: [count]

### Recent Activity
- Last Plan: [name] ([date])
- Last Session: [date]

### System Health
- ✅ Directory structure intact
- ✅ All plans readable
- ⚠️  [Any issues found]

### Quick Actions
- `/pm "[requirement]"` - Create new plan
- `/do:plan` - View all plans
- `/do:configure` - Update settings
```

Begin status check now.