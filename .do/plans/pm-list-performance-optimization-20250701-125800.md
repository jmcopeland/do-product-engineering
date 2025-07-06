# PM List Performance Optimization PRD

**Created:** 2025-07-01  
**Complexity Estimate:** 2/5  
**Status:** ✅ Completed

## Context

The `/pm:list` command currently reads and analyzes each PRD file on every execution, causing performance issues. Users need the list to return within 1 second for a smooth experience. The command extracts multiple pieces of information from each plan including name, dates, status, description, complexity, and questioning mode.

Based on the AI Product Manager's file-based architecture, we'll implement a persistent caching layer that intelligently handles the varying update frequencies of PRD files (constantly changing during planning, occasionally after creation, rarely once finalized).

## User Stories

1. **As a developer**, I want `/pm:list` to return results within 1 second so I can quickly see my plans without waiting.

2. **As a developer**, I want the cache to automatically update when PRD files change so I always see current information.

3. **As a developer**, I want the cache to persist between Claude sessions so performance benefits aren't lost on restart.

4. **As a developer**, I want the first-time experience to be transparent, with clear indication if cache is being built.

## Core Requirements

### Performance Requirements
- **Target Response Time**: < 1 second for listing all plans and sessions
- **Cache Hit Rate**: > 95% for unchanged files
- **Initial Cache Build**: < 3 seconds for typical projects (10-50 files)

### Caching Mechanism
- **Persistent Cache File**: Store cache in `.claude-pm/.cache/list-cache.json`
- **Cache Structure**:
  ```json
  {
    "version": "1.0",
    "lastUpdated": "ISO-timestamp",
    "plans": {
      "filename.md": {
        "path": "full-path-to-file",
        "lastModified": "file-mtime",
        "cached": {
          "name": "Plan Name",
          "created": "date",
          "updated": "date",
          "status": "status",
          "description": "brief description",
          "complexity": 1-5,
          "questioningMode": "ai-powered|template"
        }
      }
    },
    "sessions": {
      "session-id.json": {
        "path": "full-path-to-file",
        "lastModified": "file-mtime",
        "cached": {
          "sessionId": "id",
          "requirement": "requirement text",
          "status": "in-progress",
          "started": "timestamp",
          "questionsAsked": 5,
          "estimatedTotal": "5-7"
        }
      }
    }
  }
  ```

### Cache Invalidation
- **File-based Invalidation**: Compare file modification times
- **Selective Updates**: Only re-read files that have changed
- **Graceful Degradation**: If cache read fails, fall back to full scan

### Implementation Details
- **Cache-on-Access**: Build cache on first `/pm:list` call
- **Incremental Updates**: Only process changed files on subsequent calls
- **Atomic Writes**: Use temp file + rename to prevent corruption
- **Error Handling**: Log cache errors but don't fail the command

## Acceptance Criteria

1. ✅ `/pm:list` returns in < 1 second when cache is valid
2. ✅ Cache correctly detects and updates changed files
3. ✅ Cache persists across Claude restarts
4. ✅ First run shows "Building cache..." message
5. ✅ Cache corruption doesn't break the command
6. ✅ All currently displayed information is cached
7. ✅ Cache directory is created automatically if missing

## Implementation Notes

### Files to Modify
- `.claude/commands/pm/list.md` - Add caching logic

### Technical Approach
1. **Check/Create Cache Directory**: Ensure `.claude-pm/.cache/` exists
2. **Load Existing Cache**: Read `.cache/list-cache.text` if present
3. **Scan File System**: Get current files and modification times
4. **Differential Update**: 
   - Skip files with matching modification times
   - Re-read only changed/new files
   - Remove deleted files from cache
5. **Display Results**: Use cached data for display
6. **Save Updated Cache**: Write back to persistent storage

### Performance Optimizations
- Use `find` with `-newer` flag for efficient change detection
- Batch file reads when multiple files need updating
- Store pre-formatted display strings in cache
- Use JSON streaming for large cache files

### Error Scenarios
- **Missing .claude-pm directory**: Create it
- **Corrupt cache file**: Delete and rebuild
- **Permission errors**: Fall back to direct file reading
- **Disk full**: Skip cache write, log warning

## Success Metrics

1. **Performance**: 95% of `/pm:list` calls complete in < 1 second
2. **Accuracy**: 100% match between cached and actual file contents
3. **Reliability**: Zero command failures due to caching
4. **User Satisfaction**: Positive feedback on improved responsiveness

## TODOs

- [ ] Consider adding cache statistics command (`/pm:cache:stats`)
- [ ] Evaluate adding cache warming on PM command startup
- [ ] Explore using file watchers for real-time cache updates (v2)
- [ ] Add cache size limits and cleanup for very large projects
- [ ] Consider caching session question templates for faster session display

## Assumptions Made

**From Codebase Analysis:**
- The command system uses bash and can handle JSON operations
- File modification times are reliable indicators of content changes
- The `.claude-pm/` directory structure is consistent across projects

**From Best Practices:**
- JSON is appropriate for cache storage (human-readable, debuggable)
- Atomic file operations prevent corruption
- Simple implementation is preferred over complex optimization initially

**Areas for Future Clarification:**
- Maximum acceptable cache file size
- Whether to cache git history analysis results
- Preferred cache expiration strategy for long-running projects