# Usage Examples

Real-world examples of using Do:PE AI with AI-powered questioning and complete development lifecycle.

## 🚀 Quick Start Examples

### Authentication Feature
```bash
/user:do:plan "Add user authentication to my React app"

# AI will analyze your React codebase and ask focused questions like:
# - "I see you're using React with no existing auth. Should users sign up with email/password or social login?"
# - "Should user sessions persist across browser sessions?"
# - "Do you need role-based permissions or just basic auth?"
```

### Using Template Flags
```bash
# Use lean template for rapid development
/user:do:plan "Add user authentication" --template=lean
# 🚀 Analyzing: "Add user authentication" (using lean template)

# Use technical template for implementation details
/user:do:plan "Add API endpoints" --template=technical

# Use agile template for sprint planning
/user:do:plan "Add shopping cart" --template=agile
```

### CRUD Operations
```bash
/user:do:plan "Add blog post management"

# AI detects your existing patterns and asks:
# - "I found your user model. Should blog posts belong to users?"
# - "What fields should blog posts have besides title and content?"
# - "Should there be a publish/draft status system?"
```

### UI Components
```bash
/user:do:plan "Add user dashboard"

# AI analyzes your UI framework and asks:
# - "I see you're using Material-UI. Should the dashboard follow your existing navigation pattern?"
# - "What key metrics should users see on their dashboard?"
# - "Should it be a single page or tabbed interface?"
```

## 🔧 Complete Implementation Flow

### End-to-End PRD to Code
```bash
# Step 1: Create PRD with Product Manager AI (with template override)
/user:do:plan "Add user authentication to my React app" --template=technical
# → Generates: user-auth-20250702-140000.md (using technical template)

# Step 2: Engineering review
/user:do:review user-auth-20250702-140000.md

# Step 3: Feature implementation
/user:do:build user-auth-20250702-140000.md

# Senior Engineer AI will:
# 1. Review the PRD for technical feasibility
# 2. Ask architecture questions like:
#    - "Should we use JWT tokens or session-based auth?"
#    - "What security measures for password storage?"
#    - "How should we handle token refresh?"
# 3. Add Engineering Notes to the PRD
# 4. Hand off to Claude Code for implementation
```

### Implementation with Existing PRDs
```bash
# Review any existing PRD
/user:do:review blog-management-20250701.md

# Then build the feature
/user:do:build blog-management-20250701.md

# Engineering review covers:
# - Database schema decisions
# - API endpoint design  
# - Error handling strategies
# - Testing requirements
# - Security considerations
```

## ⚡ Skip Mode Examples

### When You Know What You Want
```bash
/user:do:plan "Add delete confirmation modal, skip questions"
/user:do:plan "Add password reset flow, make assumptions"
/user:do:plan "Add user profile editing, use best practices"
```

### Rapid Prototyping
```bash
/user:do:plan "Add shopping cart functionality, skip questions"
# Generates comprehensive PRD based on:
# - Your existing e-commerce patterns
# - Industry best practices
# - Framework conventions
```

## 🎯 Conversation Control Examples

### Early Completion
```
User: /user:do:plan "Add user notifications"
AI: How should notifications be delivered? (email, in-app, push, SMS)
User: Email and in-app notifications
AI: Should users be able to customize notification preferences?
User: Good to go
AI: ✅ Perfect! I have enough information to create a comprehensive PRD.
```

### Skipping Irrelevant Questions
```
AI: Should the notification system support real-time WebSocket updates?
User: Not relevant, skip
AI: 👍 Understood, skipping that aspect.
AI: How should notification history be stored and displayed?
```

### Getting More Context
```
AI: Should notifications have categories or tags?
User: Why are you asking?
AI: 💡 Great question! Here's why this matters:
     
     Business impact: Categories help users manage notification overload
     Technical impact: Affects database schema and filtering logic
     PRD impact: Defines the notification management UI section
     
     Should notifications have categories or tags?
```

## 🏢 Team Collaboration Examples

### Project Installation
```bash
# Team lead installs for project
cd my-team-project
/user:do:install

# Commit for team sharing
git add .claude/commands/pm/*
git commit -m "Add Do:PE AI for team PRD generation"

# Team members can now use project commands
/do:plan "Add feature X"  # Uses project-specific settings
```

### Custom Question Templates
```bash
# Create domain-specific questions
mkdir -p .do/questions
cat > .do/questions/fintech.md << 'EOF'
## Compliance Questions
- What regulatory requirements apply? (PCI DSS, SOX, etc.)
- Are there audit trail requirements?
- What data retention policies apply?

## Security Questions  
- What authentication methods are required? (2FA, etc.)
- Are there IP whitelisting requirements?
- What encryption standards must be used?
EOF

# Use in requirements
/pm "Add payment processing"  # Will use fintech questions
```

## 📊 Advanced Configuration Examples

### High-Velocity Team (Fewer Questions)
```json
{
  "prdTemplate": "lean",
  "aiQuestioningOptions": {
    "priorityThreshold": "high",
    "allowSkipQuestioning": true,
    "adaptiveDepth": false
  }
}
```

### Template Override Examples
```bash
# Override default template for specific features
/user:do:plan "Add complex feature" --template=technical

# Use one-pager for simple features
/user:do:plan "Add button component" --template=one-pager

# BDD approach for testing-focused development
/user:do:plan "Add validation system" --template=bdd

# Design-first approach for UI features
/user:do:plan "Add dashboard layout" --template=design-first
```

### Detailed Documentation Team (More Questions)
```json
{
  "aiQuestioningOptions": {
    "priorityThreshold": "low",
    "useRelevanceFiltering": false,
    "includeRationale": true
  }
}
```

### AI-Powered Mode (Using Templates as Guides)
```json
{
  "aiQuestioningOptions": {
    "useRelevanceFiltering": true,
    "priorityThreshold": "medium"
  }
}
```

## 🔄 Session Management Examples

### Resuming Interrupted Sessions
```bash
# Session gets interrupted
/user:do:plan "Add multi-tenant support"
# ... answers 3 questions then gets interrupted

# Later, resume the session
/user:do:list
# Shows: 🔄 multi-tenant-support-20250701-140000 - In Progress

/user:do:continue multi-tenant-support-20250701-140000
# Continues exactly where you left off
```

### Managing Multiple Sessions
```bash
/user:do:status
# Shows:
# Active Sessions: 2
# ⚠️ user-auth-20250701-120000 (stale, 2 days old)
# 🔄 dashboard-20250701-140000 (active, 3 questions asked)
```

## 🛠️ Codebase Analysis Examples

### Framework Detection
```bash
# In a Next.js project
/user:do:plan "Add API endpoints"
# AI detects: "I see you're using Next.js with API routes in /pages/api/..."

# In a Django project  
/user:do:plan "Add REST API"
# AI detects: "I found Django REST Framework. Should we follow your existing ViewSet patterns?"
```

### Existing Pattern Recognition
```bash
# With existing auth system
/user:do:plan "Add user roles"
# AI: "I see you're already using JWT auth with a User model. Should roles be..."

# With existing UI components
/user:do:plan "Add data table"
# AI: "I found your existing Table component in /components/. Should the new data table..."
```

## 🎨 Different PRD Styles

### Agile/Sprint Ready
```json
{
  "prdTemplate": "agile",
  "complexityScale": 5
}
```
Generates PRDs with story points, sprint planning, and acceptance criteria.

### Technical Implementation Focus  
```json
{
  "prdTemplate": "technical",
  "includeImplementationNotes": true
}
```
Emphasizes architecture, database design, and API specifications.

### Business Stakeholder Format
```json
{
  "prdTemplate": "standard",
  "includeImplementationNotes": false
}
```
Focuses on user stories, business value, and success metrics.

## 🚨 Error Recovery Examples

### Large Codebase Timeout
```
⚠️ Codebase analysis taking longer than expected. 
   Continuing with partial analysis...
   
For faster startup: /user:do:configure → set analyzeGitHistory: false
```

### Session Recovery
```
⚠️ Session file corrupted. Backed up to user-auth-20250701.backup. 
   Starting fresh session with same requirement.
```

### Template Issues
```
⚠️ Custom question templates not found. Using built-in templates.
   To add custom templates: create .do/questions/yourtemplate.md
```

## 💡 Pro Tips

### 1. Let AI Pre-Answer
Trust the codebase analysis - it often knows more than you think.

### 2. Use Control Signals Effectively
- "Good to go" when you're confident about the direction
- "Skip" for questions that don't apply to your specific use case
- "Why are you asking" to understand the business context

### 3. Leverage Skip Mode for Known Patterns
```bash
/user:do:plan "Add standard CRUD for products, skip questions"
```

### 4. Customize for Your Domain
Create `.do/questions/` templates for your industry or company patterns.

### 5. Review Generated Assumptions
When using skip mode, always review the "Assumptions Made" section in the generated PRD.

## 🔍 Troubleshooting Examples

### Performance Issues
```bash
# Check system health
/user:do:status

# Clean up old sessions
# Shows cleanup recommendations

# Optimize for large codebases
/user:do:configure
# Set: contextDepth: "surface", analyzeGitHistory: false
```

### Question Relevance Issues
```bash
# Too many irrelevant questions
/user:do:configure
# Increase priorityThreshold to "high"

# Too few questions  
/user:do:configure
# Decrease priorityThreshold to "low"
```

### Team Onboarding
```bash
# For new team members
/user:do:configure
# Set: questioningDepth: "thorough"  # More comprehensive
# Set: includeRationale: true        # Educational
```