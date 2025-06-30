# PM List - Show Existing Plans

List all existing PRD plans in the current project.

## Task: Display Plans

1. **Check for plans directory**
   - Look for `.claude-pm/plans/` in the current project
   - If it doesn't exist, inform the user no plans exist yet

2. **List all plan files**
   - Find all `.md` files in `.claude-pm/plans/`
   - Extract key information from each plan:
     - Plan name (from filename)
     - Creation date
     - Status
     - Brief description (from Context section)
     - Complexity estimate

3. **Display formatted list**
   Show plans in a clear, organized format:
   ```
   ## Existing Plans

   ### [Plan Name] - [Status]
   **Created:** [Date] | **Complexity:** [1-5] | **File:** [filename]
   [Brief description from Context section]

   ---
   ```

4. **Provide next steps**
   - Suggest using `/pm:continue [filename]` to resume a plan
   - Suggest using `/pm "[requirement]"` to create a new plan

Begin listing plans now.