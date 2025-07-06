# Do Build - Feature Implementation

Implement features based on enhanced PRDs with engineering context from the review phase.

## Task: Feature Implementation

Given the PRD filename: "$ARGUMENTS"

### Step 1: PRD Loading and Validation
Load the enhanced PRD file with engineering context:

1. **Parse PRD filename and validate**:
   - Handle both full paths and just filenames
   - Add `.md` extension if missing
   - Check if file exists in `.do/plans/` directory

2. **Handle missing or invalid PRD files**:
   ```
   ❌ PRD file not found: [filename]
   
   Let me show you available PRDs:
   [Run /do:list command to show available files]
   
   💡 Options:
   • Use an existing PRD from the list above
   • Create a new PRD with: /do:plan "[your requirement]"
   • Review an existing PRD with: /do:review [prd-filename]
   ```

3. **Validate PRD has engineering context**:
   - Check for "Engineering Notes" section
   - If missing, suggest running /do:review first:
     ```
     ⚠️ This PRD hasn't been reviewed by engineering yet.
     
     For best results, run the engineering review first:
     /do:review [prd-filename]
     
     This will add technical context and implementation guidance.
     
     Continue with implementation anyway? (y/n)
     ```

### Step 2: Extract Implementation Context
Parse the enhanced PRD for implementation guidance:

1. **Extract core requirements**:
   - User stories and acceptance criteria
   - Functional requirements
   - Success metrics and validation criteria

2. **Extract engineering context**:
   - Technical architecture decisions
   - Implementation strategy and approach
   - Security and performance requirements
   - Testing strategy and quality gates

3. **Extract technical constraints**:
   - Framework and library choices
   - Integration patterns and dependencies
   - Code organization and patterns
   - Deployment and monitoring requirements

### Step 3: Implementation Planning
Create a detailed implementation plan based on the PRD:

1. **Break down implementation phases**:
   - Identify logical implementation chunks
   - Determine dependencies and order
   - Estimate complexity and effort
   - Plan incremental delivery approach

2. **Identify implementation tasks**:
   - Database schema changes
   - API endpoint creation/modification
   - Frontend component development
   - Integration and testing work

3. **Prepare implementation context**:
   - Set up development environment requirements
   - Identify files and components to modify
   - Prepare testing and validation approach
   - Plan error handling and edge cases

### Step 4: Feature Implementation
Execute the implementation following the PRD guidance:

1. **Present implementation plan**:
   ```
   🚀 Starting Feature Implementation
   
   📋 **Feature:** [Feature name from PRD]
   📄 **Source:** [PRD filename]
   
   🏗️ **Implementation Approach:**
   • Architecture: [Key architectural decisions from Engineering Notes]
   • Implementation: [High-level technical approach]
   • Security: [Security considerations]
   • Testing: [Testing strategy]
   
   🔧 **Implementation Plan:**
   1. [Phase 1 description]
   2. [Phase 2 description]
   3. [Phase 3 description]
   
   📝 **Files to modify:** [List of anticipated file changes]
   
   Beginning implementation now...
   ```

2. **Execute implementation with Claude Code**:
   - Use the enhanced PRD as primary context
   - Follow engineering decisions and architectural choices
   - Implement security and performance requirements
   - Apply testing strategy from engineering notes
   - Handle errors automatically where possible
   - Escalate complex issues for user guidance

3. **Implementation guidance for Claude Code**:
   ```
   Please implement this feature following the PRD requirements and Engineering Notes.
   
   Key implementation context:
   • Follow the architectural decisions documented in Engineering Notes
   • Implement security measures as specified
   • Apply the testing strategy outlined
   • Use the code patterns and conventions identified
   • Handle errors gracefully and provide user feedback
   
   Attempt to fix any errors automatically, but ask for guidance if issues become complex or unclear. Ask any additional clarifying questions as needed.
   ```

### Step 5: Implementation Validation
Validate the implementation against PRD requirements:

1. **Acceptance criteria validation**:
   - Verify each acceptance criterion is met
   - Test user stories and workflows
   - Validate functional requirements
   - Check non-functional requirements

2. **Engineering requirements validation**:
   - Verify security implementations
   - Test performance requirements
   - Validate integration points
   - Check error handling and resilience

3. **Code quality validation**:
   - Run linting and formatting checks
   - Execute unit and integration tests
   - Validate code patterns and conventions
   - Check documentation and comments

### Step 6: Implementation Summary and Next Steps
Provide implementation summary and suggest next steps:

1. **Implementation summary**:
   ```
   ✅ Feature Implementation Complete!
   
   📋 **Feature:** [Feature name]
   📄 **Based on:** [PRD filename]
   
   🎯 **Implementation Results:**
   • ✅ All acceptance criteria met
   • ✅ Engineering requirements implemented
   • ✅ Testing strategy applied
   • ✅ Security measures in place
   
   📊 **Quality Metrics:**
   • Code quality: [Status]
   • Test coverage: [Coverage percentage]
   • Performance: [Performance metrics]
   • Security: [Security validation]
   
   🚀 **Next Steps:**
   1. **Test** - Run comprehensive testing with: /do:test [feature-name]
   2. **Review** - Code review and quality validation
   3. **Ship** - Prepare for deployment when ready
   
   Implementation ready for testing and review!
   ```

2. **Generate implementation notes**:
   - Document implementation decisions
   - Record any deviations from the PRD
   - Note technical debt or future improvements
   - Provide maintenance and troubleshooting guidance

## Configuration-Driven Behavior

The implementation process adapts based on `.do/config.json` settings:

- **implementationDepth**: Controls thoroughness of implementation
- **autoTesting**: Automatically run tests after implementation
- **codeQuality**: Enforce code quality standards
- **incrementalDelivery**: Break implementation into smaller chunks

## Error Handling and Fallbacks

### PRD Loading Errors
- **File not found**: Show available PRDs and suggest alternatives
- **Missing engineering context**: Suggest running /do:review first
- **Invalid format**: Provide guidance on PRD structure requirements

### Implementation Errors
- **Compilation errors**: Attempt automatic fixes with user escalation
- **Test failures**: Analyze and fix test issues
- **Integration failures**: Identify and resolve integration problems
- **Performance issues**: Apply optimization strategies from engineering notes

### Quality Validation Errors
- **Code quality issues**: Apply automatic formatting and linting
- **Test coverage gaps**: Identify missing test scenarios
- **Security vulnerabilities**: Apply security measures from engineering notes
- **Performance bottlenecks**: Optimize based on engineering guidance

---

**Begin the feature implementation process now with**: "$ARGUMENTS"