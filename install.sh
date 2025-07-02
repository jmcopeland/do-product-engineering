#!/bin/bash

# AI Product Manager v2 Installation Script
# Installs AI-powered PM commands to user's home directory

set -e

# Parse command line arguments
AUTO_DETECTION=false
if [[ "$1" == "--with-auto-detection" ]]; then
    AUTO_DETECTION=true
    echo "🤖 Installing AI Product Manager v2 with AI-powered questioning and auto-detection..."
else
    echo "🤖 Installing AI Product Manager v2 with AI-powered questioning..."
fi

# Create directories
echo "Creating directories..."
mkdir -p ~/.claude/commands/pm
mkdir -p ~/.claude-pm/{questions,sessions,plans}

# Copy command files
echo "Copying command files..."
cp .claude/commands/pm/pm:*.md ~/.claude/commands/

# Copy question templates
echo "Setting up AI question templates..."
cp .claude-pm/questions/*.md ~/.claude-pm/questions/ 2>/dev/null || {
    echo "Note: Question templates not found in source. Using built-in templates."
}

# Create default config
echo "Creating default AI configuration..."
if [ ! -f ~/.claude-pm/config.json ]; then
    cat > ~/.claude-pm/config.json << 'EOF'
{
  "questioningDepth": "standard",
  "maxQuestions": 8,
  "autoSave": true,
  "questioningMode": "ai-powered",
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
    echo "Created default AI configuration."
else
    echo "Existing config found - keeping your settings."
fi

# Install auto-detection if requested
if [ "$AUTO_DETECTION" = true ]; then
    echo "Setting up auto-detection for feature requests..."
    if [ -f "CLAUDE.md" ]; then
        # We're installing from the AI Product Manager repo to a target project
        # The current working directory should be the target project
        if [ ! -f "./CLAUDE.md" ]; then
            cp CLAUDE.md ./CLAUDE.md
            echo "✅ Auto-detection installed. Claude Code will now suggest /pm for feature requests."
            echo "💡 Commit CLAUDE.md to share auto-detection with your team."
        else
            echo "📝 CLAUDE.md already exists. You may want to merge auto-detection features manually."
        fi
    else
        echo "Warning: CLAUDE.md not found in source. Auto-detection not installed."
        echo "💡 You can manually copy CLAUDE.md from the AI Product Manager repository."
    fi
fi

# Verify installation
if [ -f ~/.claude/commands/pm:define.md ] && [ -f ~/.claude/commands/pm:list.md ] && [ -f ~/.claude-pm/config.json ]; then
    echo "✅ AI Product Manager v2 installation successful!"
    echo ""
    echo "🧠 AI-Powered Commands Available:"
    echo "  /user:pm:define \"requirement\"  - AI-powered PRD creation"
    echo "  /user:pm:list                 - Show plans and sessions"
    echo "  /user:pm:continue <session>   - Resume interrupted sessions"
    echo "  /user:pm:configure            - Configure AI questioning"
    echo "  /user:pm:status               - System health dashboard"
    echo "  /user:pm:install              - Install to current project"
    echo ""
    echo "⚡ Quick Start Examples:"
    echo "  /user:pm:define \"Add user authentication\"     # AI questioning"
    echo "  /user:pm:define \"Add CRUD ops, skip questions\"  # Skip mode"
    echo ""
    echo "👥 For team setup: /user:pm:install in your project directory"
    if [ "$AUTO_DETECTION" = true ]; then
        echo "🎯 Auto-detection enabled: Claude Code will suggest /pm for feature requests"
    else
        echo "💡 Tip: Use --with-auto-detection for automatic /pm suggestions"
    fi
    echo "📚 Documentation: https://github.com/jmcopeland/ai-product-manager/tree/main/docs"
else
    echo "❌ Installation failed. Please check file permissions and try again."
    exit 1
fi