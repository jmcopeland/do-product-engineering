# PM List - Show Existing Plans

List all existing PRD plans in the current project.

## Task: Display Plans and Sessions

1. **Check for active sessions first**
   - Look for `.claude-pm/sessions/` directory
   - Find sessions with `"status": "in-progress"`
   - Show active sessions at top of list

2. **List completed plans**
   - Find all `.md` files in `.claude-pm/plans/`
   - Extract key information from each plan:
     - Plan name (from filename)
     - Creation date and last updated
     - Status and completion level
     - Brief description (from Context section)
     - Complexity estimate
     - Questioning mode used (template vs AI-powered)

3. **Display formatted list**
   Show active sessions and plans in organized format:
   ```
   ## Plans Overview
   
   **Total Plans:** [count] | **Active Sessions:** [count] | **Ready for Development:** [ready] | **Implemented:** [done]
   
   ---
   
   ## Active Sessions
   
   ### 🔄 [Requirement] - In Progress
   [Brief description of what's being planned]
   **Started:** [timestamp] | **Questions:** [N asked/~M total] | **Session ID:** [session-id]
   
   ---
   
   ## Plans

   ### [Status Icon] [Plan Name]
   
   [Brief description from Context section]
   
   **Created:** [Date] | **Updated:** [Date] | **Status:** [Status Icon] [Ready/In Development/Implemented]

   ---
   ```

4. **Plan Status Categories**
   - **Ready for Development** 📋 - PRD complete, ready to implement
   - **In Development** 🚧 - Currently being developed
   - **Implemented** ✅ - Feature has been developed and deployed
   
5. **Show summary statistics**
   - Total active sessions
   - Plans by status category
   - Most recent activity

6. **Provide next steps**
   - For active sessions: `/continue [session-id]` to resume questioning
   - For completed plans: `/continue [filename]` to modify a plan
   - To start new: `/pm "[requirement]"` to create a new plan

Begin listing sessions and plans now.