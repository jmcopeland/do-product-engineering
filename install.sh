#!/bin/bash

# Do:PE AI v2.4 Installation Script
# Installs AI-powered PM commands to user's home directory

set -e

# Parse command line arguments
AUTO_DETECTION=false
if [[ "$1" == "--with-auto-detection" ]]; then
    AUTO_DETECTION=true
    echo "🤖 Installing Do:PE AI v2.4 with AI-powered questioning and auto-detection..."
else
    echo "🤖 Installing Do:PE AI v2.4 with AI-powered questioning..."
fi

# Create directories
echo "Creating directories..."
mkdir -p ~/.claude/commands/pm
mkdir -p ~/.do/{questions,sessions,plans}

# Copy command files
echo "Copying command files..."
cp .claude/commands/do/do:*.md ~/.claude/commands/do/

# Copy question templates
echo "Setting up AI question templates..."
cp .do/questions/*.md ~/.do/questions/ 2>/dev/null || {
    echo "Note: Question templates not found in source. Using built-in templates."
}

# Create default config
echo "Creating default AI configuration..."
if [ ! -f ~/.do/config.json ]; then
    # Read version from VERSION file
    VERSION=$(cat VERSION 2>/dev/null)
    
    cat > ~/.do/config.json << EOF
{
  "version": "$VERSION",
  "updateRepository": "jmcopeland/ai-product-manager",
  "questioningDepth": "standard",
  "autoSave": true,
  "aiQuestioningOptions": {
    "useRelevanceFiltering": true,
    "questionsPerRound": 1,
    "adaptiveDepth": true,
    "includeRationale": true,
    "allowSkipQuestioning": true,
    "priorityThreshold": "medium"
  },
  "prdTemplate": "standard",
  "complexityScale": 5,
  "includeImplementationNotes": true,
  "analyzeGitHistory": true,
  "maxGitCommits": 10,
  "contextDepth": "standard"
}
EOF
    echo "Created default AI configuration with version $VERSION."
else
    echo "Existing config found - keeping your settings."
fi

# Install auto-detection if requested
if [ "$AUTO_DETECTION" = true ]; then
    echo "Setting up auto-detection for feature requests..."
    if [ -f "CLAUDE.md" ]; then
        # We're installing from the Do:PE AI repo to a target project
        # The current working directory should be the target project
        if [ ! -f "./CLAUDE.md" ]; then
            cp CLAUDE.md ./CLAUDE.md
            echo "✅ Auto-detection installed. Claude Code will now suggest '/do:plan' for feature requests."
            echo "💡 Commit CLAUDE.md to share auto-detection with your team."
        else
            echo "📝 CLAUDE.md already exists. You may want to merge auto-detection features manually."
        fi
    else
        echo "Warning: CLAUDE.md not found in source. Auto-detection not installed."
        echo "💡 You can manually copy CLAUDE.md from the Do:PE AI repository."
    fi
fi

# Verify installation
if [ -f ~/.claude/commands/do/do:plan.md ] && [ -f ~/.claude/commands/do/do:list.md ] && [ -f ~/.do/config.json ]; then
    echo "✅ Do:PE AI v2.4 installation successful!"
    echo ""
    echo "🧠 AI-Powered Commands Available:"
    echo "  /user:do:plan \"requirement\"    - AI-powered PRD creation"
    echo "  /user:do:review <prd-file>     - Senior engineering review"
    echo "  /user:do:build <prd-file>      - Feature implementation"
    echo "  /user:do:list                 - Show plans and sessions"
    echo "  /user:do:continue <session>   - Resume interrupted sessions"
    echo "  /user:do:configure            - Configure AI questioning"
    echo "  /user:do:status               - System health dashboard"
    echo "  /user:do:install              - Install to current project"
    echo ""
    echo "⚡ Quick Start Examples:"
    echo "  /user:do:plan \"Add user authentication\"       # AI questioning"
    echo "  /user:do:plan \"Add CRUD ops, skip questions\"    # Skip mode"
    echo ""
    echo "👥 For team setup: /user:do:install in your project directory"
    if [ "$AUTO_DETECTION" = true ]; then
        echo "🎯 Auto-detection enabled: Claude Code will suggest '/do:plan' for feature requests"
    else
        echo "💡 Tip: Use --with-auto-detection for automatic '/do:plan' suggestions"
    fi
    echo "📚 Documentation: https://github.com/jmcopeland/ai-product-manager/tree/main/docs"
else
    echo "❌ Installation failed. Please check file permissions and try again."
    exit 1
fi