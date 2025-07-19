# PRD: Template Flag Enhancement for Do:Plan Command

**Generated**: 2025-07-05 23:50:48  
**Requirement**: "I want to add a '--template <template_name>' flag to the '/do:plan' command to allow the user to override the default template assigned via @config.json"  
**Complexity**: 3/5  
**Status**: Ready for Development

## Context

The Do:PE AI system currently uses the `prdTemplate` setting in `config.json` to determine which template format to use when generating PRDs. While this provides a consistent default experience, users sometimes need to generate PRDs using different templates for specific use cases without modifying their global configuration.

This enhancement adds a `--template` command-line flag to the `/do:plan` command, allowing users to override the default template on a per-command basis. This improves flexibility while maintaining backward compatibility and the existing user experience for standard usage patterns.

The feature integrates with the existing template system (standard, agile, lean, technical, design-first, one-pager, bdd) and follows CLI best practices for argument parsing and error handling.

## User Stories

### As a Product Manager
- I want to use `/do:plan "feature request" --template=lean` 
- So that I can generate a lean-focused PRD for validation purposes without changing my default template

### As a Technical Lead
- I want to use `/do:plan "architecture changes" --template=technical`
- So that I can generate technical documentation-focused PRDs for complex implementation discussions

### As an Existing User
- I want `/do:plan "feature request"` to continue working exactly as before
- So that my existing workflows and scripts remain unaffected by this enhancement

## Core Requirements

### 1. Command-Line Interface Enhancement
- **Flag Syntax**: Support `--template=<template_name>` syntax after the requirement string
- **Argument Parsing**: Parse template flag from command arguments while preserving requirement text
- **Backward Compatibility**: Maintain existing `/do:plan "requirement"` functionality unchanged

### 2. Template Validation and Error Handling
- **Template Existence Check**: Validate specified template exists in `.do/templates/` directory
- **Error Display**: Show clear error message with available templates when invalid template specified
- **User Choice Handling**: Allow user to select valid template or proceed with config default
- **Graceful Fallback**: Continue with config.json default if user chooses not to select alternative

### 3. Configuration Integration
- **Precedence Logic**: Command-line flag overrides config.json `prdTemplate` setting
- **Config Loading**: Load and use existing configuration management system
- **Template Discovery**: Use existing template enumeration from config `availableTemplates`

## Acceptance Criteria

1. **Command Syntax Support**
   - [ ] `/do:plan "requirement" --template=lean` works correctly
   - [ ] `/do:plan "requirement" --template=standard` works correctly
   - [ ] `/do:plan "requirement"` (no flag) uses config.json default unchanged
   - [ ] Template flag position can be at end of command

2. **Template Validation**
   - [ ] Valid template names (lean, standard, agile, etc.) are accepted
   - [ ] Invalid template names show error with available options
   - [ ] User can select from available templates when invalid template provided
   - [ ] User can choose to proceed with config default when invalid template provided

3. **User Feedback**
   - [ ] No template feedback shown when using config default (no flag)
   - [ ] Template override feedback shown: `🚀 Analyzing: "requirement" (using lean template)`
   - [ ] Feedback only appears when overriding config default
   - [ ] Error messages are clear and actionable

4. **System Integration**
   - [ ] PRD generation uses specified template format correctly
   - [ ] Session files record template selection for audit trail
   - [ ] Configuration system integration remains unchanged
   - [ ] All existing `/do:plan` functionality preserved

## Implementation Notes

### Technical Considerations
- **Argument Parsing**: Implement flag parsing logic within the existing markdown command structure
- **Template System Integration**: Leverage existing template loading and PRD generation system
- **Error Handling**: Integrate with existing configuration error handling patterns
- **Session Management**: Update session file structure to include template selection information

### Dependencies
- **Existing Template System**: `.do/templates/` directory with available templates
- **Configuration Management**: `.do/config.json` loading and validation
- **Session Management**: Session file creation and persistence system
- **PRD Generation**: Template-based PRD creation system

### Suggested Approach
- **Phase 1**: Add argument parsing logic to extract `--template=value` from command
- **Phase 2**: Implement template validation and error handling workflow
- **Phase 3**: Integrate template override with existing PRD generation system
- **Phase 4**: Add user feedback for template overrides and testing

### Files Likely to Change
- `.claude/commands/do/do:plan.md` - Primary command logic enhancement
- Session file structure - Add template selection tracking
- Configuration handling - Template precedence logic

## Success Metrics

1. **Feature Adoption**: Usage of `--template` flag in command invocations
2. **User Experience**: Successful completion rate when using template overrides
3. **Error Handling**: Successful recovery rate from invalid template specifications
4. **Backward Compatibility**: Zero regression in existing `/do:plan` usage patterns

## TODOs and Future Considerations

1. **Short Flag Support**:
   - [ ] Consider adding `-t` short form in future iteration
   - [ ] User feedback on long-form usage patterns

2. **Template Discovery Enhancement**:
   - [ ] Add `/do:template --list` command for template discovery
   - [ ] Include template descriptions in error messages

3. **Advanced Features**:
   - [ ] Template validation with requirement type matching
   - [ ] Template recommendation based on requirement analysis

## Assumptions Made

**From Codebase Analysis:**
- Existing template system in `.do/templates/` will continue to be used
- Current configuration management patterns will be extended
- Session file structure can accommodate additional metadata
- Markdown-based command system supports argument parsing enhancements

**From Requirements Discussion:**
- Users prefer explicit long-form flags over short forms for clarity
- Template override notification is valuable for transparency
- Backward compatibility is critical for existing user adoption
- Error recovery with user choice is preferred over automatic fallback

**Areas for Future Clarification:**
- Performance impact of template validation on command startup time
- Integration testing approach with existing command test suite
- Documentation updates needed for help system and user guides

---

## Engineering Notes

*Engineering review completed: 2025-07-06 00:07:32*  
*Session: review-template-flag-enhancement-20250706-000726*

### Architecture Decisions

**Argument Parsing Strategy:**
- Parse requirements from quoted string format: `/do:plan "requirement" --template=lean`
- Extract template flag after closing quote to separate requirement text from flags
- Maintains clean separation between user requirement and command options

**Error Handling Approach:**
- Implement graceful degradation with helpful user guidance for malformed input
- Provide specific error messages with available options when template validation fails
- Allow users to recover from errors by selecting valid templates or proceeding with defaults

**Integration Strategy:**
- Override template early in workflow (Step 1) to influence both questioning strategy and final output
- Template selection must propagate through entire process to ensure appropriate questions are asked
- Maintain session tracking of template selection for audit trail and resumability

### Implementation Approach

**Technical Strategy:**
Early argument parsing with template override in Step 1 of workflow, graceful error handling with user guidance, maintain backward compatibility.

**Key Implementation Steps:**
1. **Argument Parsing Logic:** Extract template flag from `$ARGUMENTS` string after quoted requirement
2. **Template Validation:** Verify template exists in `.do/templates/` directory with helpful error messages
3. **Config Override:** Replace `prdTemplate` value early in workflow before questioning begins
4. **Session Integration:** Update session file structure to track template selection
5. **Backward Compatibility:** Ensure no-flag usage continues to work exactly as before

### Technical Constraints

**System Limitations:**
- **Markdown Command Execution Model:** Commands run as markdown files interpreted by Claude Code
- **No Native CLI Parser Available:** Must implement flag parsing within markdown command constraints
- **Template System Integration Required:** Must integrate with existing template loading and PRD generation
- **Session File Structure Compatibility:** Changes must not break existing session management

### Security Considerations

**Input Validation Requirements:**
- **Template Name Validation:** Ensure template names contain only allowed characters and patterns
- **Path Traversal Prevention:** Prevent access to files outside `.do/templates/` directory
- **Graceful Malformed Input Handling:** Process invalid input safely without system failures

### Testing Strategy

**Manual Validation Approach:**
Manual validation to ensure `/do:plan "add auth"` works unchanged, and flag usage selects correct template. Separate testing infrastructure task needed for future automation.

**Critical Test Cases:**
- **Backward Compatibility:** `/do:plan "add authentication"` must work identically to current behavior
- **Template Override:** `/do:plan "add auth" --template=lean` must produce lean-formatted PRD
- **Error Recovery:** Invalid templates must show helpful errors with recovery options
- **Edge Cases:** Malformed input, missing quotes, invalid template names

**Future Testing Infrastructure:**
- Separate technical task needed to establish testing framework for Do:PE AI commands
- Consider evaluation-based testing (evals) for command validation
- Automated regression testing for backward compatibility

### Risk Areas

**Implementation Risks:**
- **Argument Parsing Edge Cases:** Malformed input with missing quotes, invalid flag syntax
- **Backward Compatibility:** Risk of breaking existing workflows and user scripts
- **Template Validation Performance:** Potential impact on command startup time
- **Session File Structure Changes:** Risk of breaking session resumability

**Mitigation Strategies:**
- Comprehensive manual testing of edge cases before release
- Careful preservation of existing code paths for non-flagged usage
- Performance monitoring during initial rollout
- Gradual rollout with ability to revert if issues discovered

### Dependencies and Prerequisites

**System Dependencies:**
- **Existing Template System:** `.do/templates/` directory with available templates
- **Configuration Management System:** Config loading and validation infrastructure
- **Session File Persistence:** Session creation and management framework  
- **Markdown Command Execution Framework:** Claude Code command processing system

**Integration Points:**
- Template loading and validation system
- Configuration precedence and override logic
- Session file structure and persistence
- PRD generation with template-specific formatting

### Performance Considerations

**Current Assessment:**
No significant performance concerns anticipated. Will monitor in practice and optimize if issues arise.

**Monitoring Areas:**
- Template validation overhead on command startup
- Impact of early template loading on overall command performance
- Session file size increases from additional metadata storage