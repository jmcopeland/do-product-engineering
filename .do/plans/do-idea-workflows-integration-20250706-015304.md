# PRD: Idea File Integration for Do:PE AI Workflows

**Status:** Ready for Development  
**Priority:** High  
**Complexity:** 2/5  
**Estimated Effort:** 1 day  
**Created:** 2025-07-06  

## Context

The Do:PE AI system currently has the `/do:think` command for capturing ideas into individual files, but these files cannot be directly used with existing workflow commands like `/do:plan` and `/do:validate`. This creates a gap in the user journey where captured ideas require manual copying/pasting to be processed through the development lifecycle.

This enhancement will enable seamless integration by allowing `/do:plan <idea_file>` and `/do:validate <idea_file>` to directly process idea files, creating a complete capture-to-development workflow. This aligns with the system's goal of streamlining the entire product development process from initial idea to implementation.

## User Stories

**As a developer**, I want to run `/do:plan idea-20250706-user-auth.md` to directly convert my captured idea into a detailed PRD, so that I don't need to manually copy/paste idea content.

**As a product manager**, I want to use `/do:validate idea-file.md` to validate captured ideas before full planning, so that I can efficiently process ideas through the complete workflow.

**As a team member**, I want to reference any text file as an idea source (not just `/do:think` generated files), so that I can process requirements from various sources through the Do:PE AI workflow.

**As a user**, I want consistent error handling when idea files are missing or unreadable, so that I get helpful guidance to resolve issues and continue my workflow.

## Core Requirements

### File Resolution Logic
- **Smart Path Detection**: Commands check `.do/ideas/` directory first for filename matches
- **Full Path Support**: Commands accept absolute and relative file paths for maximum flexibility
- **Any Text File**: Users can reference any text file as an idea source, not just `/do:think` generated files
- **Seamless UX**: Simple filename usage: `/do:plan user-auth-idea.md` automatically finds `.do/ideas/user-auth-idea.md`

### Content Processing
- **Transparent Integration**: Idea file content is treated exactly like direct user input
- **No Preprocessing**: Raw file content is passed directly to existing command logic
- **Template Compatibility**: Idea files work with all existing template override flags (e.g., `--template=lean`)
- **Session Consistency**: Session creation and management works identically to direct input mode

### Command Integration Points
- **`/do:plan` Enhancement**: Accept idea files as direct input sources
- **`/do:validate` Enhancement**: Accept idea files for validation workflow
- **Argument Parsing**: Detect file references vs direct text input automatically
- **Backward Compatibility**: Existing command usage patterns remain unchanged

### Error Handling Strategy
- **Graceful Degradation**: Follow established error handling patterns from existing commands
- **File Not Found**: Show clear error with helpful suggestions and available alternatives
- **Permission Issues**: Provide specific resolution guidance with fallback options
- **Empty/Invalid Files**: Offer manual input fallback or file correction guidance
- **Recovery Options**: Always provide path forward to continue workflow

## Acceptance Criteria

### File Resolution Requirements
- [ ] `/do:plan filename.md` automatically checks `.do/ideas/filename.md` first
- [ ] `/do:plan /full/path/to/file.md` uses absolute path directly
- [ ] `/do:plan ./relative/path/file.md` uses relative path directly
- [ ] Commands work with any text file, not just `/do:think` generated files
- [ ] File resolution logic is consistent between `/do:plan` and `/do:validate`

### Content Processing Requirements
- [ ] Idea file content is processed identically to direct user input
- [ ] No preprocessing or modification of file content
- [ ] Template override flags work with idea files: `/do:plan idea.md --template=lean`
- [ ] Session creation includes file source reference for audit trail
- [ ] Generated PRDs don't distinguish between file-sourced vs direct input

### Error Handling Requirements
- [ ] Missing files show helpful error with file resolution logic explanation
- [ ] Permission errors provide specific resolution steps
- [ ] Empty files offer manual input fallback option
- [ ] Invalid/unreadable files show clear error with suggested fixes
- [ ] All error messages follow existing command error formatting patterns

### Integration Requirements
- [ ] `/do:plan <idea_file>` processes idea files through full PRD creation workflow
- [ ] `/do:validate <idea_file>` processes idea files through validation workflow
- [ ] Both commands maintain all existing functionality for direct input
- [ ] Session files correctly track file-sourced vs direct input origins
- [ ] Generated outputs work seamlessly with downstream commands (`/do:review`, `/do:build`)

## Implementation Notes

### File Detection Algorithm
```bash
# Smart file resolution logic
if [[ "$ARGUMENTS" == *.md ]] || [[ -f "$ARGUMENTS" ]]; then
  # Likely a file reference
  if [[ "$ARGUMENTS" == /* ]] || [[ "$ARGUMENTS" == ./* ]]; then
    # Absolute or relative path - use directly
    FILE_PATH="$ARGUMENTS"
  else
    # Simple filename - check .do/ideas/ first
    if [[ -f ".do/ideas/$ARGUMENTS" ]]; then
      FILE_PATH=".do/ideas/$ARGUMENTS"
    elif [[ -f "$ARGUMENTS" ]]; then
      FILE_PATH="$ARGUMENTS"
    else
      # File not found - show error
      show_file_not_found_error
    fi
  fi
  # Read file content and process as $ARGUMENTS
  ARGUMENTS=$(cat "$FILE_PATH")
else
  # Direct text input - process normally
fi
```

### Command Modification Points
- **Argument Processing**: Add file detection logic before existing argument parsing
- **Content Substitution**: Replace `$ARGUMENTS` with file content when file detected
- **Session Metadata**: Track file source in session for audit trail
- **Error Integration**: Use existing error handling patterns and formatting

### Files to Modify
- **`/do:plan.md`**: Add file detection and reading logic before existing processing
- **`/do:validate.md`**: Add identical file detection and reading logic (create if doesn't exist)
- **Error handling**: Reuse existing error message patterns from other commands

### Error Message Examples
```
❌ Idea file not found: user-auth.md

Searched locations:
• .do/ideas/user-auth.md
• ./user-auth.md

💡 Options:
• Check available ideas: /do:think
• Use full path: /do:plan /path/to/file.md
• Input directly: /do:plan "your requirement here"
```

## Success Metrics

### Primary Metrics
- **Workflow Completion**: Percentage of `/do:think` captured ideas that progress through `/do:plan` or `/do:validate`
- **Error Rate**: Percentage of file-based command invocations that succeed without error
- **User Adoption**: Number of file-based command uses vs direct input uses

### Secondary Metrics
- **Error Recovery**: Percentage of users who successfully resolve file errors and continue workflow
- **Integration Usage**: How often users combine idea capture with immediate processing
- **File Source Diversity**: Usage of non-`/do:think` text files as idea sources

## TODOs and Future Considerations

### Implementation TODOs
- [ ] Determine if `/do:validate` command exists or needs to be created
- [ ] Test file resolution logic with various path formats and edge cases
- [ ] Verify session tracking correctly identifies file-sourced origins
- [ ] Ensure error messages match existing command formatting patterns

### Future Enhancements (Out of Scope)
- **Batch Processing**: `/do:plan *.md` to process multiple idea files
- **File Validation**: Check file format or content validity before processing
- **Idea File Metadata**: Optional headers in idea files for enhanced processing
- **Integration Analytics**: Track which ideas become successful features

### Questions for Later
- Should there be a command to convert between file and direct input modes?
- Would users benefit from idea file templates or standardized formats?
- Should the system suggest related ideas when processing an idea file?

## Dependencies

### Internal Dependencies
- Existing `/do:plan` command infrastructure and argument parsing
- `/do:validate` command (may need creation if doesn't exist)
- `.do/ideas/` directory structure from `/do:think` command
- Session management and error handling patterns

### External Dependencies
- Bash shell environment with file system access
- Claude Code CLI framework
- File system permissions for reading idea files

### Testing Dependencies
- Various idea file formats and content types
- Different file path scenarios (absolute, relative, simple names)
- Error scenarios (missing files, permissions, empty files)

---

**Ready for implementation!** This enhancement provides seamless integration between idea capture and development workflows, completing the Do:PE AI user journey from initial thought to implemented feature.