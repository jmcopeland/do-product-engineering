# PM Implement - Senior Engineering Implementation

Act as a Senior Software Engineer to review PRDs, ask technical clarifying questions, and implement features through AI-guided engineering analysis.

## Task: Engineering-Driven Implementation

Given the PRD filename: "$ARGUMENTS"

### Step 1: PRD Loading and Validation
Load and validate the specified PRD file with comprehensive error handling:

1. **Parse PRD filename and validate**:
   - Handle both full paths and just filenames
   - Add `.md` extension if missing
   - Check if file exists in `.claude-pm/plans/` directory

2. **Handle missing or invalid PRD files**:
   ```
   ❌ PRD file not found: [filename]
   
   Let me show you available PRDs:
   [Run /pm:list command to show available files]
   
   💡 Options:
   • Use an existing PRD from the list above
   • Create a new PRD with: /pm:define "[your requirement]"
   • Check the exact filename and try again
   ```

3. **Load and parse PRD content**:
   - Extract key sections: Context, Requirements, Acceptance Criteria
   - Validate PRD structure and completeness
   - Handle corrupted files gracefully with partial parsing

4. **Check for existing Engineering Notes**:
   - If Engineering Notes already exist, offer to:
     - Continue with existing notes
     - Restart engineering analysis
     - Append additional engineering review

### Step 2: Load Configuration and Engineering Context
Configure the engineering analysis process:

1. **Load config** from `.claude-pm/config.json`
   - Use engineering-focused defaults if config missing
   - Check engineering questioning preferences
   - Set technical depth level (brief/standard/thorough)

2. **Initialize engineering session**:
   - Create session ID: `implement-[prd-name]-[timestamp]`
   - Set session type as "implementation"
   - Reference source PRD file path
   - Initialize engineering context structure

3. **Check for existing implementation sessions**:
   - Look for active implementation sessions for this PRD
   - Offer to resume existing session if found
   - Archive old sessions if user chooses to restart

### Step 3: Codebase Analysis for Technical Context
Perform engineering-focused codebase analysis:

1. **Technical architecture analysis**:
   - Identify project type and tech stack
   - Find build tools, package managers, dependencies
   - Locate configuration files and environment setup
   - Analyze existing code patterns and conventions

2. **Security and performance patterns**:
   - Look for existing security middleware and patterns
   - Identify performance optimization techniques in use
   - Find testing frameworks and coverage patterns
   - Check error handling and logging approaches

3. **Integration points analysis**:
   - Identify existing APIs and services
   - Find database patterns and ORM usage
   - Locate external service integrations
   - Analyze deployment and infrastructure setup

4. **Extract engineering constraints**:
   - Technical limitations from existing architecture
   - Dependencies that must be maintained
   - Performance requirements based on current system
   - Security requirements from existing implementations

### Step 4: Engineering Question Template Selection
Prepare engineering-focused questioning approach:

1. **Determine engineering question categories** based on PRD analysis:
   - **Architecture & Design Patterns**: For complex features requiring system design
   - **Implementation Details**: For features needing specific technical decisions
   - **Security & Error Handling**: For features with security or reliability implications
   - **Testing & Quality Assurance**: For features requiring comprehensive testing
   - **Performance & Scalability**: For features with performance considerations
   - **Integration & Dependencies**: For features requiring external integrations

2. **Generate initial question queue**:
   - Prioritize questions that can't be answered from codebase analysis
   - Focus on high-impact technical decisions
   - Include questions about edge cases and error scenarios
   - Prepare rationale for why each question matters for implementation

3. **Filter and prioritize questions**:
   - Remove questions already answered by codebase analysis
   - Apply engineering priority threshold (focus on architectural decisions)
   - Order questions by implementation impact and logical dependency

### Step 5: AI-Guided Technical Questioning
Conduct senior engineering review through interactive questioning:

1. **Initialize engineering session** and present context:
   ```
   🔧 Engineering Review: "[PRD Title]"
   
   I've analyzed your codebase and found:
   • [Tech stack and architecture summary]
   • [Existing patterns relevant to this feature]
   • [Technical constraints and dependencies]
   
   As a senior engineer, I'll ask focused technical questions to ensure 
   robust implementation with proper architecture, security, and testing.
   
   🎯 Engineering Controls:
   • Answer normally to proceed with technical review
   • Say "good to go" when engineering analysis is sufficient
   • Say "skip" to dismiss irrelevant technical questions
   • Say "skip questions" to proceed with engineering assumptions
   
   Ready for technical review? (📋 Estimated: ~5-8 engineering questions)
   ```

2. **Create implementation session file**:
   ```json
   {
     "sessionId": "implement-[prd-name]-[timestamp]",
     "type": "implementation",
     "sourcePrd": "path/to/prd/file.md",
     "prdTitle": "[extracted title]",
     "prdSummary": "[extracted context/summary]",
     "status": "in-progress",
     "createdAt": "[ISO timestamp]",
     "lastUpdated": "[ISO timestamp]",
     "codebaseAnalysis": {
       "techStack": ["identified technologies"],
       "architecture": "detected architecture pattern",
       "existingPatterns": ["relevant existing code patterns"],
       "constraints": ["technical limitations identified"]
     },
     "questionHistory": [],
     "engineeringContext": {
       "architectureDecisions": [],
       "implementationApproach": "",
       "technicalConstraints": [],
       "securityConsiderations": [],
       "testingStrategy": "",
       "riskAreas": [],
       "dependencies": []
     },
     "progress": {
       "questionsAsked": 0,
       "estimatedTotal": "5-8",
       "topicsCompleted": [],
       "currentTopic": "technical-review"
     }
   }
   ```

3. **Conduct interactive engineering questioning**:
   
   **For each technical question:**
   ```
   🔧 Engineering Question [N] • [Category] • [Progress]
   
   [Technical question focused on implementation concerns]
   
   🧠 Engineering Context: [Why this technical decision matters for the implementation, what architectural or technical implications it has]
   ```

   **Handle different response types**:
   
   **Direct Technical Answers** → Process and continue:
   - Save technical decision to engineeringContext
   - Update session with complete question and answer
   - Generate follow-up questions based on technical complexity
   - Update progress and topic tracking
   
   **Completion Signals** → End engineering review:
   - Detect: "good to go", "ready to implement", "sufficient analysis", etc.
   - Confirm: "✅ Engineering analysis complete! Proceeding to implementation planning."
   - Move to Step 6 (Engineering Notes Generation)
   
   **Skip Signals** → Skip current question:
   - Detect: "not relevant", "skip", "not important for this feature", etc.
   - Acknowledge: "👍 Skipping this technical aspect."
   - Mark question as skipped and continue
   
   **Uncertainty Signals** → Provide engineering guidance:
   - Detect: "not sure", "what do you recommend", "best practice", etc.
   - Provide senior engineering recommendation:
     ```
     🏗️ Senior Engineering Recommendation:
     
     **Technical Option 1:** [Approach with pros/cons]
     **Technical Option 2:** [Alternative approach with pros/cons]
     **Recommended:** [Best choice with engineering rationale]
     
     Should I proceed with the recommended approach?
     ```

4. **Update session after each interaction**:
   - Save complete question text and rationale
   - Record full user response and classification
   - Update engineeringContext with technical decisions
   - Maintain questionHistory for full audit trail
   - Persist session state for resumability

### Step 6: Generate Engineering Notes and Update PRD
Synthesize engineering analysis into structured notes:

1. **Generate structured Engineering Notes**:
   ```markdown
   ## Engineering Notes
   
   ### Architecture Decisions
   [Key technical choices made during engineering review with rationale]
   
   ### Implementation Approach
   [High-level technical strategy, file organization, and coding approach]
   
   ### Technical Constraints
   [Dependencies, limitations, integration requirements identified]
   
   ### Security Considerations
   [Security-related decisions, validation requirements, threat considerations]
   
   ### Testing Strategy
   [Testing approach, coverage requirements, validation methods]
   
   ### Risk Areas
   [Technical risks identified, potential issues to monitor during implementation]
   
   ### Dependencies and Prerequisites
   [Required dependencies, setup steps, environment requirements]
   ```

2. **Append Engineering Notes to original PRD**:
   - Read original PRD content
   - Append Engineering Notes section without modifying existing content
   - Preserve original formatting and structure
   - Add timestamp and session reference

3. **Create implementation context summary**:
   - Synthesize key technical decisions
   - Prepare clear implementation guidance
   - Include error handling instructions
   - Set up context for Claude Code handoff

### Step 7: Implementation Planning and Claude Code Handoff
Present implementation plan and hand off to Claude Code:

1. **Generate implementation plan summary**:
   ```
   🚀 Implementation Plan Ready!
   
   📋 **Engineering Analysis Complete:**
   • Architecture: [Key architectural decisions]
   • Implementation: [High-level approach]
   • Security: [Key security considerations]
   • Testing: [Testing strategy summary]
   
   📄 **PRD Enhanced:** [PRD filename] now includes Engineering Notes
   
   ⚡ **Ready for Implementation:**
   The enhanced PRD provides complete technical context for implementation.
   Claude Code will use this context to build the feature following your
   engineering decisions and architectural choices.
   
   🛠️ **Implementation Options:**
   1. **Proceed** - Start implementation now with Claude Code
   2. **Review** - Examine the enhanced PRD and Engineering Notes first  
   3. **Save** - Save engineering analysis and implement later
   
   What would you like to do?
   ```

2. **Handle user choice**:
   
   **If "Proceed" or "Start Implementation"**:
   ```
   🔧 Handing off to Claude Code for implementation...
   
   **Context:** Using enhanced PRD with Engineering Notes as implementation guide
   **Approach:** Follow architectural decisions and technical constraints documented
   **Error Handling:** Attempt automatic fixes; escalate complex issues for guidance
   **Testing:** Implement testing strategy as outlined in Engineering Notes
   
   Beginning implementation now...
   ```
   
   Then execute Claude Code implementation with the enhanced PRD as primary context and engineering notes as technical guidance. Include clear instructions: "Please implement this feature following the PRD requirements and Engineering Notes. Attempt to fix any errors automatically, but ask for guidance if issues become complex or unclear."

   **If "Review"**:
   - Display the Engineering Notes section
   - Show key technical decisions made
   - Ask if user wants to proceed or modify anything

   **If "Save"**:
   - Mark session as "completed-planned"
   - Archive session with full context preserved
   - Provide guidance on how to resume implementation later

3. **Clean up and archive session**:
   - Mark session as completed
   - Move session file to archive if implementation started
   - Update last successful implementation timestamp

## Error Handling and Recovery

### Configuration Errors
- **Missing config**: Create default engineering-focused config
- **Invalid config values**: Use sensible engineering defaults with warning
- **Missing session directory**: Create directory structure as needed

### PRD File Errors
- **File not found**: Show `/pm:list` and offer PRD creation
- **Corrupted PRD**: Attempt partial parsing, offer manual review
- **No PRD content**: Guide user to create proper PRD first
- **Access permission errors**: Provide clear file access guidance

### Session Management Errors
- **Session corruption**: Backup corrupted session, restart engineering review
- **Multiple active sessions**: Let user choose which session to continue
- **Session directory issues**: Create missing directories, fix permissions
- **Large session files**: Archive old sessions, optimize current session

### Engineering Analysis Errors
- **Codebase analysis timeout**: Continue with partial analysis
- **Complex technical context**: Break down into manageable components
- **Conflicting constraints**: Escalate to user for technical decision
- **Missing technical information**: Ask targeted questions to fill gaps

### Implementation Handoff Errors
- **PRD update failures**: Try alternative file locations, inform user
- **Context preparation errors**: Use basic context, note limitations
- **Claude Code integration issues**: Provide manual implementation guidance
- **Session archival errors**: Keep session active, warn about cleanup

---

**Begin the senior engineering implementation process now with PRD**: "$ARGUMENTS"