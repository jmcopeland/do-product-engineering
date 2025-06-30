# PM Continue - Resume Existing Plan

Resume work on an existing PRD plan or continue an interrupted session.

## Task: Continue Plan Development

Target plan: "$ARGUMENTS"

### 1. Load Existing Plan
- Look for the specified plan file in `.claude-pm/plans/`
- If filename not provided, list available plans and ask user to choose
- Read the current plan content and status

### 2. Determine Continuation Point
Based on the plan's current state:

**If plan is incomplete:**
- Review existing requirements and context
- Identify what questions still need to be asked
- Continue the interactive questioning process
- Fill in missing sections

**If plan is complete but needs updates:**
- Show current plan summary
- Ask what aspects need modification
- Update relevant sections
- Maintain version history

**If plan is ready for implementation:**
- Confirm the plan is still current
- Ask if any changes are needed before proceeding
- Offer to begin implementation or make adjustments

### 3. Interactive Session Management
- Resume questioning where it left off
- Maintain context from previous session
- Handle any changes in project state since last session
- Update plan sections as needed

### 4. Save Progress
- Update the existing plan file with new information
- Maintain creation timestamp but update modification date
- Preserve any implementation notes or progress

### 5. Next Steps
After updating the plan:
- Confirm changes with the user
- Ask if they want to continue development or make further adjustments
- Provide clear status of what's been completed

Begin continuation process now for: "$ARGUMENTS"