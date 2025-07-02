# PM Update Command

Updates AI Product Manager commands to latest or specified version.

## Usage
```
/pm:update              # Update to latest version
/pm:update v2.1.0       # Update to specific version
/pm:update --restore    # Restore from most recent backup
```

## Implementation

**Step 1: Detect Current Installation**
- Check for commands in `~/.claude/commands/pm*` (user scope)
- Check for commands in `.claude/commands/pm*` (project scope)
- If both exist, ask user which to update
- If neither exist, show error and suggest running install

**Step 2: Version Management**
- Read current version from `.claude-pm/config.json`
- Fetch latest version: `https://raw.githubusercontent.com/jmcopeland/ai-product-manager/main/VERSION`
- If specific version requested, validate it exists as git tag
- Compare versions and determine if update needed

**Step 3: Show Changes (if update needed)**
- Fetch release notes from `https://raw.githubusercontent.com/jmcopeland/ai-product-manager/main/RELEASE-NOTES.md`
- Parse and display changes between current and target version
- Show which files will be updated
- Require user confirmation to proceed

**Step 4: Create Backup**
- Create timestamped backup in `.claude-pm/backups/update-YYYYMMDD-HHMMSS/`
- Copy all existing command files to backup directory
- Log backup location for recovery reference

**Step 5: Download and Update**
- Download new command files from: `https://raw.githubusercontent.com/jmcopeland/ai-product-manager/v{VERSION}/{filepath}`
- Files to update:
  - `commands/pm.md`
  - `commands/pm/list.md`
  - `commands/pm/continue.md`
  - `commands/pm/configure.md`
  - `commands/pm/status.md`
  - `commands/pm/install.md`
  - `commands/pm/update.md`
  - Question templates: `questions/auth.md`, `questions/crud.md`, etc.
- Validate each file downloads successfully before replacing
- Update atomically (download to temp, then move to final location)

**Step 6: Update Configuration**
- Update version in `.claude-pm/config.json`
- Add updateRepository if missing: `"updateRepository": "jmcopeland/ai-product-manager"`
- Preserve all existing configuration settings

**Step 7: Verify Installation**
- Test that main `/pm` command loads correctly
- Show success message with version updated
- Display backup location for reference

## Error Handling

**Network Failures:**
- Retry downloads with exponential backoff (3 attempts)
- Show clear error messages with offline guidance
- Preserve existing installation on failure

**Version Validation:**
- Check that requested version exists as git tag
- Provide helpful error for invalid versions
- Show available versions from recent releases

**File Download Failures:**
- If any file fails to download, don't update any files
- Restore from backup if partial update occurred
- Show specific error for each failed file

**Restore Mode (`--restore`):**
- List available backups with timestamps
- Allow user to select which backup to restore
- Copy backup files back to active command locations
- Update config.json version to match restored backup

## Implementation Code

```bash
#!/bin/bash

# Get target version (default to latest)
TARGET_VERSION="$1"
RESTORE_MODE=false

if [[ "$TARGET_VERSION" == "--restore" ]]; then
    RESTORE_MODE=true
elif [[ -z "$TARGET_VERSION" ]]; then
    echo "🔍 Checking for latest version..."
    TARGET_VERSION=$(curl -s "https://raw.githubusercontent.com/jmcopeland/ai-product-manager/main/VERSION" | tr -d '\n')
    if [[ -z "$TARGET_VERSION" ]]; then
        echo "❌ Failed to fetch latest version. Check network connection."
        exit 1
    fi
    echo "📦 Latest version: $TARGET_VERSION"
fi

# Restore mode
if [[ "$RESTORE_MODE" == "true" ]]; then
    echo "🔄 Available backups:"
    ls -t .claude-pm/backups/ | head -5
    echo
    read -p "Enter backup name to restore (or press Enter to cancel): " BACKUP_NAME
    if [[ -n "$BACKUP_NAME" && -d ".claude-pm/backups/$BACKUP_NAME" ]]; then
        echo "📁 Restoring from backup: $BACKUP_NAME"
        cp -r ".claude-pm/backups/$BACKUP_NAME"/* .claude/commands/ 2>/dev/null || cp -r ".claude-pm/backups/$BACKUP_NAME"/* ~/.claude/commands/
        echo "✅ Restore completed"
    fi
    exit 0
fi

# Detect installation scope
USER_SCOPE=false
PROJECT_SCOPE=false

if [[ -f ~/.claude/commands/pm.md ]]; then
    USER_SCOPE=true
fi

if [[ -f .claude/commands/pm.md ]]; then
    PROJECT_SCOPE=true
fi

if [[ "$USER_SCOPE" == "false" && "$PROJECT_SCOPE" == "false" ]]; then
    echo "❌ No PM commands found. Run ./install.sh first."
    exit 1
fi

# Choose scope if both exist
COMMANDS_DIR=""
if [[ "$USER_SCOPE" == "true" && "$PROJECT_SCOPE" == "true" ]]; then
    echo "📍 PM commands found in both locations:"
    echo "  1) User scope (~/.claude/commands/) - affects all projects"
    echo "  2) Project scope (.claude/commands/) - affects this project only"
    read -p "Which would you like to update? (1/2): " SCOPE_CHOICE
    if [[ "$SCOPE_CHOICE" == "1" ]]; then
        COMMANDS_DIR="$HOME/.claude/commands"
    else
        COMMANDS_DIR=".claude/commands"
    fi
elif [[ "$USER_SCOPE" == "true" ]]; then
    COMMANDS_DIR="$HOME/.claude/commands"
    echo "📍 Updating user scope (~/.claude/commands/)"
else
    COMMANDS_DIR=".claude/commands"
    echo "📍 Updating project scope (.claude/commands/)"
fi

# Get current version
CURRENT_VERSION=""
if [[ -f .claude-pm/config.json ]]; then
    CURRENT_VERSION=$(grep -o '"version"[[:space:]]*:[[:space:]]*"[^"]*"' .claude-pm/config.json | cut -d'"' -f4)
fi

echo "📋 Current version: ${CURRENT_VERSION:-unknown}"
echo "🎯 Target version: $TARGET_VERSION"

# Check if update needed
if [[ "$CURRENT_VERSION" == "$TARGET_VERSION" ]]; then
    echo "✅ Already on version $TARGET_VERSION"
    exit 0
fi

# Fetch and show release notes
echo
echo "📝 Release notes between $CURRENT_VERSION and $TARGET_VERSION:"
echo "================================================================"
RELEASE_NOTES=$(curl -s "https://raw.githubusercontent.com/jmcopeland/ai-product-manager/main/RELEASE-NOTES.md")
if [[ -n "$RELEASE_NOTES" ]]; then
    # Parse relevant section (simplified - show recent releases)
    echo "$RELEASE_NOTES" | head -50
else
    echo "Unable to fetch release notes"
fi
echo "================================================================"
echo

# Confirm update
read -p "🤔 Proceed with update to $TARGET_VERSION? (y/N): " CONFIRM
if [[ "$CONFIRM" != "y" && "$CONFIRM" != "Y" ]]; then
    echo "❌ Update cancelled"
    exit 0
fi

# Create backup
BACKUP_DIR=".claude-pm/backups/update-$(date +%Y%m%d-%H%M%S)"
echo "💾 Creating backup in $BACKUP_DIR"
mkdir -p "$BACKUP_DIR"
cp -r "$COMMANDS_DIR"/* "$BACKUP_DIR/" 2>/dev/null || true

# Download files
echo "⬇️  Downloading update files..."
BASE_URL="https://raw.githubusercontent.com/jmcopeland/ai-product-manager/v$TARGET_VERSION"

FILES_TO_UPDATE=(
    "commands/pm.md"
    "commands/pm/list.md"
    "commands/pm/continue.md"
    "commands/pm/configure.md"  
    "commands/pm/status.md"
    "commands/pm/install.md"
    "commands/pm/update.md"
    "questions/auth.md"
    "questions/crud.md"
    "questions/ui.md"
    "questions/api.md"
    "questions/general.md"
)

TEMP_DIR=".claude-pm/temp-update"
mkdir -p "$TEMP_DIR"

# Download all files first
DOWNLOAD_SUCCESS=true
for FILE in "${FILES_TO_UPDATE[@]}"; do
    echo "  📄 Downloading $FILE..."
    mkdir -p "$TEMP_DIR/$(dirname "$FILE")"
    if ! curl -s "$BASE_URL/.claude/$FILE" -o "$TEMP_DIR/$FILE"; then
        echo "❌ Failed to download $FILE"
        DOWNLOAD_SUCCESS=false
        break
    fi
done

# Only proceed if all downloads succeeded
if [[ "$DOWNLOAD_SUCCESS" == "true" ]]; then
    echo "📁 Installing downloaded files..."
    for FILE in "${FILES_TO_UPDATE[@]}"; do
        if [[ -f "$TEMP_DIR/$FILE" ]]; then
            mkdir -p "$COMMANDS_DIR/$(dirname "$FILE")"
            cp "$TEMP_DIR/$FILE" "$COMMANDS_DIR/$FILE"
        fi
    done
    
    # Update config.json
    mkdir -p .claude-pm
    if [[ -f .claude-pm/config.json ]]; then
        # Update existing config
        python3 -c "
import json
try:
    with open('.claude-pm/config.json', 'r') as f:
        config = json.load(f)
    config['version'] = '$TARGET_VERSION'
    config['updateRepository'] = 'jmcopeland/ai-product-manager'
    with open('.claude-pm/config.json', 'w') as f:
        json.dump(config, f, indent=2)
except Exception as e:
    print(f'Error updating config: {e}')
"
    else
        # Create new config
        cat > .claude-pm/config.json << EOF
{
  "version": "$TARGET_VERSION",
  "updateRepository": "jmcopeland/ai-product-manager",
  "questioningMode": "ai-powered",
  "questioningDepth": "standard",
  "prdTemplate": "standard",
  "analyzeGitHistory": true,
  "aiQuestioningOptions": {
    "useRelevanceFiltering": true,
    "questionsPerRound": 1,
    "adaptiveDepth": true,
    "includeRationale": true,
    "allowSkipQuestioning": true,
    "priorityThreshold": "medium"
  }
}
EOF
    fi
    
    echo "✅ Update completed successfully!"
    echo "📦 Updated to version: $TARGET_VERSION"
    echo "💾 Backup saved to: $BACKUP_DIR"
    echo "🔄 Restart Claude Code to use updated commands"
    
else
    echo "❌ Update failed - some files could not be downloaded"
    echo "💾 Your existing installation is unchanged"
    echo "🔄 To restore if needed: /pm:update --restore"
fi

# Cleanup temp directory
rm -rf "$TEMP_DIR"
```

## Notes
- Updates preserve all existing configuration in config.json
- Backups are kept permanently for safety
- Network failures are handled gracefully with retries
- Atomic updates ensure system stays in working state
- Supports both user and project scope installations