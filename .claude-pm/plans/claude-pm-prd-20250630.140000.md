# Claude Code PM Slash Command

**Created:** 2025-06-30  
**Complexity Estimate:** 4/5  
**Status:** Ready for Development

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
- [ ] Analyzes project structure and extracts relevant technical context
- [ ] Finds and presents related issues/PRs for user confirmation
- [ ] Summarizes existing project patterns and conventions
- [ ] Identifies potentially affected files and components

**Question Flow**
- [ ] Asks relevant questions based on requirement type (auth, CRUD, UI, etc.)
- [ ] Branches appropriately based on user responses
- [ ] Recognizes natural completion signals from user
- [ ] Handles unknown answers with defaults and TODO tracking
- [ ] Maintains conversation context throughout session

**Session Management**
- [ ] Automatically saves session state during questioning
- [ ] Prompts user to continue interrupted sessions on restart
- [ ] Allows manual session continuation via `/pm:continue`
- [ ] Prevents data loss during command interruption

**Plan Output**
- [ ] Generates consistent, well-structured markdown PRDs
- [ ] Includes all sections required for Claude Code execution
- [ ] Provides realistic complexity estimates
- [ ] Contains clear, testable acceptance criteria

**Command Interface**
- [ ] `/pm "<requirement>"` starts new requirement gathering
- [ ] `/pm:list` shows existing plans with summaries
- [ ] `/pm:continue <plan>` resumes specific plan
- [ ] `/pm:configure` manages settings
- [ ] `/pm:status` shows current session state

## Implementation Notes

### Files Likely to Change
- **New files:**
  - `/commands/pm/index.js` - Main command handler
  - `/commands/pm/context-analyzer.js` - Codebase analysis
  - `/commands/pm/question-engine.js` - Questioning logic
  - `/commands/pm/plan-manager.js` - File operations
  - `/commands/pm/config-manager.js` - Configuration handling

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

*This PRD represents the exact output format and detail level that the `/pm` command should generate for user requirements.*