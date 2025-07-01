#!/bin/bash

# AI Product Manager v2 Installation Script
# Installs AI-powered PM commands to user's home directory

set -e

echo "🤖 Installing AI Product Manager v2 with AI-powered questioning..."

# Create directories
echo "Creating directories..."
mkdir -p ~/.claude/commands/pm
mkdir -p ~/.claude-pm/{questions,sessions,plans}

# Copy command files
echo "Copying command files..."
cp .claude/commands/pm.md ~/.claude/commands/
cp .claude/commands/pm/*.md ~/.claude/commands/pm/

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

# Verify installation
if [ -f ~/.claude/commands/pm.md ] && [ -f ~/.claude/commands/pm/list.md ] && [ -f ~/.claude-pm/config.json ]; then
    echo "✅ AI Product Manager v2 installation successful!"
    echo ""
    echo "🧠 AI-Powered Commands Available:"
    echo "  /user:pm \"requirement\"        - AI-powered PRD creation"
    echo "  /user:pm:list                 - Show plans and sessions"
    echo "  /user:pm:continue <session>   - Resume interrupted sessions"
    echo "  /user:pm:configure            - Configure AI questioning"
    echo "  /user:pm:status               - System health dashboard"
    echo "  /user:pm:install              - Install to current project"
    echo ""
    echo "⚡ Quick Start Examples:"
    echo "  /user:pm \"Add user authentication\"     # AI questioning"
    echo "  /user:pm \"Add CRUD ops, skip questions\"  # Skip mode"
    echo ""
    echo "👥 For team setup: /user:pm:install in your project directory"
    echo "📚 Documentation: https://github.com/jmcopeland/ai-product-manager/tree/main/docs"
else
    echo "❌ Installation failed. Please check file permissions and try again."
    exit 1
fi