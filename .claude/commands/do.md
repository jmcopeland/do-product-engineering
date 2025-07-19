# Do - Intelligent Workflow Router

Intelligently route users through the Do:PE AI development lifecycle workflow based on input analysis and existing files.

## Task: Smart Workflow Routing and User Choice

Given the user input: "$ARGUMENTS"

### 🔍 Step 1: Input Analysis and File Detection

**Parse and analyze the input to determine context:**

1. **Input Type Detection**:
   - Check if input appears to be a file reference (ends with .md or exists as file)
   - Extract the core concept/feature name for file searching
   - Clean and normalize the input for consistent analysis

2. **File System Scanning**:
   - Check `.do/ideas/` for related idea files
   - Check `.do/validations/` for related validation files
   - Check `.do/plans/` for related plan files
   - Look for exact matches and fuzzy matches based on keywords

3. **Context Determination**:
   ```bash
   # Extract core concept from input for file searching
   CONCEPT=$(echo "$ARGUMENTS" | sed 's/\.md$//' | tr '[:upper:]' '[:lower:]' | sed 's/[^a-z0-9]/-/g' | sed 's/--*/-/g' | sed 's/^-\|-$//g')
   
   # Check for existing files in order of workflow
   IDEA_FILES=$(find .do/ideas/ -name "*${CONCEPT}*" -type f 2>/dev/null || true)
   VALIDATION_FILES=$(find .do/validations/ -name "*${CONCEPT}*" -type f 2>/dev/null || true)
   PLAN_FILES=$(find .do/plans/ -name "*${CONCEPT}*" -type f 2>/dev/null || true)
   ```

### 🎯 Step 2: Smart Routing Logic

**Determine the recommended next step based on analysis:**

1. **If input is a specific existing file**:
   - **Idea file** (.do/ideas/*): → Recommend **validate**
   - **Validation file** (.do/validations/*): → Recommend **plan**
   - **Plan file** (.do/plans/*): → Recommend **design** or **review**

2. **If input is text description**:
   - **No related files found**: → Recommend **think** (capture the idea first)
   - **Idea files exist**: → Recommend **validate** (move to next step)
   - **Validation files exist**: → Recommend **plan** (move to next step)
   - **Plan files exist**: → Recommend **design** or **review** (move to next step)

3. **Fallback**: When unclear → Default to **think** (safest starting point)

### 📋 Step 3: Present Recommendation and Options

**Show user the intelligent recommendation with full workflow options:**

```
🤖 Smart Routing Analysis

Input: "$ARGUMENTS"
```

**Display recommendation based on analysis:**

```
💡 Recommendation: [RECOMMENDED_STEP]
Reason: [WHY_THIS_STEP]

🚀 Choose your next step:
1. ✅ Continue with recommendation → /do:[RECOMMENDED_STEP]
2. 💡 Capture idea → /do:think
3. ✅ Validate idea → /do:validate  
4. 📋 Plan feature → /do:plan
5. 🎨 Design UI/UX → /do:design
6. 🔍 Review engineering → /do:review
7. 🚀 Build feature → /do:build
8. ❌ Cancel

Choose (1-8): 
```

**Context-specific recommendations:**

- **For new ideas**: "Start by capturing this idea properly for future reference"
- **For existing ideas**: "Validate if this idea should be built before planning"
- **For validated features**: "Create a detailed PRD with AI-powered questioning"
- **For planned features**: "Analyze UI/UX design requirements" or "Review technical implementation"
- **For reviewed plans**: "Begin feature implementation"

### 🚀 Step 4: Execute User Choice

**Based on user selection, execute the appropriate command:**

1. **Parse user input** (1-8 or direct command)
2. **Map selection to command**:
   - 1 → Execute recommended step
   - 2 → `/do:think "$ARGUMENTS"`
   - 3 → `/do:validate "$ARGUMENTS"`
   - 4 → `/do:plan "$ARGUMENTS"`
   - 5 → `/do:design "$ARGUMENTS"`
   - 6 → `/do:review "$ARGUMENTS"`
   - 7 → `/do:build "$ARGUMENTS"`
   - 8 → Exit gracefully

3. **Execute the chosen command** with original arguments
4. **Handle invalid selections** gracefully with helpful guidance

### 🔧 Implementation Steps

**Execute the following workflow:**

1. **Analyze the Input**:
   - Use Glob tool to search for related files in `.do/ideas/`, `.do/validations/`, and `.do/plans/`
   - Extract core concept from the input for file matching
   - Check if input is a direct file reference

2. **Determine Smart Recommendation**:
   - If plan files exist → Recommend "design" (UI/UX analysis next)
   - If validation files exist → Recommend "plan" (create PRD next)  
   - If idea files exist → Recommend "validate" (validate idea next)
   - If no related files → Recommend "think" (capture idea first)

3. **Present Interactive Menu**:
   - Show the analysis and recommendation clearly
   - Display numbered options (1-8) for user selection
   - Wait for user input to choose next step

4. **Execute User Choice**:
   - Map user selection to appropriate `/do:` command
   - Use the original `$ARGUMENTS` when executing the chosen command
   - Handle invalid selections gracefully

**File Search Patterns**:
- Search for files containing keywords from the input
- Handle common variations and synonyms
- Prioritize exact matches over fuzzy matches
- Show found files in the recommendation context

**User Interaction Flow**:
- Present clear recommendation with reasoning
- Offer full workflow options for flexibility  
- Execute chosen step immediately with proper arguments
- Provide helpful guidance for invalid choices

Begin analysis and present the interactive routing menu to the user.