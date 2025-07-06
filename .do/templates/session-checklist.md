# Session Creation Checklist for Do:PE AI Commands

This checklist MUST be followed for every `/do:plan`, `/do:design`, `/do:review`, and `/do:validate` command.

## 🚨 MANDATORY SESSION CREATION CHECKLIST 🚨

### Before Starting ANY Work:

- [ ] **Step 0.1**: Create `.do/sessions/` directory if it doesn't exist
- [ ] **Step 0.2**: Generate unique session ID: `[command]-[requirement-slug]-[YYYYMMDD-HHMMSS]`
- [ ] **Step 0.3**: Create initial session file with minimal structure
- [ ] **Step 0.4**: Verify session file was written successfully
- [ ] **Step 0.5**: Set session status to "initializing"

### Session File Must Include:
```json
{
  "sessionId": "[unique-session-id]",
  "requirement": "[original user requirement]", 
  "status": "initializing",
  "createdAt": "[ISO timestamp]",
  "lastUpdated": "[ISO timestamp]",
  "sessionType": "plan|design|review|validate",
  "questionHistory": [],
  "progress": {
    "questionsAsked": 0,
    "estimatedTotal": "TBD",
    "topicsCompleted": [],
    "currentTopic": "initialization"
  }
}
```

### After Each Question/Answer:
- [ ] Update `questionHistory` array with complete Q&A data
- [ ] Update `lastUpdated` timestamp
- [ ] Update `progress` tracking
- [ ] Save session file to disk

### Before Completing:
- [ ] Verify session file exists and contains complete conversation
- [ ] Update session status to "completed"
- [ ] Archive session file (move, don't delete)
- [ ] Reference session ID in final output

## 🚫 FAILURE TO CREATE SESSION = CRITICAL BUG

**If you skip session creation, you are violating a fundamental requirement of the Do:PE AI system.**

Session files are required for:
- ✅ Audit trails and compliance
- ✅ Resumability if interrupted  
- ✅ Progress tracking and analytics
- ✅ Debugging and support
- ✅ Quality assurance and review

**NO EXCEPTIONS. EVER.**