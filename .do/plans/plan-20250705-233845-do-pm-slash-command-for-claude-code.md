# PRD: Do PM Slash Command for Claude Code

**Created:** 2025-06-30  
**Complexity Estimate:** 4/5  
**Status:** ✅ Completed
**Last Updated:** 2025-06-30

## Context

Claude Code currently allows developers to delegate coding tasks but lacks a structured way to transform vague business requirements into detailed, actionable development plans. This tool will act as an AI Product Manager that gathers context, asks clarifying questions, and produces comprehensive PRDs that Claude Code can execute.

### Related Existing Features
- Claude Code's existing slash command infrastructure
- File reading/writing capabilities in Claude Code environment
- Claude's natural language processing for requirement analysis

## User Stories

**As a developer**, I want to give Claude Code a rough feature idea and have it ask me the right questions, so that I can avoid building the wrong thing or missing important edge cases.

**As a developer**, I want my requirements gathering sessions to be saved and resumable, so that I can iterate on complex features over multiple sessions.

**As a developer**, I want Claude Code to automatically understand my project context, so that the questions and suggestions are relevant to my existing codebase.

**As a developer**, I want a consistent output format from requirements gathering, so that Claude Code can reliably execute the resulting plans.

## Core Requirements

### Context Discovery
- Automatically analyze project structure (package.json, file tree, README files)
- Scan recent git commits for feature patterns and project conventions
- Search for relevant GitHub/Linear issues with user confirmation
- Extract context from existing documentation and markdown files
- Present context summary to user for verification

### Interactive Questioning
- Ask 5-8 core questions based on requirement type and project context
- Branch into follow-up questions based on user responses
- Recognize completion signals ("good to go", "proceed", "continue")
- Handle "I don't know" responses with smart defaults and TODO marking
- Support interruption and resumption of questioning sessions

### Plan Management
- Create markdown files in `.claude-pm/plans/` directory
- Auto-generate timestamped filenames (e.g., `user-auth-20250630-143022.md`)
- List existing plans with brief summaries
- Allow continuation of incomplete or existing plans
- Detect when new requirements relate to existing plans

### Configuration
- Project-level config stored in `.claude-pm/config.json`
- Configurable questioning depth and session preferences
- `/pm:configure` command for easy config updates

### Output Generation
- Structured markdown PRD with consistent sections
- Include complexity estimates (1-5 scale)
- Technical implementation notes for Claude Code
- Clear acceptance criteria and success metrics
- Unresolved TODOs section

## Acceptance Criteria

**Context Discovery**
- [x] Analyzes project structure and extracts relevant technical context
- [x] ~~Finds and presents related issues/PRs for user confirmation~~ (moved to v2)
- [x] Summarizes existing project patterns and conventions
- [x] Identifies potentially affected files and components

**Question Flow**
- [x] Asks relevant questions based on requirement type (auth, CRUD, UI, etc.)
- [x] Branches appropriately based on user responses
- [x] Recognizes natural completion signals from user
- [x] Handles unknown answers with defaults and TODO tracking
- [x] Maintains conversation context throughout session

**Session Management**
- [x] Automatically saves session state during questioning
- [x] ~~Prompts user to continue interrupted sessions on restart~~ (manual via `/continue`)
- [x] Allows manual session continuation via `/pm:continue`
- [x] Prevents data loss during command interruption

**Plan Output**
- [x] Generates consistent, well-structured markdown PRDs
- [x] Includes all sections required for Claude Code execution
- [x] Provides realistic complexity estimates
- [x] Contains clear, testable acceptance criteria

**Command Interface**
- [x] `/pm "<requirement>"` starts new requirement gathering
- [x] `/pm:list` shows existing plans with summaries
- [x] `/pm:continue <plan>` resumes specific plan
- [x] `/pm:configure` manages settings
- [x] `/pm:status` shows current session state
- [x] `/pm:install` installs commands to project (additional feature)

## Implementation Notes

### Implementation Architecture (As Built)
- **Command Structure:** Markdown-based slash commands (no JavaScript required!)
  - `.claude/commands/pm.md` - Main command with questioning logic
  - `.claude/commands/pm/list.md` - List existing plans
  - `.claude/commands/pm/continue.md` - Resume plan development
  - `.claude/commands/pm/configure.md` - Settings management
  - `.claude/commands/pm/status.md` - Status overview
  - `.claude/commands/pm/install.md` - Project installation

### Technical Considerations
- Use Claude's conversation memory for session continuity
- Implement file-based persistence for cross-session data
- Create modular question templates for different feature types
- Build relevance scoring for context discovery
- Design extensible architecture for v2 enhancements

### Integration Points
- Leverage existing Claude Code file system access
- Utilize Claude's natural language capabilities for context analysis
- Hook into git command execution for history analysis
- Interface with project management APIs (future enhancement)

### Performance Requirements
- Context analysis should complete within 10-15 seconds
- Question flow should feel conversational, not mechanical
- Plan generation should be near-instantaneous
- File operations should be atomic to prevent corruption

## Success Metrics

**Immediate (MVP)**
- Successfully generates actionable PRDs from vague requirements
- Reduces back-and-forth between developer and Claude Code during implementation
- Identifies 80%+ of core requirements through questioning
- Produces plans that Claude Code can execute without clarification

**Future Iterations**
- Learns from successful implementations to improve questioning
- Reduces overall feature development time by 30%+
- Achieves high user satisfaction scores for requirement clarity

## TODOs

- **Question Templates:** Define specific question sets for common patterns (auth, CRUD, API integration, UI components)
- **Relevance Scoring:** Implement algorithm for ranking context relevance
- **Error Handling:** Define behavior for corrupted sessions or invalid plan files
- **Testing Strategy:** Create test cases for different requirement types and project structures

---

## Implementation Summary

**Completion Date:** 2025-06-30

### What Was Built
✅ **Full PM Command System** - Working slash commands with all planned functionality  
✅ **Markdown-Based Architecture** - Simpler than originally planned (no JavaScript needed)  
✅ **Dual Installation Model** - User-scoped and project-scoped commands  
✅ **File-Based Persistence** - `.claude-pm/` directory for plans and configuration  
✅ **GitHub Distribution** - Published to https://github.com/jmcopeland/claude-pm

### Key Learnings
1. **Claude Code's slash command system is powerful** - Markdown files can handle complex logic
2. **Simpler is better** - No need for JavaScript when Claude's NLP handles the complexity
3. **Command namespacing works well** - `/pm:list` syntax provides clean organization
4. **Context matters** - Commands can be contextual (`/list`) or explicit (`/pm:list`)

### Next Steps
- Create v2 PRD for enhancements and additional features
- Gather user feedback from initial release
- Consider integration with project management tools
- Explore learning from successful PRDs to improve questioning

---

*This PRD has been updated to reflect the successful implementation of Claude PM v1.0*