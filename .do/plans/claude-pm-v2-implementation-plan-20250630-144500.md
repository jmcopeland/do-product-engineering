# Claude PM v2: AI-Powered Questioning - Implementation Plan

**Created:** 2025-06-30  
**Complexity Estimate:** 3/5  
**Status:** ✅ Completed - All v2 phases implemented successfully

## Overview

This implementation plan breaks down the Claude PM v2 AI-powered questioning feature into actionable tasks based on the refined PRD. The plan focuses on creating a hybrid AI/template system that provides intelligent, conversational questioning.

## Phase 1: Foundation Setup (Day 1-2)

### 1.1 Create Question Template Structure
**Files to create:**
- `.claude-pm/questions/auth.md`
- `.claude-pm/questions/crud.md`
- `.claude-pm/questions/ui.md`
- `.claude-pm/questions/api.md`
- `.claude-pm/questions/general.md`

**Template Format Example (auth.md):**
```markdown
# Authentication Question Template

## Core Questions
1. What authentication methods should be supported? (email/password, OAuth, SSO, etc.)
2. Do you need role-based access control or simple authentication?
3. Should users stay logged in between sessions?
4. What user profile data needs to be stored?
5. How should password reset work?
6. Do you need two-factor authentication?
7. Should there be account lockout after failed attempts?
8. What happens to user data when account is deleted?

## Context Hints
- Check for existing auth libraries (Passport, Auth0, etc.)
- Look for user models or schemas
- Find existing session management
- Check security requirements in docs
```

### 1.2 Update Configuration System
**File:** `.claude/commands/pm/configure.md`
- Add new AI questioning options
- Update default config structure
- Ensure backwards compatibility

**File:** `.claude-pm/config.json`
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
  "contextDepth": "standard",
  "questioningMode": "ai-powered",
  "aiQuestioningOptions": {
    "maxRounds": 5,
    "questionsPerRound": 1,
    "adaptiveDepth": true,
    "includeRationale": true,
    "allowSkipQuestioning": true
  }
}
```

### 1.3 Create Session Management
**Directory:** `.claude-pm/sessions/`
- Design session file format
- Implement session save/load logic
- Handle session cleanup

**Session Format Example:**
```json
{
  "sessionId": "auth-feature-20250630-145000",
  "requirement": "Add user authentication",
  "startTime": "2025-06-30T14:50:00Z",
  "questioningMode": "ai-powered",
  "templateUsed": ["auth"],
  "questionsAsked": 3,
  "estimatedTotal": 5,
  "currentState": "in-progress",
  "context": {
    "codebaseFindings": {},
    "userResponses": {},
    "skippedQuestions": []
  }
}
```

## Phase 2: Core AI Integration (Day 3-5)

### 2.1 Enhance Main PM Command
**File:** `.claude/commands/pm.md`

**Key Changes:**
1. Add AI questioning mode detection
2. Implement template selection logic
3. Add codebase analysis before questioning
4. Integrate skip questioning option

**New Flow:**
```
1. User provides requirement
2. Check questioning mode from config
3. If AI-powered:
   a. Analyze requirement for complexity
   b. Search entire codebase for patterns
   c. Select relevant question templates
   d. Pre-answer questions from codebase
   e. Start AI-guided conversation
4. If user wants to skip:
   a. Use codebase + best practices
   b. Generate PRD with assumptions noted
```

### 2.2 Implement AI Question Generation
**Core Logic in pm.md:**

```markdown
## AI-Powered Questioning

Given requirement: "$ARGUMENTS"

1. **Analyze Requirement**
   - Extract key concepts and technical terms
   - Identify requirement type (auth, CRUD, UI, API, other)
   - Estimate complexity based on keywords
   - Check if breakdown is needed

2. **Codebase Analysis**
   - Search for similar existing features
   - Find relevant patterns and conventions
   - Identify potentially affected files
   - Extract technical stack details

3. **Template Selection**
   - Load relevant templates from .claude-pm/questions/
   - Combine templates if multiple types detected
   - Filter questions already answered by codebase

4. **Start Conversation**
   - Present first question with rationale
   - Show progress (e.g., "Question 1 of ~5")
   - Handle user response
   - Generate follow-up or next question
   - Detect completion signals
```

### 2.3 Response Analysis System
**Implement detection for:**
- Completion signals: "good to go", "looks good", "continue"
- Dismissal signals: "not relevant", "skip", "doesn't matter"
- Uncertainty: "I don't know", "not sure"
- Complexity indicators for breakdown offers

## Phase 3: Conversation Management (Day 6-7)

### 3.1 Progress Estimation & Question Management
**AI-Driven Approach (No Hard Limits):**
- AI determines which questions are relevant from template pool
- Filter questions by priority level (high/medium/low)
- Pre-answer what can be determined from codebase
- Show dynamic progress: "Question 3, more to explore based on your answers"
- Let users control when to stop rather than enforcing limits
- **Key insight:** With comprehensive templates (20-50 questions each), quality filtering is more important than quantity limits

### 3.2 Skip Questioning Feature
**When user chooses to skip:**
1. Acknowledge skip request
2. Use codebase analysis findings
3. Apply industry best practices
4. Generate PRD with assumptions section
5. Highlight areas that may need clarification

### 3.3 Session Persistence
**Implement in continue.md:**
- Load session from `.claude-pm/sessions/`
- Restore conversation context
- Continue from last question
- Handle stale sessions gracefully

## Phase 4: Integration & Polish (Day 8-9)

### 4.1 Update List Command
**File:** `.claude/commands/pm/list.md`
- Show active sessions
- Display questioning mode used
- Indicate AI vs template generated PRDs

### 4.2 Update Status Command
**File:** `.claude/commands/pm/status.md`
- Show current questioning mode
- Display session statistics
- Report template usage

### 4.3 Testing Scenarios
Create manual test cases for:
1. Simple auth requirement
2. Complex multi-part requirement
3. Skip questioning flow
4. Session interruption/resume
5. Template + AI hybrid flow

## Phase 5: Documentation & Release (Day 10)

### 5.1 Update Documentation
- Update README.md with v2 features
- Update CLAUDE.md with new architecture
- Create migration guide for v1 users

### 5.2 Create Example Templates
Populate question templates with comprehensive questions for:
- Authentication scenarios
- CRUD operations
- UI components
- API integrations
- General features

### 5.3 Release Checklist
- [ ] All commands updated
- [ ] Configuration migration tested
- [ ] Session management working
- [ ] Templates created and tested
- [ ] Documentation updated
- [ ] Example conversations documented

## Implementation Order

1. **Start with foundation** - Templates and config (Phase 1)
2. **Core AI integration** - Main questioning logic (Phase 2)
3. **Conversation features** - Progress, skip, sessions (Phase 3)
4. **Polish and integrate** - Update other commands (Phase 4)
5. **Document and release** - User-facing docs (Phase 5)

## Success Criteria

- [ ] AI questioning feels natural and conversational
- [ ] Templates ensure comprehensive coverage
- [ ] Skip option works with reasonable defaults
- [ ] Sessions can be interrupted and resumed
- [ ] Progress estimation is reasonably accurate
- [ ] Existing v1 functionality still works

## Notes

- No caching or preprocessing in v1
- No quality tracking metrics yet
- Templates are guides, not fallbacks
- Focus on conversation quality over speed
- Entire codebase search is acceptable

---

*This implementation plan provides a clear path to upgrade Claude PM with AI-powered questioning while maintaining backward compatibility.*