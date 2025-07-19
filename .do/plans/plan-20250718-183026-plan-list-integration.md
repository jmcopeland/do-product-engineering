# PRD: Enhanced /do:plan Command with Integrated List View

## Context

The `/do:plan` command enhancement integrates list functionality from `/do:list` to create a unified command interface for the Do:PE AI workflow. This consolidation improves user experience by providing complete development pipeline visibility in a single command, following the successful pattern established by `/do:think`.

**Background:**
- Current `/do:list` exists as separate command with smart caching and performance optimization
- 7 commands currently reference `/do:list` for file browsing functionality
- Users need better workflow visibility to see ideas → plans progression
- Command consolidation reduces cognitive overhead and improves discoverability

**Integration Benefits:**
- Single entry point for planning workflow management
- Complete development pipeline visibility (ideas + plans)
- Consistent command pattern across Do:PE AI system
- Simplified mental model for users

## User Stories

**As a product developer, I want to:**
- Run `/do:plan` without arguments to see all my ideas and plans in one view
- Understand the status of each idea through its lifecycle (captured → validated → planned → implemented)
- Quickly identify which ideas are ready to be planned and which plans need next steps
- Navigate my development queue efficiently with clear status indicators

**As a workflow user, I want to:**
- See ideas and plans organized in logical workflow order (ideas first, then plans)
- Access the same planning functionality when I provide arguments to `/do:plan`
- Have consistent behavior across `/do:think` (ideas) and `/do:plan` (plans) commands
- Get helpful guidance on next steps for each item

## Core Requirements

### Command Interface Behavior
1. **No Arguments Mode**: `/do:plan` displays integrated list view with both ideas and plans
2. **Arguments Mode**: `/do:plan "requirement"` or `/do:plan file.md` functions as current planning system
3. **Consistent Pattern**: Mirror `/do:think` behavior for listing and guidance

### Display Organization
1. **Workflow Sections**: Clear separation between "💡 Ideas" and "📋 Plans" sections
2. **Workflow Order**: Ideas section first, then Plans section (logical progression)
3. **Status Visibility**: All items show relevant status information for decision making

### Ideas Section Display
1. **Content**: Show idea text, filename, creation date, and lifecycle status
2. **Status Tracking**: File-based detection (📝 Captured → ✅ Validated → 📋 Planned → 🚀 Implemented)
3. **Smart Detection**: Automatically determine status by checking for related validation/plan files

### Plans Section Display  
1. **Preserve Format**: Maintain existing `/do:list` display format and functionality
2. **Performance**: Keep smart caching system for sub-second response times
3. **Data Extraction**: Title, status, description, and dates from PRD files

### Integration Requirements
1. **Command References**: Update 7 existing command references from `/do:list` to `/do:plan`
2. **File Removal**: Remove `/do:list.md` command file after integration
3. **Caching Preservation**: Maintain `.do/.cache/list-cache.txt` performance system

## Acceptance Criteria

### Functional Requirements
- [ ] `/do:plan` with no arguments displays integrated view
- [ ] Ideas section shows: text, filename, date, status
- [ ] Plans section maintains current `/do:list` format
- [ ] Status tracking works via file-based detection
- [ ] Performance matches current `/do:list` speed
- [ ] All existing `/do:plan` argument functionality preserved

### User Experience Requirements
- [ ] Clear visual separation between Ideas and Plans sections
- [ ] Workflow order: Ideas first, Plans second
- [ ] Next steps guidance provided (similar to `/do:think`)
- [ ] Status indicators help users understand current state
- [ ] No cognitive overhead increase compared to separate commands

### Technical Requirements
- [ ] Caching system preserved for performance
- [ ] File-based status detection implemented
- [ ] Command references updated (7 files)
- [ ] `/do:list.md` file removed
- [ ] No breaking changes to existing `/do:plan` workflows

### Integration Requirements  
- [ ] Commands reference `/do:plan` instead of `/do:list`
- [ ] Backward compatibility maintained during transition
- [ ] Error handling for missing cache files
- [ ] Smart detection handles edge cases gracefully

## Implementation Notes

### Files to Modify
- **Primary**: `.claude/commands/do/plan.md` (integrate list functionality)
- **References**: 7 command files currently referencing `/do:list`
  - `build.md`, `design.md`, `review.md`, `status.md`, `install.md`
- **Remove**: `.claude/commands/do/list.md`

### Technical Integration
- **Caching System**: Port smart caching logic from `/do:list` to `/do:plan`
- **Status Detection**: Implement file-based lifecycle tracking for ideas
- **Data Sources**: `.do/ideas/ideas.md`, `.do/plans/*.md`, `.do/sessions/*.json`
- **Performance**: Maintain sub-second response time requirement

### Status Detection Logic
```bash
# For each idea, check lifecycle progression
idea-file.md → look for validation-*-idea-keywords*.md → look for plan-*-idea-keywords*.md
Status: 📝 Captured | ✅ Validated | 📋 Planned | 🚀 Implemented
```

### Display Format Pattern
```
💡 Ideas
• [idea text] ([filename])
  📝 Captured | Created: [date]

📋 Plans  
### [Status Icon] [Plan Name]
file: [filename]
[description]
**Created:** [date] | **Status:** [status]

🚀 Next steps:
• Plan an idea: /do:plan <idea-filename>
• Continue planning: /do:plan "new requirement"
• Validate ideas: /do:validate <idea-filename>
```

## Success Metrics

### User Experience Metrics
- **Command Consolidation**: Reduced from 2 commands (`/do:list` + `/do:plan`) to 1 unified interface
- **Workflow Visibility**: 100% visibility into ideas → plans pipeline in single view
- **Navigation Efficiency**: Users can identify next actions without additional command calls

### Technical Metrics
- **Performance**: Maintain sub-second response time (same as current `/do:list`)
- **Caching Effectiveness**: Cache hit rate remains above 80% for repeated calls
- **Reference Integration**: All 7 command references successfully updated

### Adoption Metrics
- **Usage Pattern**: Track `/do:plan` no-args usage vs. argument usage
- **Error Reduction**: Fewer "file not found" errors due to improved visibility
- **Workflow Completion**: Track ideas that progress through full lifecycle

## TODOs

### Development Phase
- [ ] Design file-based status detection algorithm
- [ ] Implement caching integration from `/do:list`
- [ ] Create combined display format for ideas + plans
- [ ] Add error handling for missing directories/files

### Integration Phase  
- [ ] Update all command references (7 files) to point to `/do:plan`
- [ ] Test performance with larger datasets (20+ ideas, 20+ plans)
- [ ] Verify backward compatibility for existing `/do:plan` users
- [ ] Remove `/do:list.md` after successful integration

### Future Enhancements
- [ ] Consider SQLite database for complex status tracking (if file-based becomes limiting)
- [ ] Add filtering options (by status, date, type)
- [ ] Implement search functionality across ideas and plans
- [ ] Add workflow analytics and reporting features

---

## Engineering Notes

*Added by Senior Engineering Review (session: review-plan-list-integration-20250718-185416)*

### Architecture Decisions

**Dual-Mode Operation Pattern**
- **List Mode (Zero Arguments)**: Bypass session creation for optimal performance, following `/do:think` pattern
- **Planning Mode (Arguments Provided)**: Maintain mandatory session creation for audit compliance
- **Performance Target**: Sub-second response maintained for list operations

**Unified Caching Strategy**
- **Single Cache File**: Extend existing `.do/.cache/list-cache.txt` to include both ideas and plans
- **Extended Invalidation**: Modify `ls -t` validation to check `.do/ideas/*.md` and `.do/plans/*.md`
- **Data Reuse**: Leverage existing `.do/ideas/ideas.md` structure from `/do:think` command

**Standardized File Naming Convention**
- **New Pattern**: `<stage>-<slug>-<timestamp>.md` across all workflow stages
- **Examples**: 
  - `idea-plan-list-integration-20250718183026.md`
  - `validation-plan-list-integration-20250718185000.md` 
  - `plan-plan-list-integration-20250718190000.md`
- **Status Detection**: Simple file existence check instead of complex pattern matching
- **Migration**: Manual migration for existing files, no backward compatibility required

### Implementation Approach

**Argument Routing Logic**
```bash
# Step 1: Early argument detection
if [[ -z "$ARGUMENTS" ]]; then
    # List Mode: Display integrated view without session creation
    execute_list_mode
    exit 0
else
    # Planning Mode: Continue with existing argument parsing and session creation
    execute_planning_mode  
fi
```

**Cache Invalidation Enhancement**
```bash
# Extended validation check
ls -t .do/plans/*.md .do/ideas/*.md .do/.cache/list-cache.txt 2>/dev/null | head -1
# If result ends with "list-cache.txt", cache is valid
```

**Status Detection Algorithm**
```bash
# For each idea file: idea-<slug>-<timestamp>.md
SLUG=$(extract_slug_from_filename "$idea_file")
if [[ -f ".do/validations/validation-$SLUG-*.md" ]]; then
    if [[ -f ".do/plans/plan-$SLUG-*.md" ]]; then
        STATUS="📋 Planned"
    else
        STATUS="✅ Validated" 
    fi
else
    STATUS="📝 Captured"
fi
```

### Technical Constraints

**Performance Requirements**
- **Sub-second Response**: List operations must complete in <1 second
- **Cache Efficiency**: Cache hit rate >80% for repeated list calls
- **Memory Usage**: Minimal impact on planning workflow performance

**File System Operations**
- **Atomic Updates**: Maintain existing atomic operation patterns from `/do:think`
- **Error Handling**: Graceful degradation when cache is corrupted or missing
- **Directory Access**: Read-only access to `.do/ideas/` and `.do/plans/` for list mode

### Security Considerations

**File Access Patterns**
- **No New Permissions**: List integration doesn't introduce new file system access requirements
- **Read-Only Operations**: List mode performs only read operations, no file modifications
- **Existing Security Model**: Leverage established file access patterns from current commands

### Testing Strategy

**Performance Testing**
- **Cache Invalidation**: Test with 20+ ideas and 20+ plans to verify performance
- **Concurrent Access**: Verify cache behavior with multiple simultaneous operations
- **Large Dataset**: Validate response times with realistic data volumes

**Integration Testing**
- **Dual-Mode Routing**: Test argument parsing edge cases and mode detection
- **Status Detection**: Verify accuracy of file-based lifecycle tracking
- **Command References**: Validate all 7 command reference updates work correctly

**Edge Case Testing**
- **Missing Directories**: Handle `.do/ideas/` or `.do/plans/` not existing
- **Corrupted Cache**: Recovery from invalid cache file states
- **Template Flag Conflicts**: Ensure template flags don't interfere with list mode

### Risk Mitigation

**Performance Risks**
- **Status Detection Overhead**: Implement efficient slug extraction and file existence checking
- **Cache Miss Penalty**: Optimize real-time data extraction when cache is invalid
- **Memory Usage**: Monitor cache size growth with dual data sources

**Implementation Risks**
- **Argument Parsing Complexity**: Thorough testing of zero-argument detection vs. template flags
- **File Naming Migration**: Validate manual migration doesn't break existing workflows
- **Reference Updates**: Systematic update of all 7 command references to avoid broken links

### Dependencies

**System Dependencies**
- **Current Caching System**: `.do/.cache/list-cache.txt` and `ls -t` validation logic
- **Ideas Management**: `.do/ideas/ideas.md` format from `/do:think` command
- **Session Framework**: Existing session creation and management infrastructure

**Integration Dependencies**
- **Command Updates**: 7 files require reference updates from `/do:list` to `/do:plan`
- **File Structure**: `.do/ideas/`, `.do/plans/`, `.do/sessions/` directories must exist
- **Template System**: Existing template override functionality must remain functional

### Future Considerations

**Scalability Planning**
- **Database Migration Path**: If file-based status tracking becomes limiting, SQLite migration strategy
- **Performance Monitoring**: Track cache hit rates and response times for optimization opportunities
- **Feature Extensions**: Framework for adding filtering, search, and analytics capabilities

**Maintenance Requirements**
- **Cache Management**: Periodic cleanup of large cache files
- **File Naming Validation**: Automated verification of naming convention compliance
- **Performance Monitoring**: Regular validation of sub-second response time requirement

---

**Generated from session:** plan-list-integration-20250718-183026
**Template:** standard  
**Questions Asked:** 5  
**Complexity:** Medium

**Engineering Review:** review-plan-list-integration-20250718-185416  
**Review Questions:** 5  
**Key Decisions:** Dual-mode architecture, unified caching, standardized naming