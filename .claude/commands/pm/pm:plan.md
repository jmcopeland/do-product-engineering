# PM Plan - AI Product Manager

Act as an AI Product Manager to transform vague requirements into detailed, actionable PRDs through intelligent, adaptive questioning.

## Task: AI-Powered Requirements Gathering

Given the user requirement: "$ARGUMENTS"

**🚨 IMPORTANT: ALL 7 STEPS BELOW ARE MANDATORY - NONE CAN BE SKIPPED**

### CRITICAL: Session Creation (MANDATORY - DO NOT SKIP)
**IMPORTANT**: A session MUST be created for EVERY use of pm:plan. This is NOT optional.

1. **Create session directory if needed**: Ensure `.claude-pm/sessions/` exists
2. **Generate session ID**: `plan-[requirement-slug]-[YYYYMMDD-HHMMSS]`
3. **Create initial session file** immediately with status "initializing"
4. **If session creation fails**: STOP and report error to user

### Step 1: Load Configuration and Check for Skip (MANDATORY)
First, check the configuration and handle skip requests:

1. **Load config** from `.claude-pm/config.json`
   - If config missing, use sensible defaults
   - Check if `allowSkipQuestioning` is enabled

2. **Check for skip signals** in the requirement:
   - Direct skip: "skip questions", "no questions", "just generate", "use defaults", and other similar signals
   - Contextual skip: "make assumptions", "best practices", "don't ask me", and other similar signals
   - If skip detected and allowed, jump to Step 6 (Generate with Assumptions)
   - If skip detected but not allowed, inform user and proceed normally

3. **Handle skip request**:
   ```
   I understand you'd like me to skip questioning and make assumptions.
   I'll analyze your codebase thoroughly and use industry best practices
   to generate a comprehensive PRD.
   
   Proceeding with assumption-based generation...
   ```

### Step 2: Analyze Requirement and Complexity (MANDATORY)
Analyze the user requirement to understand what we're building:

1. **Extract key concepts** and technical terms
2. **Identify requirement type(s)** (can be multiple):
   - Authentication/User Management → auth template (keywords: login, signup, user, profile, permission, role)
   - CRUD operations → crud template (keywords: create, read, update, delete, manage, edit, list)
   - UI/Components → ui template (keywords: component, interface, design, layout, form, button)
   - API/Integration → api template (keywords: API, endpoint, service, integration, webhook, external)
   - General/Other → general template (fallback for unclear requirements)
3. **Assess complexity** based on keywords and scope:
   - Simple: "add button", "change color", "basic", single action
   - Medium: "authentication", "CRUD", "form", "profile", standard feature
   - Complex: "real-time", "collaborative", "integration", "migration", multi-system feature
4. **Determine if breakdown needed**:
   - If complex, offer to break into smaller PRDs
   - If user accepts breakdown, focus on one component

### Step 3: Comprehensive Codebase Analysis (MANDATORY)
Perform deep codebase analysis to pre-answer questions:

1. **Project structure analysis** (fast scan):
   - Find package.json, requirements.txt, composer.json, Cargo.toml, etc.
   - Identify framework (React, Vue, Express, Django, Laravel, etc.)
   - Locate main directories (src/, app/, components/, models/, etc.)
   - Scan only top 3 levels initially for performance

2. **Find similar existing features** (targeted search):
   - Use Grep tool to search for requirement-related patterns
   - Look for auth patterns: "login", "signup", "authenticate", "user"
   - Look for CRUD patterns: "create", "update", "delete", "findBy"
   - Look for UI patterns: "component", "form", "modal", "page"
   - Limit search to common file extensions (.js, .ts, .py, .php, .rb)

3. **Extract technical context** (essential only):
   - Database: Check for migrations, schema files, model definitions
   - Auth: Look for auth middleware, user models, session handling
   - UI: Identify component library (Material-UI, Bootstrap, Tailwind)
   - API: Find route definitions, controller patterns
   - Stop analysis after 30 seconds to avoid blocking

4. **Analyze git history** (if configured and fast):
   - Only scan last 10 commits for performance
   - Look for commits related to similar features (auth, user, profile, CRUD)
   - Extract development patterns and naming conventions
   - Skip if git log takes >10 seconds

### Step 4: Load and Filter Question Templates (MANDATORY)
Intelligently select and filter questions:

1. **Load relevant templates** from `.claude-pm/questions/`:
   - Based on requirement type analysis from Step 2
   - May load multiple templates if requirement spans categories

2. **Pre-answer questions from codebase**:
   - Mark questions as "answered" if codebase analysis provides clear answers
   - Note the source of pre-answered information (e.g., "Found React in package.json")
   - Skip redundant questions (e.g., don't ask about auth library if already using one)

3. **Filter by relevance and priority**:
   - Apply `priorityThreshold` from config (low/medium/high)
   - Remove questions not relevant to this specific requirement
   - Prioritize questions that can't be answered from codebase
   - Use keyword matching to filter relevant questions only
   - For "user profile" requirement: focus on auth + CRUD questions, skip API integration

4. **Create question queue**:
   - Order questions by importance and logical flow
   - Prepare rationale for each question
   - Set initial progress estimate (dynamic)

### Step 5: AI-Guided Interactive Questioning (MANDATORY)
Conduct intelligent, conversational questioning with dynamic flow management:

1. **Initialize session and present context**:
   ```
   🚀 Analyzing: "[requirement]"
   
   I've analyzed your codebase and found:
   • [Framework/tech stack discovered]
   • [Existing related features, if any]
   • [Key patterns that inform this feature]
   
   I'll ask focused questions one at a time to create a detailed PRD.
   
   🎯 Control the conversation:
   • Answer normally to proceed
   • Say "good to go" when you have enough
   • Say "skip" or "not relevant" to dismiss questions
   • Say "skip questions" to generate with assumptions only
   
   Ready to start? (📝 Estimated: ~6-10 questions)
   ```

2. **Create session file** with unique ID: `[requirement-slug]-[YYYYMMDD-HHMMSS].json`
   ```json
   {
     "sessionId": "[requirement-slug]-[YYYYMMDD-HHMMSS]",
     "requirement": "[original user requirement]",
     "status": "in-progress",
     "createdAt": "[ISO timestamp]",
     "lastUpdated": "[ISO timestamp]",
     "codebaseAnalysis": {
       "framework": "[detected framework]",
       "existingPatterns": ["pattern1", "pattern2"],
       "techStack": ["tech1", "tech2"]
     },
     "templateSelection": ["auth", "crud"],
     "questionHistory": [],
     "currentQuestion": {
       "questionId": "auth-1",
       "questionText": "How should users sign up?",
       "rationale": "Determines signup flow complexity",
       "category": "auth",
       "priority": "high",
       "timestamp": "[ISO timestamp when asked]"
     },
     "progress": {
       "questionsAsked": 0,
       "estimatedTotal": "6-10",
       "topicsCompleted": [],
       "currentTopic": "requirements"
     }
   }
   ```

3. **Dynamic question presentation loop**:
   For each question until completion or user stops:
   
   **a) Present question with context**:
   ```
   ❓ Question [current] • [topic area] • [progress indicator]
   
   [The actual question]
   
   🧠 Context: [rationale - why this matters for the PRD]
   ```
   
   **Example:**
   ```
   ❓ Question 2 • User Authentication • Covered: requirements ✓ | Exploring: auth, data
   
   How should users sign up for accounts? (email/username, social login, etc.)
   
   🧠 Context: This determines the signup flow complexity and which auth libraries we'll need. Helps define the user onboarding section of the PRD.
   ```
   
   **b) Wait for user response and classify it**:
   
   **Direct Answers** → Process and continue:
   - Save answer to session
   - Generate next logical question based on this response
   - Update progress estimate
   
   **Completion Signals** → End questioning:
   - Detect: "good to go", "looks good", "sounds good", "continue", "proceed", "that's enough", etc.
   - Confirm: "✅ Perfect! I have enough information to create a comprehensive PRD."
   - Move to Step 6 (Generate PRD)
   
   **Dismissal Signals** → Skip and continue:
   - Detect: "not relevant", "skip", "doesn't matter", "not important", "move on", etc.
   - Acknowledge: "👍 Understood, skipping that aspect."
   - Mark question as dismissed in session
   - Move to next question
   
   **Uncertainty Signals** → Offer options:
   - Detect: "I don't know", "not sure", "maybe", "unclear", "help me decide", etc.
   - Present friendly options:
     ```
     🤔 No worries! Let's handle this:
     
     1. 📚 Explore this now (I'll explain the tradeoffs)
     2. 📝 Defer as a TODO for later consideration  
     3. ✨ Use a sensible default based on best practices
     4. ⏭️ Skip this aspect entirely
     
     What works for you?
     ```
   - Handle choice and update session accordingly
   
   **Clarification Requests** → Provide explanation:
   - Detect: "why are you asking", "why does this matter", "explain", "what's the point", etc.
   - Provide deeper rationale:
     ```
     💡 Great question! Here's why this matters:
     
     **Business impact:** [How this affects users/business]
     **Technical impact:** [How this affects implementation]
     **PRD impact:** [What section this helps define]
     
     [Re-ask the original question]
     ```
   
   **c) Update session after each interaction**:
   - **Save complete question/answer pair to questionHistory**:
     ```json
     {
       "questionId": "unique-id",
       "questionText": "Complete question as presented to user",
       "rationale": "Why this question matters for the PRD",
       "category": "auth|crud|ui|api|general",
       "priority": "high|medium|low",
       "timestamp": "ISO-timestamp-when-asked",
       "userResponse": "Complete user response exactly as provided",
       "responseClassification": "direct_answer|skip|completion|uncertainty|clarification",
       "responseTimestamp": "ISO-timestamp-when-answered"
     }
     ```
   - **Update currentQuestion** with next question if continuing
   - **Update progress tracking** and session metadata
   - **Persist complete session state** to disk with full conversation history

4. **Adaptive question flow management**:
   
   **Dynamic Progress Estimation**:
   - Start with initial estimate from template filtering (e.g., "~6-10 questions")
   - Adjust based on response complexity and follow-ups generated
   - Show progress as "Question 3, exploring auth methods..." instead of "3 of 8"
   - Provide topic-based progress: "Covered: requirements, auth ✓ | Exploring: data model, UI"
   
   **Follow-up Question Generation**:
   - If answer reveals complexity, generate specific follow-ups
   - If answer is vague, ask for clarification
   - If answer contradicts codebase findings, explore the difference
   
   **Redundancy Detection**:
   - Skip questions already answered implicitly by previous responses
   - Cross-reference with codebase pre-answered questions
   - Combine related questions for efficiency
   
   **Depth Adaptation**:
   - For complex responses: dive deeper with follow-ups
   - For simple responses: move to next topic quickly
   - For expert-level responses: skip basic questions in that area

5. **Session persistence and cleanup**:
   - **Auto-save session after every user response** with complete question/answer data
   - **Maintain full conversation audit trail** in questionHistory array
   - **Include all metadata:** timestamps, classifications, rationale, categories
   - **Handle interruptions gracefully** - session can be fully resumed via `/pm:continue`
   - **Archive session file** when PRD is successfully generated (move to archive, don't delete)

### Step 6: Generate PRD with Collected Information (MANDATORY)
Create comprehensive PRD using all gathered information:

1. **Synthesize all inputs**:
   - User requirement and responses
   - Codebase analysis findings
   - Pre-answered template questions
   - User-provided answers

2. **Generate PRD sections**:
   - **Context**: Feature background with codebase integration notes
   - **User Stories**: Based on requirement and user responses
   - **Core Requirements**: Detailed functional requirements by category
   - **Acceptance Criteria**: Specific, testable criteria
   - **Implementation Notes**: 
     - Files likely to change (from codebase analysis)
     - Technical considerations (integration with existing patterns)
     - Dependencies and constraints
   - **Success Metrics**: How to measure success
   - **TODOs**: Unresolved questions or deferred decisions

3. **Include assumptions section** (if questions were skipped or minimal questioning):
   - **If full skip**: List comprehensive assumptions made from codebase analysis and best practices
   - **If partial skip**: Note dismissed questions and assumed answers
   - **If early termination**: Document what wasn't explored
   - Note areas that may need clarification
   - Suggest follow-up questions for future refinement
   
   **Assumptions format**:
   ```markdown
   ## Assumptions Made
   
   **From Codebase Analysis:**
   - [Technology stack assumptions based on files found]
   - [Integration patterns assumed from existing code]
   - [Security assumptions from current implementation]
   
   **From Industry Best Practices:**
   - [Standard approaches for this type of feature]
   - [Common implementation patterns]
   - [Typical user experience flows]
   
   **Areas for Future Clarification:**
   - [Specific questions that could refine requirements]
   - [Business decisions that may affect implementation]
   - [User experience details that need validation]
   ```

### Step 7: Save and Present Results (MANDATORY - CRITICAL - VERIFY ALL STEPS)
Finalize the PRD and present to user:

1. **Generate PRD content** based on all collected information
2. **Create PRD file** with timestamped filename: `[feature-name]-[YYYYMMDD-HHMMSS].md`
   - MUST create file in `.claude-pm/plans/` directory
   - MUST write complete PRD content to file
   - MUST verify file was created successfully
   - If file creation fails: STOP and report error
3. **Verify PRD exists**:
   - Read back the file to confirm it was written
   - Check file size is reasonable (not empty)
   - If verification fails: STOP and report error
4. **Update session** with PRD filename and completion status
5. **Archive session** to `.claude-pm/sessions/archive/`
   - DO NOT delete original session file
   - Copy to archive with completion timestamp
6. **Only after verification**, present summary:
   ```
   🎉 PRD Successfully Created!
   
   📄 **File:** [filename]
   📊 **Complexity:** [1-5] | **Questions Asked:** [N]
   
   🎯 **Key Decisions Made:**
   • [Summary of main decisions]
   
   ⚠️ **Areas Flagged for Attention:**
   • [Any TODOs or assumptions]
   
   🚀 **Ready for implementation?** 
   Say "proceed" to begin development or "/pm:list" to see all plans.
   ```

## Configuration-Driven Behavior

The process adapts based on `.claude-pm/config.json` settings:

- **useRelevanceFiltering**: Filter questions by AI-determined relevance
- **priorityThreshold**: "low"/"medium"/"high" - minimum priority to ask
- **includeRationale**: Show reasoning for each question
- **allowSkipQuestioning**: Enable skip option
- **adaptiveDepth**: Adjust questioning based on response complexity

## Error Handling and Fallbacks

### Configuration and Setup Errors
- **Missing config file**: Create default config and continue
  ```
  ⚠️  Config not found. Created default .claude-pm/config.json with AI-powered questioning.
  ```
- **Invalid config values**: Use sensible defaults, warn user
  ```
  ⚠️  Invalid config value for 'priorityThreshold'. Using 'medium' as default.
  ```
- **Missing question templates**: Download/recreate from defaults, or use general.md
  ```
  ⚠️  Question templates missing. Using built-in general questions.
  ```
- **Permission errors**: Inform user about directory access needs
  ```
  ❌ Cannot create .claude-pm directory. Check write permissions in this project.
  ```

### Session Management Errors
- **Session file corruption**: Backup corrupted file, start fresh session
  ```
  ⚠️  Session file corrupted. Backed up to [filename].backup. Starting fresh session.
  ```
- **Concurrent sessions**: Warn about multiple active sessions, let user choose
  ```
  ⚠️  Found 2 active sessions. Continue existing session or start new?
  1. Continue: "user-auth-20250701-140000" (2 questions asked)
  2. Start new session
  ```
- **Session directory issues**: Create missing directories, fix permissions
  ```
  ✅ Created missing .claude-pm/sessions directory.
  ```
- **Disk space issues**: Clean up old archives, warn user
  ```
  ⚠️  Sessions directory large (50+ files). Run /pm:status for cleanup suggestions.
  ```

### Codebase Analysis Errors
- **Large codebase timeout**: Limit analysis scope, continue with partial results
- **Binary files errors**: Skip non-text files, continue analysis
- **Git history errors**: Skip git analysis, continue with file structure only
- **Access permission errors**: Skip restricted files, continue with accessible ones

### Conversation Flow Errors
- **User input parsing errors**: Ask for clarification, provide examples
- **Interrupted conversations**: Auto-save state, enable clean resumption
- **Template loading failures**: Fall back to general questions, warn user
- **Response classification failures**: Treat as direct answer, continue

### PRD Generation Errors (CRITICAL FAILURES)
- **File creation errors**: 
  ```
  ❌ CRITICAL ERROR: Failed to create PRD file
  
  Error: [specific error message]
  Directory: .claude-pm/plans/
  Attempted filename: [filename]
  
  This is a critical failure. Please check:
  • Directory permissions
  • Disk space availability
  • File system issues
  
  Cannot proceed without successful PRD creation.
  ```
- **File verification errors**:
  ```
  ❌ CRITICAL ERROR: PRD file creation appears to have failed
  
  File was not found after creation attempt: [filename]
  
  This indicates a serious file system issue.
  Session has been preserved for recovery.
  ```
- **Content generation errors**: Use basic template, include raw Q&A data
- **Timestamp errors**: Use fallback timestamp format
- **Permission errors**: Report exact permissions needed

### Recovery Strategies
- **Graceful degradation**: Always try to provide some value even with errors
- **User notification**: Clear error messages with suggested actions
- **Automatic recovery**: Retry failed operations where safe
- **Fallback modes**: Template mode if AI features fail

---

**Begin the AI-powered requirements gathering process now with**: "$ARGUMENTS"