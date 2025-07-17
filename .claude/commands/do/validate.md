# Do Validate - Feature Validation Workflow

Validate feature ideas before detailed planning using lean methodology adapted for feature validation.

## Task: Feature Validation with Lean Principles

Given the user requirement: "$ARGUMENTS"

### 🎛️ Argument Parsing and Type Override (Step 0)
**Parse command arguments and handle type override:**

1. **Extract template flag first (preserve flags before file resolution)**:
   ```bash
   # Extract and preserve --type flag from original arguments
   TYPE_FLAG=""
   if [[ "$ARGUMENTS" =~ --type=([a-zA-Z]+) ]]; then
     TYPE_FLAG="${BASH_REMATCH[1]}"
     # Remove type flag for cleaner processing
     CLEAN_ARGS="${ARGUMENTS/--type=$TYPE_FLAG/}"
     CLEAN_ARGS="${CLEAN_ARGS%% }" # Trim trailing space
   else
     CLEAN_ARGS="$ARGUMENTS"
   fi
   ```

2. **File Detection and Content Resolution**:
   ```bash
   # Detect and resolve file reference (same logic as /do:plan)
   if [[ "$CLEAN_ARGS" == *.md ]] || [[ -f "$CLEAN_ARGS" ]]; then
     # File detection logic...
     if [[ "$CLEAN_ARGS" == /* ]] || [[ "$CLEAN_ARGS" == ./* ]]; then
       FILE_PATH="$CLEAN_ARGS"
     else
       if [[ -f ".do/ideas/$CLEAN_ARGS" ]]; then
         FILE_PATH=".do/ideas/$CLEAN_ARGS"
       elif [[ -f "$CLEAN_ARGS" ]]; then
         FILE_PATH="$CLEAN_ARGS"
       else
         echo "❌ Idea file not found: $CLEAN_ARGS"
         echo ""
         echo "Searched locations:"
         echo "• .do/ideas/$CLEAN_ARGS"
         echo "• ./$CLEAN_ARGS"
         echo ""
         echo "💡 Options:"
         echo "• Check available ideas: /do:think"
         echo "• Use full path: /do:validate /path/to/file.md"
         echo "• Input directly: /do:validate \"your requirement here\""
         exit 1
       fi
     fi
     
     FILE_CONTENT=$(cat "$FILE_PATH" 2>/dev/null)
     if [[ -z "$FILE_CONTENT" ]]; then
       echo "⚠️ File is empty or unreadable: $FILE_PATH"
       echo ""
       echo "Would you like to input the requirement manually instead?"
       exit 1
     fi
     
     # Use file content as the requirement
     REQUIREMENT="$FILE_CONTENT"
   else
     # Direct text input
     REQUIREMENT="$CLEAN_ARGS"
   fi
   ```

**BEFORE STARTING: Use TodoWrite to create a plan with all mandatory steps**

Use the TodoWrite tool to create todos for each mandatory step:
1. "🚨 CRITICAL: Create validation session file (NEVER SKIP)"
2. "Detect validation type (product vs feature)"
3. "Determine validation depth (lightweight vs full)"
4. "Load appropriate question template"
5. "Conduct sequential validation questioning"
6. "Calculate validation score"
7. "Generate Lean Validation Document (LVD)"
8. "Archive session and present results"

Mark each step as "in_progress" when starting and "completed" when finished.

### 🚨 CRITICAL: Session Creation (MANDATORY - DO NOT SKIP) 🚨
**⚠️ STOP! READ THIS FIRST! ⚠️**

**SESSION CREATION IS ABSOLUTELY MANDATORY. NO EXCEPTIONS. EVER.**

1. **Create session directory if needed**: Ensure `.do/sessions/` exists
2. **Generate session ID**: `validate-[requirement-slug]-[YYYYMMDD-HHMMSS]`
3. **Create initial session file** immediately with status "initializing"
4. **If session creation fails**: STOP and report error to user
5. **VERIFY**: Session file exists before proceeding to Step 1

**IF YOU SKIP SESSION CREATION, YOU ARE VIOLATING A CRITICAL REQUIREMENT.**

### Step 1: Validation Type Detection
Intelligently detect whether this is a product or feature validation:

1. **Analyze requirement text for signals**:
   - **Product signals**: "startup idea", "new platform", "create app", "new product", "build a", standalone concepts
   - **Feature signals**: "add to", "improve our", "enhance", "existing", "current system", "update"

2. **Perform codebase analysis** (fast scan):
   ```
   # Quick check for codebase size
   if [[ -f "package.json" ]] || [[ -f "requirements.txt" ]] || [[ -f "Cargo.toml" ]]; then
     # Check if it's just a scaffold
     FILE_COUNT=$(find . -type f -name "*.js" -o -name "*.py" -o -name "*.rs" | head -20 | wc -l)
     if [[ $FILE_COUNT -lt 5 ]]; then
       CODEBASE_SIZE="empty"
     elif [[ $FILE_COUNT -lt 20 ]]; then
       CODEBASE_SIZE="small"
     else
       CODEBASE_SIZE="large"
     fi
   else
     CODEBASE_SIZE="empty"
   fi
   ```

3. **Present detection recommendation**:
   ```
   🎯 Validation Type Detection
   
   Analyzing: "[requirement snippet]"
   
   Detected signals:
   • Product indicators: [list any found]
   • Feature indicators: [list any found]
   • Codebase analysis: [empty|small|large] project
   
   📊 Recommendation: [Product|Feature] validation (confidence: [high|medium|low])
   
   Is this correct? (y/n)
   Alternative: manually select (p)roduct or (f)eature
   ```

4. **Handle user response**:
   - If confirmed: proceed with detected type
   - If override: use user's selection
   - Update session with validation type

### Step 2: Validation Depth Selection
Determine lightweight vs full validation based on complexity:

1. **Analyze complexity indicators**:
   - **High complexity signals**: "integration", "real-time", "collaborative", "payment", "security"
   - **Business risk signals**: "customer-facing", "revenue", "compliance", "data privacy"
   - **Effort signals**: "architecture", "new technology", "migration", "refactor"

2. **Present depth recommendation**:
   ```
   🎯 Validation Depth Recommendation: [Full|Lightweight] validation
   
   Detected factors:
   • Complexity: [low|medium|high] - [reason]
   • Business risk: [low|medium|high] - [reason]
   • Development effort: [low|medium|high] - [reason]
   
   Full validation includes:
   • Comprehensive problem analysis
   • Detailed solution validation
   • Market opportunity assessment
   • Resource and risk evaluation
   
   Proceed with [full|lightweight] validation? (y/n)
   Alternative: choose (f)ull or (l)ightweight
   ```

3. **Update session with depth selection**

### Step 3: Load Validation Questions
Load appropriate question template based on type and depth:

1. **Template selection**:
   - Product validation: Load `.do/questions/validate_product.md`
   - Feature validation: Load `.do/questions/validate_feature.md`

2. **Apply depth filtering**:
   - Lightweight: Filter to essential questions only (priority: high)
   - Full: Include all questions

3. **Prepare question queue** with rationale for each question

### Step 4: Sequential Validation Questioning
Conduct intelligent questioning flow:

1. **Initialize questioning**:
   ```
   🚀 Starting [Product|Feature] Validation
   
   I'll ask targeted questions to validate this [product idea|feature].
   Your responses will help determine if this should be built.
   
   🎯 Control the conversation:
   • Answer normally to proceed
   • Say "good to go" when ready to finish
   • Say "skip" to pass on a question
   • Say "explain" for more context
   
   Ready to start? (📝 Estimated: [N] questions)
   ```

2. **Question presentation loop**:
   ```
   ❓ Question [N] • [Category] • Progress: [====>    ]
   
   [Question text]
   
   🧠 Context: [Why this matters for validation]
   ```

3. **Response handling**:
   - Save each answer to session
   - Update progress tracking
   - Handle control signals (skip, explain, good to go)

4. **Auto-save after each question**

### Step 5: Validation Score Calculation
Calculate validation score based on responses:

1. **Load scoring configuration** from `.do/templates/validation_score.md`

2. **Analyze responses for each criterion**:
   - Problem Severity (25%): Analyze pain point responses
   - Solution Confidence (25%): Evaluate solution fit answers
   - Strategic Alignment (20%): Assess business alignment
   - Resource Efficiency (15%): Consider effort vs impact
   - Market Opportunity (15%): Evaluate market potential

3. **Calculate weighted score**:
   ```
   📊 Validation Score Calculation
   
   Problem Severity:     [1-5] × 25% = [score]
   Solution Confidence:  [1-5] × 25% = [score]
   Strategic Alignment:  [1-5] × 20% = [score]
   Resource Efficiency:  [1-5] × 15% = [score]
   Market Opportunity:   [1-5] × 15% = [score]
   
   Final Score: [X.X] / 5.0
   ```

4. **Determine recommendation**:
   - 4.0+: Strong Go (high confidence)
   - 3.0-3.9: Conditional Go (proceed with caution)
   - 2.0-2.9: Weak No (significant concerns)
   - <2.0: Strong No (do not proceed)

### Step 6: Generate Lean Validation Document (LVD)
Create comprehensive validation document:

1. **Generate filename**: `do-[feature-name]-validation-[YYYYMMDD-HHMMSS].md`

2. **Create LVD content** using lean template adapted for validation:
   - Executive summary with go/no-go recommendation
   - Problem analysis from responses
   - Solution validation insights
   - Market/user segment findings
   - Success metrics and measurement plan
   - Resource requirements estimate
   - Risk assessment
   - Validation score breakdown
   - Next steps

3. **Write LVD to** `.do/validations/` directory

4. **Verify file creation**

### Step 7: Present Results and Next Steps
Finalize validation and guide next actions:

1. **Archive session** to `.do/sessions/archive/`

2. **Present validation summary**:
   ```
   ✅ Validation Complete!
   
   📄 **File:** [filename]
   📊 **Score:** [X.X]/5.0 - [Recommendation]
   
   🎯 **Key Findings:**
   • Problem: [severity insight]
   • Solution: [confidence level]
   • Market: [opportunity summary]
   
   ⚠️ **Main Concerns:**
   • [Top risk or concern]
   • [Secondary concern]
   
   🚀 **Next Steps:**
   [If Go]: Ready for planning! Run: /do:plan [validation-file]
   [If No]: Consider pivoting or addressing concerns first
   [If Conditional]: Address concerns before proceeding
   
   💡 View validation details: /do:view [filename]
   ```

## Configuration-Driven Behavior

The process adapts based on `.do/config.json` settings:

- **validationDepth**: Default depth preference (lightweight/full)
- **autoTypeDetection**: Enable/disable automatic type detection
- **scoringWeights**: Custom scoring criterion weights
- **validationThreshold**: Custom go/no-go thresholds

## Error Handling and Fallbacks

### Session Management Errors
- **Session creation failure**: STOP immediately, report error
- **Session corruption**: Backup and start fresh
- **Auto-save failures**: Warn but continue, save to backup

### Detection Errors
- **Ambiguous type**: Default to feature validation (more common)
- **Codebase analysis timeout**: Skip and use text analysis only
- **Override handling**: Always respect user choice

### Question Loading Errors
- **Missing templates**: Create basic validation questions inline
- **Corrupted templates**: Use fallback general questions
- **Empty templates**: Report error and guide fix

### Scoring Errors
- **Missing scoring config**: Use default weights
- **Calculation errors**: Show raw responses, skip scoring
- **Invalid responses**: Treat as neutral (3/5) score

### File Generation Errors
- **Directory creation failure**: Report permissions issue
- **File write failure**: Save to alternate location
- **Verification failure**: Warn but show content

---

**Begin the validation process now with**: "$ARGUMENTS"