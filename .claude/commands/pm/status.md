# PM Status - Show Current Session State

Display the current state of PM sessions and plans.

## Task: Status Overview

### 1. Project Status
Check and display:
- Current project PM configuration
- Number of existing plans
- Most recent plan activity
- .claude-pm directory structure

### 2. Session Status
Show current session information:
- Any active/incomplete questioning sessions
- Last plan worked on
- Recent PM command usage

### 3. Plan Summary
Provide overview of all plans:
- Total number of plans
- Plans by status (Ready, In Progress, Needs Review)
- Plans by complexity level
- Most recently created/modified plans

### 4. Configuration Status
Display current settings:
- Active configuration source (project vs user defaults)
- Key configuration values
- Any configuration issues or recommendations

### 5. System Status
Check PM system health:
- Directory structure integrity
- File permissions
- Any corrupted or unreadable plans

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
- `/user:pm "[requirement]"` - Create new plan
- `/user:pm:list` - View all plans
- `/user:pm:configure` - Update settings
```

Begin status check now.