# PM Update Command - PRD

**Created:** July 1, 2025 14:30:00  
**Complexity Estimate:** 3/5  
**Status:** Ready for Development

## Context

Users currently need to manually update AI Product Manager commands by re-running install scripts or manually copying files from the GitHub repository. This creates friction for staying current with new features and bug fixes. The `/pm:update` command will provide an automated way to update to the latest version or a specific version of AI Product Manager commands.

## User Stories

1. **As an AI Product Manager user**, I want to easily update to the latest version so that I can access new features and bug fixes without manual file copying.

2. **As a team lead**, I want to update our project's PM commands to a specific version so that the whole team uses the same version.

3. **As a developer**, I want to see what changes will be made before updating so that I can understand the impact on my workflow.

4. **As a cautious user**, I want the update process to be safe with backup and recovery options so that I don't get stuck with broken commands.

5. **As a version-conscious user**, I want to be able to update or downgrade to specific versions using git tags so that I can control exactly which version I'm running.

## Core Requirements

### Update Scope Detection
- Automatically detect whether commands are installed in user scope (`~/.claude/commands/`) or project scope (`.claude/commands/`)
- Present options when both scopes are available
- Handle cases where commands exist in both locations

### Version Management
- Check current version from `config.json` 
- Compare against GitHub repository `VERSION` file
- Support git tag-based versioning (e.g., `v2.0.0`, `v1.5.2`)
- Allow users to specify target version: `/pm:update v2.0.0`
- Default to latest version when no version specified

### Update Workflow
- Fetch and display release notes between current and target version
- Show clear diff of what will change
- Require user confirmation before proceeding
- Download and install new command files
- Update version in `config.json`
- Provide success confirmation with summary

### Safety & Recovery
- Create automatic backup before updating
- Validate downloaded files before replacing
- Provide retry mechanism for failed updates
- Offer restoration from backup if update fails completely
- Clear error messages with recovery instructions

### User Experience
- Progress indicators during download and installation
- Clear messaging about what scope is being updated
- Summary of changes made after successful update
- Integration with existing command structure

## Acceptance Criteria

### Version Detection
- [ ] Command detects current version from config.json
- [ ] Fetches latest version from GitHub VERSION file
- [ ] Compares versions and determines if update is needed
- [ ] Handles missing version information gracefully

### Scope Management
- [ ] Automatically detects available installation scopes
- [ ] Presents clear options when multiple scopes exist
- [ ] Updates the correct scope based on user selection
- [ ] Preserves existing configuration during updates

### Release Notes Display
- [ ] Fetches release notes from GitHub between versions
- [ ] Displays formatted changelog before update
- [ ] Shows clear summary of new features and breaking changes
- [ ] Allows user to cancel after reviewing changes

### Update Process
- [ ] Downloads command files from specified version/tag
- [ ] Creates backup of existing commands
- [ ] Replaces command files atomically
- [ ] Updates version tracking in config.json
- [ ] Validates installation integrity after update

### Error Handling
- [ ] Handles network failures gracefully
- [ ] Provides retry options for failed downloads
- [ ] Restores from backup on catastrophic failure
- [ ] Shows helpful error messages with next steps
- [ ] Maintains system in working state even after failures

### Version Specification
- [ ] Supports `/pm:update` for latest version
- [ ] Supports `/pm:update v2.0.0` for specific versions
- [ ] Validates specified versions exist as git tags
- [ ] Provides clear error for invalid version specifications

## Implementation Notes

### Files Likely to Change
- `commands/pm/update.md` - New command file
- `commands/pm.md` - May need update hook integration
- `.claude-pm/config.json` - Version tracking addition
- `install.sh` - Shared logic extraction

### Technical Considerations

**GitHub Integration:**
- Use GitHub API or raw file access for version checking
- Leverage git tags for version management
- Handle API rate limits gracefully
- Support both public repo access patterns

**Backup Strategy:**
- Create timestamped backup directories
- Store backups in `.claude-pm/backups/`
- Implement cleanup of old backups
- Provide manual restoration instructions

**Atomic Updates:**
- Download to temporary location first
- Validate files before replacing
- Use atomic file operations where possible
- Rollback on any individual file failure

**Version Tracking:**
- Add `currentVersion` field to config.json
- Track installation source (user vs project)
- Maintain update history for troubleshooting
- Support version validation and verification

**Network Resilience:**
- Implement retry logic with exponential backoff
- Provide offline-friendly error messages
- Cache release notes for recent versions
- Handle GitHub API timeouts gracefully

### Integration Points
- Leverage existing installation logic from `install.sh`
- Integrate with `/pm:configure` for version settings
- Connect with `/pm:status` for version reporting
- Share backup/restore logic with other commands

## Success Metrics

### User Experience
- Update completion rate > 95%
- Average update time < 30 seconds
- User satisfaction with update process
- Reduction in manual installation support requests

### Technical Reliability
- Zero instances of users getting stuck with broken commands
- Successful rollback rate on update failures
- Network failure recovery success rate
- Version detection accuracy

### Adoption
- Percentage of users updating within 1 week of new releases
- Frequency of version-specific updates
- Reduction in outdated installation reports

## TODOs

### Pre-Implementation
- [ ] Define exact GitHub API endpoints to use
- [ ] Determine backup retention policy (how many backups to keep)
- [ ] Specify release notes format and parsing strategy
- [ ] Design config.json version tracking schema

### Implementation Questions
- [ ] Should the command support updating from forks/different repositories?
- [ ] How should we handle custom modifications to command files?
- [ ] Should there be a dry-run mode to preview changes?
- [ ] What level of logging should be implemented for troubleshooting?

### Post-Implementation
- [ ] Create comprehensive testing scenarios for different failure modes
- [ ] Document manual recovery procedures for worst-case scenarios
- [ ] Consider automated update notifications in future versions
- [ ] Evaluate usage metrics to improve update experience

### Dependencies
- [ ] Ensure GitHub repository has proper version tagging
- [ ] Verify release notes format is consistent across versions
- [ ] Test with various network conditions and proxy setups
- [ ] Validate compatibility with different shell environments