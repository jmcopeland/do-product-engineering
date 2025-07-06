# PM List - Show Existing Plans

List all existing PRD plans in the current project with optimized caching for sub-second performance.

## Task: Execute Smart Cached Listing

### Step 1: Simple Cache Validation
Check if cache needs updating by comparing file modification times:

1. **Check cache exists** - Look for `.do/.cache/list-cache.txt`
2. **Find newest files & compare** - Use: `ls -t .do/plans/*.md .do/.cache/list-cache.txt 2>/dev/null | head -1`
3. **Cache validation logic** - If result ends with "list-cache.txt", cache is valid and use it; otherwise rebuild cache
4. **No time calculations** - Just direct file timestamp comparisons via ls -t sorting

### Step 2: Display Results (Native Claude Output)
Based on cache validation, either:

**If cache is valid:**
- Read and display cached results with "⚡ Using cached results" message
- Show native formatted output in Claude

**If cache is invalid:**  
- Count plan files in `.do/plans/`
- Count active session files (only top-level `.do/sessions/*.json`, not archived)
- Build fresh formatted output
- Save to cache file `.do/.cache/list-cache.txt`
- Display results natively with "🔄 Cache updated" message

### Step 3: Output Format (Always Native)
```
⚡ Using cached results | 🔄 Cache updated

## Plans Overview

**Total Plans:** [count] | **Active Sessions:** [count] | **Ready for Development:** [ready] | **Implemented:** [done]

---

## Plans

### [Status Icon] [Plan Name]

file: [filename]

[Brief description]

**Created:** [Date] | **Updated:** [Date] | **Status:** [Status Icon] [Status]

---

```

Begin smart cache validation and native display now.