# PRD: Do Think Command - Quick Idea Capture

**Status:** Ready for Development  
**Priority:** Medium  
**Complexity:** 3/5  
**Estimated Effort:** 1-2 days  
**Created:** 2025-07-06  

## Context

Users need a quick, non-disruptive way to capture ideas while working on other tasks. Currently, there's no built-in mechanism in the Do:PE AI system for rapidly saving thoughts and ideas for later development. This command will fill that gap by providing instant idea capture with seamless integration into the existing `/do:validate` and `/do:plan` workflow.

The `/do:think` command will enable users to quickly save ideas without breaking their current flow, creating both a centralized idea list and individual files ready for processing through the established Do:PE AI development lifecycle.

## User Stories

**As a developer**, I want to quickly capture feature ideas as they occur to me, so that I don't lose valuable thoughts while working on current tasks.

**As a product manager**, I want to save ideas in a format that can be easily processed through our existing planning workflow, so that good ideas can be efficiently developed into full PRDs.

**As a team member**, I want to see all captured ideas in one place, so that I can review and prioritize them during planning sessions.

**As a user**, I want immediate confirmation that my idea was saved and clear guidance on next steps, so that I know how to develop the idea further.

**As a user**, I want to quickly review my existing ideas before capturing new ones, so that I can avoid duplicates and build on previous thoughts.

## Core Requirements

### Command Structure
- **Command syntax**: `/do:think "idea text here"` (capture) or `/do:think` (list)
- **Dual mode operation**: No arguments shows idea list, arguments capture new idea
- **Quoted input**: Support ideas with spaces, punctuation, and special characters
- **Error handling**: Prompt for input if idea text is empty
- **Quick execution**: Minimal processing time to avoid workflow disruption

### Dual Storage System
- **Central list**: Append idea as bullet point to `.do/ideas/ideas.md`
- **Individual files**: Create separate file for each idea in `.do/ideas/` directory
- **File naming**: Use timestamp + slug format (e.g., `idea-20250706-add-user-auth.md`)
- **Content consistency**: Same idea text in both locations

### Directory Management
- **Auto-creation**: Command creates `.do/ideas/` directory if it doesn't exist
- **Install script**: Update installation to create ideas directory
- **Permission handling**: Graceful error handling for permission issues

### User Feedback
- **Success confirmation**: Show that idea was saved successfully
- **Next steps**: Offer integration options (`/do:validate` or `/do:plan`)
- **File reference**: Include filename for easy reference
- **Minimal interruption**: Brief, informative feedback

### Idea List Display
- **Command behavior**: `/do:think` with no arguments displays all captured ideas
- **List format**: Show ideas from `ideas.md` with corresponding file references
- **Capture prompt**: Display syntax at bottom: `/do:think "your new idea here"`
- **Integration hints**: Show next step options for existing ideas

### Integration with Existing Commands
- **Validate integration**: Ideas can be passed to `/do:validate <idea_file>`
- **Plan integration**: Ideas can be passed to `/do:plan <idea_file>`
- **File compatibility**: Idea files work with existing command infrastructure

## Acceptance Criteria

### Functional Requirements
- [ ] Command successfully appends bullet point to `.do/ideas/ideas.md`
- [ ] Command creates individual file in `.do/ideas/` with timestamp-slug naming
- [ ] `/do:think` with no arguments displays all captured ideas
- [ ] Ideas list shows both idea text and corresponding filenames
- [ ] List display includes capture syntax at the bottom
- [ ] Empty idea input prompts user for input rather than failing
- [ ] Directory auto-creation works for both `.do/` and `.do/ideas/`
- [ ] Existing idea list is preserved when adding new ideas
- [ ] Generated idea files work with `/do:validate` and `/do:plan` commands

### User Experience Requirements
- [ ] Command execution takes less than 2 seconds (both capture and list modes)
- [ ] Success feedback includes filename and next step options
- [ ] Ideas list is readable and includes capture instructions
- [ ] Error messages are helpful and suggest specific fixes
- [ ] No data loss occurs during error scenarios
- [ ] Command works from any directory within the project
- [ ] List mode gracefully handles empty ideas file

### Technical Requirements
- [ ] Follows existing `/do:` command structure and patterns
- [ ] Uses standard bash file operations with proper error handling
- [ ] Implements `mkdir -p` pattern for directory creation
- [ ] Handles file permissions gracefully with clear error messages
- [ ] No input validation or sanitization required

### Installation Requirements
- [ ] Install script creates `.do/ideas/` directory
- [ ] Command file follows naming convention (`do:think.md`)
- [ ] Integration with existing command distribution system
- [ ] Documentation updated to include new command

## Implementation Notes

### File Structure
```
.do/
├── ideas/
│   ├── ideas.md                    # Central bullet list
│   ├── idea-20250706-user-auth.md      # Individual idea files
│   └── idea-20250706-dashboard.md
└── plans/                          # Existing PRD files
```

### Command Integration
The command should integrate seamlessly with existing Do:PE AI infrastructure:
- Follow the markdown-based CLI command pattern
- Use established error handling approaches
- Maintain consistency with other `/do:` commands
- Support the existing `.do/` directory organization
- Implement dual-mode behavior (capture vs list) based on argument presence

### Files to Modify
- **New file**: `.claude/commands/do/do:think.md` (main command implementation)
- **Update**: `install.sh` (add ideas directory creation)
- **Update**: Documentation files to include new command

### Error Handling Strategy
- **Empty input**: Interactive prompt for idea text
- **Permission errors**: Display specific error with suggested fixes
- **Directory creation**: Auto-create with fallback error messages
- **File conflicts**: Standard overwrite behavior (append to ideas.md, create unique individual files)
- **Missing ideas file**: Create with helpful header when displaying list for first time
- **Empty ideas list**: Show encouraging message with capture instructions

### Slug Generation Logic
- Convert idea text to filesystem-safe slug
- Remove special characters, convert spaces to hyphens
- Truncate to reasonable length (e.g., 50 characters)
- Ensure uniqueness with timestamp prefix

## Success Metrics

### Primary Metrics
- **Adoption rate**: Number of ideas captured per week
- **Integration usage**: How often saved ideas progress to `/do:validate` or `/do:plan`
- **Error rate**: Percentage of failed command executions
- **User satisfaction**: Feedback on workflow integration

### Secondary Metrics
- **Idea development rate**: Percentage of captured ideas that become full PRDs
- **Time to capture**: Average execution time of the command
- **File system health**: No corruption or permission issues

## TODOs and Future Considerations

### Implementation TODOs
- [ ] Determine optimal slug length for filenames
- [ ] Design ideas list display format and layout
- [ ] Test command with various special characters and edge cases
- [ ] Verify compatibility with different file systems (Windows, macOS, Linux)
- [ ] Create comprehensive test cases for error scenarios
- [ ] Test list mode with empty, small, and large idea collections

### Future Enhancements (Out of Scope)
- **Idea categorization**: Add optional tags or categories
- **Idea search**: Command to search through saved ideas
- **Idea management**: Commands to list, edit, or delete ideas
- **Team sharing**: Integration with git for team idea sharing
- **Idea analytics**: Track which ideas become successful features

### Questions for Later
- Should ideas have expiration dates or archival mechanisms?
- Would users benefit from idea templates or prompting questions?
- Should the command support bulk idea import from other sources?
- How should very long ideas be handled in the filename slug?

## Dependencies

### Internal Dependencies
- Existing Do:PE AI command infrastructure
- `.do/` directory structure and conventions
- `/do:validate` and `/do:plan` command compatibility

### External Dependencies
- Bash shell environment
- File system with write permissions
- Claude Code CLI framework

### Installation Dependencies
- Update to install.sh script
- Documentation updates
- Command distribution mechanism

---

## Engineering Notes

*Added by Senior Engineering Review - 2025-07-06*  
*Session: review-do-think-command-20250706-011852*

### Architecture Decisions

**File Operations Strategy:**
- **Atomic Operations**: Use temp files for reliable append to `ideas.md` - write to `ideas.md.tmp` then rename
- **Multi-layer Persistence**: Save individual idea file first (higher success rate), then append to central list
- **Retry Logic**: Implement 3-attempt retry with brief delays for transient failures
- **Fallback Strategy**: If `ideas.md` fails, save to `.do/ideas/failed-ideas.tmp` for manual recovery

**Slug Generation Approach:**
- **Intelligent Summarization**: Extract meaningful keywords rather than dumb truncation  
- **50-character Limit**: Cap slug length while preserving readability
- **Timestamp Uniqueness**: Datetime prefix ensures no collisions regardless of slug conflicts
- **Fallback Handling**: Generic slug generation for punctuation-only or non-meaningful input

**File Format Strategy:**
- **Minimal Individual Files**: Plain text only - no metadata headers or formatting
- **Direct Compatibility**: Files serve as direct arguments to `/do:plan` and `/do:validate`
- **Maximum Integration**: No special parsing required by downstream commands

### Implementation Approach

**Dual-Mode Command Logic:**
1. **Argument Detection**: Check if arguments provided to determine capture vs list mode
2. **List Mode** (`/do:think`): Display all ideas from `ideas.md` with filename references + capture syntax
3. **Capture Mode** (`/do:think "idea"`): Execute dual-storage with atomic operations

**Execution Flow for Idea Capture:**
1. **Validate Input**: Check for empty idea, prompt if needed
2. **Generate Slug**: Extract keywords, sanitize, truncate to ~50 chars
3. **Save Individual File**: `idea-YYYYMMDD-HHMMSS-[slug].md` with plain text content
4. **Atomic Append**: Write to `ideas.md.tmp`, append bullet point, rename to `ideas.md`
5. **Error Recovery**: If step 4 fails, save to `failed-ideas.tmp` with clear user notification
6. **User Feedback**: Confirm save with filename and next-step options

**List Mode Implementation:**
- Read and display contents of `ideas.md`
- Show corresponding individual filenames for each idea
- Include capture syntax reminder at bottom
- Handle empty ideas file gracefully with encouraging message

### Technical Constraints

- **Performance Requirement**: Complete execution in <2 seconds for both modes
- **File System Compatibility**: Must work across Windows, macOS, Linux filesystems
- **Integration Compatibility**: Must follow existing `.claude/commands/do/` patterns
- **Directory Structure**: Must respect existing `.do/` organization and conventions

### Security Considerations

**Minimal Risk Profile:**
- **Local Operations Only**: All file operations are local filesystem - no network exposure
- **No Input Validation**: Per PRD requirements, accept any idea text without sanitization
- **Standard Permissions**: Follow existing command patterns for file permission handling
- **No Privilege Escalation**: Standard user-level file operations only

### Testing Strategy

**Manual Testing Approach:**
- **Edge Case Testing**: Empty ideas, very long text (>500 chars), Unicode characters, special punctuation
- **Concurrency Testing**: Multiple rapid captures, concurrent list/capture operations
- **Error Scenario Testing**: Permission errors, disk space issues, filesystem failures
- **Integration Testing**: Verify idea files work correctly with `/do:validate` and `/do:plan`
- **Cross-Platform Testing**: Validate on different operating systems and filesystems

**Test Scenarios:**
- Capture during high-frequency usage (rapid successive calls)
- Large ideas file handling (100+ ideas)
- Edge case slug generation (punctuation, numbers, very short ideas)
- Recovery from filesystem errors and permission issues

### Risk Areas

**Identified Technical Risks:**
- **Concurrent Access**: Multiple users/processes writing simultaneously could cause race conditions
  - *Mitigation*: Atomic operations with temp files and retry logic
- **Filesystem Errors**: Disk space, permissions, or I/O errors during critical workflows
  - *Mitigation*: Multi-layer fallback persistence and clear error messaging
- **Slug Generation Edge Cases**: Unusual input causing filename issues or poor UX
  - *Mitigation*: Intelligent keyword extraction with generic fallbacks
- **Integration Compatibility**: Changes to downstream command expectations
  - *Mitigation*: Minimal file format ensures broad compatibility

### Dependencies and Prerequisites

**Technical Dependencies:**
- **Bash Shell**: Standard bash environment with file operations support
- **File System**: Local filesystem with read/write permissions to `.do/` directory  
- **Claude Code CLI**: Integration with existing command framework
- **Standard Utilities**: `ls`, `grep`, `cut`, basic Unix tools for file operations

**Installation Dependencies:**
- Update `install.sh` to create `.do/ideas/` directory
- Command file deployment to `.claude/commands/do/do:think.md`
- Documentation updates for new command syntax and workflow

### Implementation Priority

**High Priority Items:**
1. **Atomic File Operations**: Core reliability requirement
2. **Dual-Mode Logic**: Essential functionality for both capture and list
3. **Error Recovery**: Critical for user trust and data integrity
4. **Slug Generation**: Affects daily user experience and file organization

**Medium Priority Items:**
1. **Cross-platform Testing**: Important for broader adoption
2. **Performance Optimization**: Enhance user experience
3. **Edge Case Handling**: Polish and robustness

---

**Ready for implementation!** This feature provides clear value with minimal complexity and integrates seamlessly with the existing Do:PE AI workflow.