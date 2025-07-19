# PRD: Do Implementation Command Feature

**Created:** 2025-07-02  
**Complexity:** 4/5 (High)  
**Type:** Advanced Development Tool  
**Status:** ✅ Completed

## Context

The AI Product Manager system currently provides sophisticated PRD generation through `/pm:define` with AI-powered questioning. However, users must manually implement the features described in these PRDs. This creates a gap between product specification and development execution.

This feature bridges that gap by introducing `/pm:implement <prd_filename>` - a command that reads existing PRDs and provides senior-level engineering guidance to transform product requirements into working code. The feature mimics real-world PM/Engineer collaboration patterns where engineers review PRDs to identify technical considerations, ask clarifying questions, and develop implementation plans.

**Integration with Existing System:**
- Leverages current session management architecture (`.claude-pm/sessions/`)
- Extends the PM command suite alongside `pm:define`, `pm:list`, `pm:continue`, etc.
- Utilizes established PRD file format and storage in `.claude-pm/plans/`
- Maintains consistency with existing AI-powered questioning patterns

## User Stories

### Primary User Story
**As a developer using the AI Product Manager,**  
**I want to run `/pm:implement <prd_filename>` on an existing PRD**  
**So that I can get senior engineering guidance to implement the feature with proper technical planning and code generation.**

### Supporting User Stories

**As a developer,**  
**I want the command to gracefully handle missing or invalid PRD files**  
**So that I'm guided to available PRDs or can create new ones if needed.**

**As a developer,**  
**I want the engineering AI to ask comprehensive technical questions**  
**So that I can address architecture, implementation details, and edge cases before coding begins.**

**As a developer,**  
**I want the PRD to be updated with engineering notes**  
**So that technical decisions and clarifications are preserved alongside the original product requirements.**

**As a developer,**  
**I want to control when implementation begins**  
**So that I can review the engineering plan before code changes are made.**

**As a developer,**  
**I want intelligent error handling during implementation**  
**So that common issues are fixed automatically while complex problems escalate to me for guidance.**

## Core Requirements

### 1. PRD File Handling
- **Read and parse existing PRD files** from `.claude-pm/plans/` directory
- **Validate PRD file format** and content structure
- **Error handling for missing files:** Display helpful message, show `/pm:list` output, offer to create new PRD via `/pm:define`
- **Error handling for corrupted files:** Attempt to parse partial content, fallback to manual PRD creation

### 2. Senior Engineering AI Persona
- **Adopt senior software engineer persona** equivalent to how `/pm:define` uses PM persona
- **Comprehensive technical questioning covering:**
  - **Architecture decisions:** scalability, maintainability, integration patterns
  - **Implementation details:** specific technologies, libraries, frameworks to use
  - **Edge cases:** error conditions, performance considerations, security implications
  - **Testing strategies:** unit tests, integration tests, validation approaches
- **Question depth and style consistent with senior-level engineering review**
- **Technical domain expertise appropriate to the PRD's requirements**

### 3. Session Management Integration
- **Create separate implementation session** distinct from original `/pm:define` session
- **Session file format:** `implement-[prd-name]-[timestamp].json` in `.claude-pm/sessions/`
- **Session must reference source PRD file** for context and traceability
- **Reuse existing session persistence architecture** from current PM system
- **Enable session resumption** via `/pm:continue` if implementation is interrupted

### 4. AI-Guided Technical Questioning
- **One question at a time** following existing AI questioning patterns
- **Dynamic question flow** adapting based on responses and technical complexity
- **Support standard conversation controls:**
  - Direct answers proceed to next question
  - "skip" or "not relevant" dismisses current question
  - "skip questions" mode for assumption-based generation
  - Early completion signals ("good to go", "proceed")
- **Technical rationale provided** for each question's importance
- **Progress tracking** with topic-based indicators

### 5. PRD Enhancement
- **Append "Engineering Notes" section** to original PRD file
- **Preserve original PRD content** - no modifications to existing sections
- **Engineering Notes should include:**
  - Technical decisions made during questioning
  - Architecture choices and rationale
  - Implementation approach and key technologies
  - Risk areas and mitigation strategies
  - Dependencies and prerequisites identified
- **Maintain PRD file formatting** and structure consistency

### 6. Implementation Planning and Execution
- **Generate comprehensive coding plan** based on PRD analysis and engineering clarifications
- **Present plan to user for approval** with options to:
  - Proceed with implementation
  - Review and modify the plan
  - Save plan and implement later
- **User confirmation required** before any code changes begin
- **Context-guided Claude Code implementation:**
  - Use PRD content as primary context
  - Apply engineering notes and clarifications
  - Follow established coding patterns from codebase analysis
  - Leverage Claude Code's existing capabilities for file editing, testing, etc.

### 7. Error Handling and Recovery
- **Automatic fix attempts** for common implementation issues:
  - Missing dependencies (install via package manager)
  - Simple syntax errors (correct and retry)
  - File permission issues (suggest solutions)
  - Basic configuration problems (apply standard fixes)
- **User escalation for complex issues:**
  - Multiple failed fix attempts
  - Ambiguous error conditions
  - Architectural conflicts requiring decisions
  - Test failures requiring design changes
- **Escalation format:** Present error context, attempted fixes, and request specific guidance

## Acceptance Criteria

### File Handling
✅ **Given** a valid PRD filename,  
**When** `/pm:implement <filename>` is executed,  
**Then** the PRD is successfully loaded and parsed

✅ **Given** an invalid or missing PRD filename,  
**When** `/pm:implement <filename>` is executed,  
**Then** user sees error message, `/pm:list` output, and option to create new PRD

✅ **Given** a corrupted PRD file,  
**When** the command attempts to parse it,  
**Then** partial content is used where possible, with graceful fallback options

### Engineering Persona & Questioning
✅ **Given** a loaded PRD,  
**When** engineering analysis begins,  
**Then** AI adopts senior software engineer persona with appropriate technical depth

✅ **Given** the questioning session is active,  
**When** technical questions are presented,  
**Then** questions cover architecture, implementation, edge cases, and testing

✅ **Given** user provides answers to technical questions,  
**When** responses are processed,  
**Then** follow-up questions adapt to the technical complexity revealed

### Session Management
✅ **Given** an implementation session starts,  
**When** session file is created,  
**Then** it references the source PRD and follows established JSON format

✅ **Given** an implementation session is interrupted,  
**When** `/pm:continue <session-id>` is used,  
**Then** session resumes with full technical context restored

### PRD Updates
✅ **Given** engineering clarifications are collected,  
**When** PRD update is triggered,  
**Then** "Engineering Notes" section is appended without modifying existing content

✅ **Given** the original PRD has existing sections,  
**When** Engineering Notes are added,  
**Then** original formatting and structure are preserved

### Implementation Control
✅ **Given** engineering plan is generated,  
**When** presented to user,  
**Then** user can approve, review, or defer implementation

✅ **Given** user approves implementation,  
**When** coding begins,  
**Then** Claude Code uses PRD and engineering notes as primary context

### Error Handling
✅ **Given** common implementation errors occur,  
**When** fixes are attempted,  
**Then** automatic resolution is tried before user escalation

✅ **Given** complex or repeated errors occur,  
**When** automatic fixes fail,  
**Then** user receives error context and specific guidance request

## Implementation Notes

### File Integration
- **Command file location:** `/Users/justincopeland/code/do-product-engineering/.claude/commands/pm/pm:implement.md`
- **Follow existing PM command structure** with 7-step process adapted for engineering focus
- **Reuse session management utilities** from `pm:define.md` and `pm:continue.md`
- **Integrate with existing error handling patterns** from current PM commands

### Technical Architecture
- **Session format extends existing pattern:**
  ```json
  {
    "sessionId": "implement-[prd-name]-[timestamp]",
    "type": "implementation",
    "sourcePrd": "path/to/prd/file.md",
    "requirement": "[extracted from PRD]",
    "engineeringContext": {
      "architectureChoices": [],
      "technicalConstraints": [],
      "implementationApproach": ""
    }
  }
  ```

### Question Templates
- **Leverage existing general.md and api.md templates** as base
- **Add engineering-specific question categories:**
  - Architecture & Design Patterns
  - Technology Stack Decisions  
  - Testing & Quality Assurance
  - Performance & Scalability
  - Security & Error Handling
  - Deployment & Operations

### Claude Code Integration
- **Use existing tools:** Read, Write, Edit, MultiEdit, Bash, etc.
- **Follow established coding patterns** from codebase analysis
- **Apply CLAUDE.md instructions** for code style and conventions
- **Leverage context awareness** to maintain consistency with existing code

### Error Recovery Patterns
- **Automatic fixes for:**
  - `npm install` / `pip install` for missing dependencies
  - Syntax corrections for common patterns
  - File creation for missing directories
  - Permission adjustments where safe
- **User escalation for:**
  - Failed tests requiring logic changes
  - Architectural conflicts
  - Business logic ambiguities
  - Multi-step manual processes

## Success Metrics

### Functional Success
- **PRD-to-Code Pipeline:** Users can successfully go from PRD to working implementation
- **Technical Question Quality:** Engineering questions provide comprehensive coverage of implementation concerns
- **Error Resolution Rate:** >80% of common implementation errors resolved automatically
- **Session Continuity:** Interrupted sessions can be fully restored and continued

### User Experience Success
- **Workflow Integration:** Command fits naturally into existing PM command suite
- **Persona Authenticity:** Users report that engineering AI provides senior-level technical guidance
- **Control & Transparency:** Users feel in control of when and how implementation proceeds
- **Context Preservation:** Original PRD intent is maintained through engineering enhancement

### Technical Success
- **File System Integration:** Reliable file handling across different PRD formats and conditions
- **Session Management:** Robust session persistence and recovery
- **Claude Code Utilization:** Effective use of Claude Code's capabilities for implementation
- **Codebase Consistency:** Generated code follows existing project patterns and conventions

## TODOs

### Phase 1: Core Command Development
- [ ] Create `pm:implement.md` command file with 7-step engineering process
- [ ] Implement PRD file reading and validation logic
- [ ] Develop senior engineering AI persona with technical questioning framework
- [ ] Create implementation session management (separate from define sessions)
- [ ] Build PRD enhancement logic for Engineering Notes section

### Phase 2: Integration & Testing
- [ ] Test command integration with existing PM suite
- [ ] Validate session persistence and recovery via `/pm:continue`
- [ ] Test error handling for missing/corrupted PRDs
- [ ] Verify PRD update logic preserves original formatting
- [ ] Test Claude Code integration for actual implementation

### Phase 3: Enhancement & Polish
- [ ] Develop automatic error fix patterns for common issues
- [ ] Create user escalation workflows for complex problems
- [ ] Add progress tracking and status indicators
- [ ] Implement question template customization for engineering focus
- [ ] Add comprehensive logging and debugging capabilities

### Phase 4: Documentation & Rollout
- [ ] Update CLAUDE.md with pm:implement command documentation
- [ ] Create example workflows and use cases
- [ ] Update README and release notes
- [ ] Test with various PRD types and complexity levels
- [ ] Prepare command for distribution via install.sh

## Risk Considerations

### Technical Risks
- **PRD Parsing Complexity:** Different PRD formats may require flexible parsing logic
- **Session State Management:** Complex technical context may strain session storage format
- **Claude Code Integration:** May need careful context management to avoid overwhelming the implementation process

### User Experience Risks  
- **Overwhelming Technical Questions:** Balance comprehensive coverage with practical usability
- **Context Loss:** Engineering notes must truly enhance rather than contradict original PRD
- **Implementation Complexity:** Users may need guidance on when to use this vs. manual implementation

### Mitigation Strategies
- **Incremental Development:** Build and test core functionality before advanced features
- **User Feedback Integration:** Test with real PRDs and gather feedback on question quality
- **Fallback Options:** Always provide manual alternatives when automation fails
- **Clear Documentation:** Comprehensive examples and use cases for different scenarios

## Engineering Notes

### Architecture Decisions

**Command Structure:** Following the established `/pm:define` 7-step process pattern for consistency with existing PM command suite. This ensures familiar user experience and leverages proven session management architecture.

**Session Management:** Custom implementation session format optimized for engineering needs, separate from PRD sessions but following similar patterns. Complete question/answer tracking implemented for full resumability via `/pm:continue`.

**PRD Enhancement Strategy:** Structured Engineering Notes appended to original PRD files without modifying existing content. This preserves the original product vision while adding technical context for implementation.

**Error Handling Philosophy:** Leverage Claude Code's existing error handling capabilities with clear instructions rather than building complex retry logic into the command itself.

### Implementation Approach

**Phase-Based Development:**
1. **Infrastructure Phase:** Enhanced session management with complete question tracking
2. **Core Command Phase:** Engineering AI persona with technical questioning framework  
3. **Integration Phase:** PRD enhancement and Claude Code handoff mechanism
4. **Testing Phase:** End-to-end validation with real PRDs

**File Organization:**
- **Main Command:** `/Users/justincopeland/code/do-product-engineering/.claude/commands/pm/pm:implement.md`
- **Sessions:** `.claude-pm/sessions/implement-[prd-name]-[timestamp].json`
- **Enhanced PRDs:** Original files in `.claude-pm/plans/` with appended Engineering Notes

**Handoff Strategy (v1):** Simple "hand-off and exit" approach where `/pm:implement` prepares enhanced PRD context and exits, allowing Claude Code to handle implementation with clear guidance.

### Technical Constraints

**Session Data Completeness:** All questions and answers must be preserved in session files to enable proper resumption and audit trails. Current PM system has inconsistent question storage that needs to be addressed.

**PRD Format Flexibility:** Must handle varying PRD formats and corrupted files gracefully with fallback to `/pm:list` and `/pm:define` options.

**Command Integration:** Must integrate seamlessly with existing PM command suite (`/pm:continue`, `/pm:list`, `/pm:status`) without breaking existing functionality.

**Memory Management:** Large engineering sessions with complex technical context may require careful session file size management and archival strategies.

### Security Considerations

**File Access Patterns:** Command needs read access to `.claude-pm/plans/` and write access to session directory and PRD files for Engineering Notes appending.

**Session Data Sensitivity:** Engineering sessions may contain sensitive technical decisions and architectural choices that should be handled with same security as existing PM sessions.

**Input Validation:** PRD filename arguments must be validated and sanitized to prevent directory traversal or malicious file access.

**Error Information Disclosure:** Error messages should be helpful without exposing sensitive file system information or internal command structure.

### Testing Strategy

**Unit Testing Approach:**
- **PRD Parser:** Test with valid, invalid, corrupted, and missing PRD files
- **Session Management:** Validate complete question/answer persistence and recovery
- **Engineering Notes:** Verify structured appending without content corruption
- **Error Handling:** Test graceful fallback scenarios

**Integration Testing:**
- **PM Command Suite:** Ensure seamless integration with existing commands
- **Session Continuity:** Test `/pm:continue` functionality with implementation sessions  
- **File System Operations:** Validate file access patterns and permission handling
- **End-to-End:** Complete workflow from PRD input to Claude Code handoff

**User Acceptance Testing:**
- **Engineering Persona Quality:** Validate that technical questions provide senior-level guidance
- **Implementation Context:** Ensure Engineering Notes improve implementation outcomes
- **User Experience:** Confirm command feels natural within PM workflow

### Risk Areas

**Session Complexity Scaling:** Engineering sessions may become more complex than PRD sessions, potentially straining the JSON-based storage format. Monitor session file sizes and consider archival strategies.

**Question Quality Consistency:** Engineering questions must provide value across diverse feature types and complexity levels. Risk of either too generic or overly specific questioning patterns.

**PRD Enhancement Integration:** Engineering Notes must truly enhance rather than contradict original PRD content. Risk of context conflicts during implementation phase.

**Claude Code Context Management:** Risk of overwhelming Claude Code with too much context or providing insufficiently structured guidance for effective implementation.

**Future Enhancement Path:** Current simple handoff approach may limit future development of more sophisticated implementation coordination. Architecture should accommodate future orchestration capabilities.

**Command Performance:** Complex engineering analysis and question generation may impact command responsiveness, especially for large PRDs or extensive codebase analysis.

### Dependencies and Prerequisites

**Existing PM System:** Requires functional `.claude-pm/` directory structure, session management, and existing PM commands (`/pm:list`, `/pm:continue`).

**Claude Code Integration:** Depends on Claude Code's file editing, testing, and implementation capabilities. No additional external dependencies required.

**Session Format Migration:** May require updating existing session handling to support complete question/answer tracking across all PM commands.

### Future Enhancement Opportunities

**V2 Implementation Orchestration:** Evolution from "hand-off and exit" to active implementation coordination where `/pm:implement` maintains oversight during coding phase.

**Advanced Error Recovery:** More sophisticated error handling patterns with learning from common implementation failures.

**Question Template Customization:** Domain-specific engineering question sets for different types of features (auth, CRUD, UI, API, etc.).

**Implementation Metrics:** Tracking and analytics on engineering question effectiveness and implementation success rates.

**Collaborative Features:** Multi-engineer review capabilities and shared engineering context across team members.