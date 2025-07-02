# PM Continue - Resume Existing Plan or Session

Resume work on an existing PRD plan or continue an interrupted AI questioning session.

## Task: Continue Plan Development

Target plan/session: "$ARGUMENTS"

### 1. Determine What to Continue

Check for both active sessions and existing plans:

**Active Sessions Check:**
1. Look for active sessions in `.claude-pm/sessions/`
2. Find sessions with `"status": "in-progress"`
3. If no arguments provided and active session exists, offer to resume it

**Existing Plans Check:**
1. Look for completed plans in `.claude-pm/plans/`
2. If specific filename provided, load that plan
3. If no arguments and no active sessions, list available plans

### 2. Resume Active AI Questioning Session

If continuing an interrupted AI questioning session:

1. **Load session state** from `.claude-pm/sessions/[session-id].json`:
   - Original requirement and analysis
   - Codebase analysis results
   - Questions already asked and answered
   - Current progress and context

2. **Verify session validity**:
   - Check if session is recent (< 24 hours old)
   - Validate session data integrity
   - Check if codebase has changed significantly

3. **Resume conversation**:
   ```
   Resuming your session for "[requirement]"
   
   So far we've covered:
   - [Summary of questions asked and key answers]
   
   Let me continue with the next question...
   ```

4. **Continue AI questioning process**:
   - Pick up from `currentQuestion` in session
   - Use existing context and responses  
   - Present brief summary of progress so far
   - Resume same AI-powered questioning flow with all conversation management:
     - Dynamic progress estimation
     - User control signals (completion, dismissal, uncertainty)
     - Adaptive question generation based on previous responses
     - Session persistence after each interaction
   - Update session state as conversation progresses

### 3. Continue Existing Plan Development

If continuing work on a completed PRD:

1. **Load and analyze existing plan**:
   - Read plan content and current status
   - Check last modification date
   - Identify completeness level

2. **Determine continuation approach**:

   **If plan is incomplete (has TODOs, missing sections):**
   - Show what's missing or unclear
   - Restart AI questioning for gaps
   - Use existing plan content as context
   - Fill in missing sections

   **If plan is complete but user wants changes:**
   - Show current plan summary
   - Ask what aspects need modification
   - Use targeted questioning for specific areas
   - Update relevant sections with version notes

   **If plan is ready for implementation:**
   - Confirm plan is still current
   - Check if codebase has changed since plan creation
   - Ask if any changes needed before proceeding
   - Offer to begin implementation or make adjustments

3. **Update plan iteratively**:
   - Maintain original creation timestamp
   - Add "Last Updated" timestamp
   - Preserve implementation notes and progress
   - Add change notes in TODOs section

### 4. Handle Edge Cases

**Session not found:**
- If specified session doesn't exist, show available options
- Offer to start new session or continue existing plan

**Plan not found:**
- List available plans with brief descriptions
- Ask user to specify which plan to continue
- Offer to start new plan if needed

**Multiple active sessions:**
- Show list of active sessions with timestamps
- Ask user to choose which session to resume
- Provide context about each session

**Corrupted session/plan:**
- Show warning about corrupted data
- Offer to start fresh or attempt partial recovery
- Preserve original file as backup

### 5. Session and Plan Management

**Session cleanup and archival:**
- Mark resumed sessions as "completed" when PRD is generated
- Archive old session files automatically:
  - Sessions > 7 days old → move to `.claude-pm/sessions/archive/`
  - Completed sessions → move to archive after PRD generation
  - Failed/corrupted sessions → move to `.claude-pm/sessions/failed/`
- Clean up interrupted sessions that weren't resumed:
  - Sessions > 24 hours old with no recent activity
  - Warn user before cleanup, offer recovery option

**Session archival process:**
1. **Check session age and status** during continue operation
2. **Move old files** to appropriate subdirectories:
   ```
   .claude-pm/sessions/
   ├── active-session.json        # Current sessions
   ├── archive/                   # Completed/old sessions
   │   └── old-session.json
   └── failed/                    # Corrupted sessions
       └── corrupted-session.json
   ```
3. **Maintain session index** for quick lookup and statistics

**Plan versioning:**
- Track modification history in plan metadata:
  ```markdown
  **Last Updated:** [timestamp]
  **Modification Notes:** [what changed and why]
  **Previous Versions:** [links or notes about changes]
  ```
- Note what changed and why in TODOS section
- Maintain backward compatibility with existing plans

### 6. Interactive Flow Examples

**Resuming interrupted session:**
```
Found active session: "user-auth-20250701-080700"
Started 2 hours ago for "Add user authentication"

Progress so far:
✅ Requirement analysis (auth system, medium complexity)
✅ Codebase analysis (Express + React, no existing auth)
✅ 3 questions answered (auth methods, roles, session handling)

Continuing with question 4 of ~7...
```

**Continuing existing plan:**
```
Loading plan: "user-auth-20250630-143000.md"
Created yesterday, status: "Ready for Development"

This plan covers email/password + OAuth authentication.
What would you like to update or clarify?

Options:
1. Add new requirements
2. Modify existing requirements  
3. Update technical implementation
4. Review and proceed with implementation
```

---

**Begin continuation process now for**: "$ARGUMENTS"

If no arguments provided, check for:
1. Active sessions to resume
2. Recent plans to continue
3. Show available options