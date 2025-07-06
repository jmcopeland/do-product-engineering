# Do Think - Quick Idea Capture

Quickly capture and list ideas for later development through the Do:PE AI workflow.

## Task: Dual-Mode Idea Management

Given the arguments: "$ARGUMENTS"

**Determine operation mode and execute appropriate logic:**

### Mode 1: List Ideas (No Arguments)
If no arguments are provided, display all captured ideas:

1. **Check for ideas file existence**:
   - Look for `.do/ideas/ideas.md`
   - If file doesn't exist, show encouraging first-use message

2. **Display ideas list**:
   - Show header: "💡 Your Ideas"
   - Display contents of `.do/ideas/ideas.md`
   - Include corresponding individual filenames for each idea

3. **Show next steps and capture syntax**:
   ```
   🚀 Next steps for any idea:
   • /do:validate <idea-filename>
   • /do:plan <idea-filename>

   💡 Add new idea: /do:think "your new idea here"
   ```

4. **Handle empty ideas file gracefully**:
   ```
   💡 No ideas captured yet!

   Start capturing ideas with:
   /do:think "your new idea here"
   ```

### Mode 2: Capture Idea (Arguments Provided)
If arguments are provided, execute idea capture with atomic operations:

1. **Input validation**:
   - Extract idea text from $ARGUMENTS
   - Check if idea text is empty
   - If empty, show usage message and exit

2. **Setup and preparation**:
   - Create `.do/ideas/` directory if it doesn't exist (use `mkdir -p .do/ideas`)
   - Generate timestamp: use `date +"%Y%m%d-%H%M%S"`
   - Generate intelligent slug:
     - Extract meaningful keywords from idea text (skip common words like "a", "the", "to", "for", "of")
     - Convert to lowercase, replace spaces with hyphens
     - Remove special characters, keep only alphanumeric and hyphens
     - Truncate to 47 characters maximum (leaving room for timestamp)
     - Remove leading/trailing hyphens and consolidate multiple hyphens
     - If slug is empty or invalid, use fallback "idea"

3. **Create filenames**:
   - Individual file: `idea-{timestamp}-{slug}.md`
   - Full path: `.do/ideas/idea-{timestamp}-{slug}.md`
   - Central list: `.do/ideas/ideas.md`

4. **Save individual idea file first** (higher success rate):
   - Write plain text idea content to individual file
   - Implement 3-attempt retry logic with brief delays
   - If all attempts fail, show error and exit with clear guidance

5. **Atomic append to central ideas list**:
   - Create bullet point entry on a new line: `• {idea text} ({individual filename})`
   - Use atomic operation with temp file approach:
     - If ideas.md exists: copy to ideas.md.tmp, append bullet point, rename to ideas.md
     - If ideas.md doesn't exist: create new file with header "# Ideas" and bullet point
   - Implement 3-attempt retry logic
   - If all attempts fail: save to `.do/ideas/failed-ideas.tmp` for manual recovery

6. **User feedback and next steps**:
   ```
   💡 Idea saved successfully!

   📄 File: {filename}

   📋 Added to ideas list: .do/ideas/ideas.md

   🚀 Next steps:
   • Validate idea: /do:validate {filename}
   • Plan feature: /do:plan {filename}  
   • View all ideas: /do:think
   ```

### Error Handling

**For permission errors**:
```
❌ Permission denied accessing .do/ideas/

Try: chmod 755 .do/ideas/
Or: Check directory ownership and permissions
```

**For disk space errors**:
```
❌ No space left on device

Free up disk space and try again
```

**For central list failures**:
```
⚠️ Failed to update central ideas list. Idea saved to failed-ideas.tmp

Your individual idea file was saved successfully.
```

**For empty input**:
```
💡 What's your idea?
Usage: /do:think "your idea here"
```

### Implementation Details

**Slug generation logic**:
- Use bash string manipulation to clean and format idea text
- Skip common stop words (a, an, the, to, for, of, in, on, at, by, with)
- Priority: meaningful keywords over truncation
- Ensure filesystem safety across platforms
- Remove leading/trailing hyphens and consolidate multiple hyphens
- Provide fallback for edge cases

**Atomic operations**:
- Always save individual file first (higher success rate)
- Use temp file pattern for central list updates
- Implement proper cleanup of temp files on failure
- Multiple retry attempts with brief delays

**Performance requirements**:
- Complete execution in under 2 seconds
- Minimize file operations and processing time
- Use efficient bash operations

**Integration compatibility**:
- Individual files contain only plain text idea content
- No headers or metadata in individual files
- Files work directly as input to /do:validate and /do:plan

Begin execution based on argument presence: if arguments provided, execute capture mode; if no arguments, execute list mode.