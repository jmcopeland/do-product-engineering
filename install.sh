#!/bin/bash

# Claude PM Installation Script
# Installs Claude PM commands to user's home directory

set -e

echo "🤖 Installing Claude PM commands..."

# Create directories
echo "Creating directories..."
mkdir -p ~/.claude/commands/pm

# Copy files
echo "Copying command files..."
cp commands/pm.md ~/.claude/commands/
cp commands/pm/*.md ~/.claude/commands/pm/

# Verify installation
if [ -f ~/.claude/commands/pm.md ] && [ -f ~/.claude/commands/pm/list.md ]; then
    echo "✅ Installation successful!"
    echo ""
    echo "Available commands:"
    echo "  /user:pm \"requirement\"     - Start new PRD creation"
    echo "  /user:pm:list              - Show existing plans"
    echo "  /user:pm:continue <plan>   - Resume plan development"
    echo "  /user:pm:configure         - Manage settings"
    echo "  /user:pm:status            - Show current state"
    echo "  /user:pm:install           - Install to current project"
    echo ""
    echo "Try: /user:pm \"Add user login to my app\""
    echo ""
    echo "For team setup, run /user:pm:install in your project directory."
else
    echo "❌ Installation failed. Please check file permissions."
    exit 1
fi