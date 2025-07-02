# PM Update - Update Commands to Latest Version

Updates AI Product Manager commands to the latest or specified version with automatic backup.

## Task: Execute Update Process

Parse arguments from the command to determine update mode:
- No arguments: Update to latest version
- Version argument (e.g., "v2.1.0"): Update to specific version  
- "--restore" argument: Restore from backup

### Step 1: Handle Restore Mode
If command argument is "--restore":
1. **List backups** - Check `.claude-pm/backups/` directory for available backups
2. **Show options** - Display 5 most recent backups with timestamps
3. **Get user selection** - Ask which backup to restore
4. **Restore files** - Copy selected backup files back to active command directory
5. **Update config** - Restore version in config.json to match backup
6. **Confirm success** - Show restoration completed message

### Step 2: Detect Installation Scope
Determine which command installation to update:
1. **Check user scope** - Look for `~/.claude/commands/pm.md`
2. **Check project scope** - Look for `.claude/commands/pm.md`
3. **Handle both exist** - If both found, ask user which to update (1=both, 2=user, 3=project)
4. **Handle none exist** - Show error and suggest running install script
5. **Set target directory** - Store the chosen commands directory path

### Step 3: Version Management
1. **Get current version** - Read 'version' from `.claude-pm/config.json`
2. **Determine target version**:
   - If no argument: Fetch latest from `https://raw.githubusercontent.com/jmcopeland/ai-product-manager/main/VERSION` 
   - If version specified: Use the provided version
3. **Compare versions** - Check if update is needed
4. **Early exit** - If already on target version, show success and exit

### Step 4: Show Release Information
If update is needed:
1. **Fetch release notes** - Download from `https://raw.githubusercontent.com/jmcopeland/ai-product-manager/main/RELEASE-NOTES.md`
2. **Parse relevant changes** - Show release notes for versions between current and target
3. **List files to update** - Show which command files will be updated
4. **Get confirmation** - Ask user to confirm proceeding with update

### Step 5: Create Backup
Before any changes:
1. **Create backup directory** - Make `.claude-pm/backups/update-YYYYMMDD-HHMMSS/<currentVersion>/`
2. **Copy current files** - Backup all existing command files
3. **Log backup location** - Store path for reference

### Step 6: Download New Files
Download all command files atomically:
1. **Create temp directory** - Make `.claude-pm/temp-update/`
2. **Download files** from `https://raw.githubusercontent.com/jmcopeland/ai-product-manager/v{VERSION}/.claude/`:
   - `commands/pm.md`
   - `commands/pm/list.md`
   - `commands/pm/continue.md`
   - `commands/pm/configure.md`
   - `commands/pm/status.md`
   - `commands/pm/install.md`
   - `commands/pm/update.md`
   - `questions/auth.md`
   - `questions/crud.md`
   - `questions/ui.md`
   - `questions/api.md`
   - `questions/general.md`
3. **Validate downloads** - Ensure all files downloaded successfully
4. **Atomic installation** - Only proceed if all downloads succeeded

### Step 7: Install Updates
If all downloads successful:
1. **Copy new files** - Move downloaded files to active command directory
2. **Update config.json** - Set new version and updateRepository
3. **Preserve settings** - Keep all existing configuration options
4. **Cleanup temp files** - Remove temporary download directory
5. **Show success** - Display completion message with version and backup location

### Step 8: Error Handling
Handle various failure scenarios:
- **Network failures** - Show connection error, preserve existing installation
- **Download failures** - Don't update any files if any download fails
- **Version validation** - Check that requested version exists
- **File permission issues** - Show clear error messages
- **Partial update recovery** - Restore from backup if needed

### Output Format:
```
🔍 PM Update v{version}

📋  Current version: {current}

🎯  Target version: {target}

📝  Release notes:
[Release information between versions]

💾  Backup created: .claude-pm/backups/{updateDirectory}
⬇️  Downloaded {count} command files
✅  Update completed successfully!

🔄  Commands updated to version {version}
```

Begin update process now, parsing any provided arguments.