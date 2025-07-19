# Do:PE AI Release Notes

## v2.7.0 - Intelligent Workflow Router
**Release Date**: July 19, 2025  
**Focus**: Smart Workflow Routing with Intelligent Decision Making

### 🎯 Major Features

#### NEW: `/do` Command - Intelligent Workflow Router
- **Smart Input Analysis**: Analyzes user input and existing files to determine optimal workflow entry point
- **File System Scanning**: Automatically checks `.do/ideas/`, `.do/validations/`, and `.do/plans/` for related files
- **Intelligent Recommendations**: Suggests next logical step based on existing project state
- **Interactive Menu**: Presents clear options with reasoning for user choice
- **Seamless Integration**: Works with all existing workflow commands while maintaining backward compatibility

#### 🧠 Smart Routing Logic
- **New Ideas** (no related files) → Recommends `/do:think` (capture idea first)
- **Existing Ideas** (idea files found) → Recommends `/do:validate` (validate next)
- **Validated Features** (validation files found) → Recommends `/do:plan` (plan next)
- **Planned Features** (plan files found) → Recommends `/do:design` or `/do:review` (design/review next)

#### 📋 Enhanced User Experience
```bash
# One command entry point for everything
/do "Add user authentication"

# Router analyzes and presents:
# 🤖 Smart Routing Analysis
# 💡 Recommendation: think
# 🚀 Choose your next step: [1-8 options]
```

### 🔧 Technical Improvements
- **Command Architecture**: Moved main router to `.claude/commands/do.md` for cleaner hierarchy
- **Fallback Safety**: Always defaults to `/do:think` when routing is unclear
- **Documentation Updates**: Updated all docs to reflect new routing capabilities

---

## v2.6.0 - Complete Validation Workflow and Idea Capture
**Release Date**: July 6, 2025  
**Focus**: Full Development Lifecycle with Idea Capture and Lean Validation

### 🎉 Major Features
Introducing the complete development lifecycle: **think → validate → plan → design → review → build**

#### 💡 NEW: `/do:think` Command - Rapid Idea Capture
- **Dual-Mode Operation**: Capture new ideas (`/do:think "idea"`) or list existing ideas (`/do:think`)
- **Intelligent File Management**: Creates `.do/ideas/` with central list and individual timestamped files
- **Workflow Integration**: Captured ideas work directly with `/do:validate` and `/do:plan`

#### ✅ NEW: `/do:validate` Command - Lean Validation Methodology
- **Smart Type Detection**: Auto-detects product vs feature validation with codebase analysis
- **Configurable Scoring**: 5-criteria framework with customizable weights (Problem Severity, Solution Confidence, Strategic Alignment, Resource Efficiency, Market Opportunity)
- **Comprehensive Templates**: 48 product validation questions, 50 feature validation questions
- **Go/No-Go Recommendations**: Clear decision thresholds with scoring breakdown

### 🔗 Complete Workflow Integration
- **Seamless File Handoffs**: `/do:think` → `/do:validate` → `/do:plan` with preserved context
- **Template Flag Preservation**: Maintains `--template=` flags during file processing
- **Smart File Resolution**: Checks `.do/ideas/` first, then absolute/relative paths

### 📊 Enhanced File Structure
```
.do/
├── ideas/                   # NEW: Captured ideas with central list
├── validations/             # NEW: Lean Validation Documents (LVDs)
├── plans/                   # Enhanced: Generated PRDs
├── questions/               # NEW: validate_product.md, validate_feature.md
└── templates/               # NEW: validation_score.md framework
```

### 🛠️ Technical Improvements
- **Enhanced Argument Processing**: Robust file detection with template flag preservation
- **Session Management**: Complete conversation tracking across all workflow stages
- **Error Handling**: Comprehensive error recovery with actionable guidance
- **Performance**: Atomic file operations with retry logic

### 🔧 Configuration
New validation settings in `.do/config.json`:
```json
{
  "validationDepth": "standard",
  "autoTypeDetection": true,
  "validationThreshold": 3.0,
  "scoringWeights": { ... }
}
```

### 🐛 Key Fixes
- **Fixed**: Template flags lost when processing idea files
- **Fixed**: File path resolution inconsistencies  
- **Fixed**: Session creation race conditions

## v2.5.0 - Template Flag Enhancement
**Release Date**: July 6, 2025  
**Focus**: Command-line Template Override for `/do:plan`

### 🎛️ New Template Flag Feature
Introducing command-line template selection for maximum flexibility in PRD generation!

#### Enhanced `/do:plan` Command
- **Template Override**: Use `--template=<name>` to override the default template
- **Syntax**: `/do:plan "requirement" --template=lean`
- **Error Handling**: Shows available templates when invalid template specified
- **Backward Compatibility**: Maintains existing behavior when no flag provided
- **Visual Feedback**: Shows template selection: "🚀 Analyzing: 'add auth' (using lean template)"

#### Available Templates
- **standard** - Comprehensive PRD with all sections (default)
- **agile** - Sprint-ready with story points and acceptance criteria
- **lean** - Minimal viable PRD for rapid development
- **technical** - Implementation-focused with architecture details
- **design-first** - UI/UX emphasis with design specifications
- **one-pager** - Concise single-page format
- **bdd** - Behavior-driven development with Given/When/Then

#### Template Selection Logic
1. **Command-line flag** takes highest precedence
2. **Config.json `prdTemplate`** used when no flag provided
3. **Error handling** shows available options for invalid templates
4. **Template validation** ensures selected template exists

### 🔧 Technical Implementation
- **Argument Parsing**: Robust parsing of quoted requirements and flags
- **Template Validation**: Early validation with user-friendly error messages
- **Session Metadata**: Tracks template selection source (flag vs config)
- **PRD Generation**: Uses selected template throughout entire process
- **Questioning Strategy**: Adapts questions based on template requirements

### 📋 Usage Examples
```bash
# Use specific template
/do:plan "Add user authentication" --template=lean

# Default behavior (uses config.json prdTemplate)
/do:plan "Add user authentication"

# Error handling
/do:plan "Add feature" --template=invalid
# Shows available templates and lets user choose
```

### 🏗️ Integration with Existing Workflow
- **Full Lifecycle Support**: Template selection affects entire plan → design → review → build flow
- **Engineering Review**: `/do:review` understands template context
- **Implementation**: `/do:build` uses template-specific PRD structure
- **Session Management**: Template selection preserved in session resumption

---

## v2.4.0 - Universal Development Lifecycle
**Release Date**: July 5, 2025  
**Focus**: Complete System Rename & Universal Product Development Commands

### 🚀 Major System Transformation
Complete evolution from product management tool to universal development lifecycle platform!

#### Universal Command Structure
- **Complete Rename**: All `pm:` commands renamed to `do:` for broader applicability
- **Directory Migration**: `.claude-pm/` moved to `.do/` for cleaner project structure
- **Universal Scope**: Beyond product management to complete development lifecycle

#### New Command Names
| Old Command | New Command | Purpose |
|-------------|-------------|---------|
| `/pm:plan` | `/do:plan` | Product requirements gathering |
| `/pm:review` | `/do:review` | Engineering review and technical analysis |
| `/pm:build` | `/do:build` | Feature implementation |
| `/pm:design` | `/do:design` | UI/UX design analysis |
| `/pm:list` | `/do:plan` (no args) | Show existing plans and sessions |
| `/pm:continue` | `/do:continue` | Resume plan or session |
| `/pm:configure` | `/do:configure` | Configuration management |
| `/pm:status` | `/do:status` | System health and status |

#### Directory Structure Changes
```
# Before (v2.3.0)
.claude-pm/
├── config.json
├── plans/
└── sessions/

# After (v2.4.0)  
.do/
├── config.json
├── plans/
└── sessions/
```

### 🎨 New `/do:design` Command
Introducing comprehensive UI/UX design analysis with senior designer AI persona!

#### Design Analysis Features
- **Design System Discovery**: Analyzes existing UI patterns and component libraries
- **Mockup Generation**: Creates detailed wireframes and UI specifications
- **Accessibility Review**: Ensures WCAG compliance and inclusive design
- **Responsive Design**: Multi-device layout considerations
- **User Experience Flow**: Journey mapping and interaction design

#### Design-Enhanced PRDs
- **Structured Design Notes**: Appends comprehensive design context to existing PRDs
- **Component Specifications**: Detailed UI component requirements
- **Design System Integration**: Leverages existing design patterns
- **Implementation Guidance**: Clear design-to-code translation notes

#### Complete Design Lifecycle
```bash
# Full development lifecycle now possible
/do:plan "Add user dashboard"     # Product Manager AI creates PRD
/do:design user-dashboard.md      # Senior Designer AI adds design specs  
/do:review user-dashboard.md      # Senior Engineer AI adds technical notes
/do:build user-dashboard.md       # Implement with complete context
```

### 🔧 Technical Improvements
- **Mandatory Step Execution**: All workflow steps marked as MANDATORY to prevent skipping
- **Enhanced Session Management**: Improved session creation and tracking across all commands
- **Comprehensive Documentation**: All references updated to new command structure
- **Backward Compatibility**: Automatic migration support for existing .claude-pm directories

### 📦 Updated Installation
- **Auto-Detection Integration**: Updated CLAUDE.md guidance for new command names
- **Clean Migration**: Install script handles directory migration seamlessly
- **Team Sharing**: Git-friendly migration for team collaboration

### 🏗️ Architecture Evolution
This release represents a fundamental evolution in scope:

#### Before: Product Management Focus
- Limited to PM-specific workflows
- PM-centric terminology and structure
- Focused on requirements gathering

#### After: Universal Development Lifecycle
- Complete development lifecycle support
- Universal terminology suitable for all roles
- Comprehensive design → development → deployment pipeline

### 📊 Migration Guide
For existing v2.3.0 users:

```bash
# Automatic migration via install
./install.sh

# Commands automatically redirect
/pm:plan   → /do:plan  
/pm:review → /do:review
/pm:build  → /do:build
```

### 🎯 Future Vision
This release establishes the foundation for the complete development lifecycle:
```
plan → design → review → build → test → ship → learn
 📋     🎨      🔍      💻     🧪     🚀     📊
```

With `plan`, `design`, `review`, and `build` now implemented, upcoming releases will add:
- **`/do:test`** - Automated testing strategy and implementation
- **`/do:ship`** - Deployment and release management  
- **`/do:learn`** - Analytics, monitoring, and feedback collection

---

## v2.3.0 - Development Lifecycle Commands
**Release Date**: July 4, 2025  
**Focus**: Modular Development Lifecycle & Command Architecture

### 🔄 Development Lifecycle Restructure
Introducing a clear, modular command structure that maps to the complete development lifecycle!

#### New Command Architecture
- **`/do:plan`** - Product requirements gathering (renamed from `pm:define`)
- **`/do:review`** - Engineering review and technical analysis (split from `pm:implement`)  
- **`/do:build`** - Feature implementation (split from `pm:implement`)

#### Future-Ready Structure
This release establishes the foundation for the complete development lifecycle:
```
plan → design → review → build → test → ship → learn
 📋     🎨      🔍      💻     🧪     🚀     📊
```

### ⚡ Enhanced Workflow
The new three-step process provides better separation of concerns:

```bash
# Step 1: Plan the feature
/do:plan "Add user authentication"

# Step 2: Engineering review 
/do:review user-auth-20250704.md

# Step 3: Build the feature
/do:build user-auth-20250704.md
```

#### Benefits of the Split
- **Clearer responsibilities**: Product planning vs engineering review vs implementation
- **Better resumability**: Stop and resume at any stage of the development process
- **Modular approach**: Mix and match commands based on your workflow needs
- **Future extensibility**: Ready to add design, test, ship, and learn commands

### 🏗️ Backward Compatibility
- All existing PRDs continue to work seamlessly
- Configuration files automatically upgraded
- Documentation comprehensively updated
- Install scripts support new command structure

### 📊 Technical Improvements
- **Command modularity**: Each command has focused, single responsibility
- **Enhanced error handling**: Better guidance for missing files and invalid states
- **Improved documentation**: Updated examples and workflow guidance
- **Future-proof architecture**: Ready for upcoming lifecycle commands

---

## v2.2.0 - Engineering Implementation Release
**Release Date**: July 2, 2025  
**Focus**: Senior Engineering AI & Complete Implementation Pipeline

### 🔧 New `/do:implement` Command
Bridge the gap between PRD creation and feature implementation with senior-level engineering guidance!

#### Senior Engineering AI Persona
- **Technical Review**: Acts as experienced software engineer reviewing PRDs for implementation
- **Architecture Questions**: Covers scalability, maintainability, integration patterns
- **Security & Performance**: Addresses error handling, validation, optimization concerns
- **Testing Strategy**: Guides unit, integration, and acceptance testing approaches

#### Engineering-Enhanced PRDs
- **Structured Engineering Notes**: Appends comprehensive technical context to existing PRDs
- **Preserves Original Content**: Non-destructive enhancement of product requirements
- **Implementation Guidance**: Clear technical decisions and architectural choices
- **Risk Assessment**: Identifies potential issues and mitigation strategies

#### Seamless Implementation Flow
```bash
# Complete PRD-to-Code pipeline
/do:define "Add user authentication"     # Product Manager AI creates PRD
/do:implement user-auth-20250702.md     # Senior Engineer AI reviews & implements
```

#### Advanced Session Management
- **Engineering Sessions**: Separate technical questioning sessions with full audit trail
- **Complete Conversation Tracking**: Every question and answer preserved for resumability
- **Technical Context**: Architecture decisions, constraints, and implementation approach
- **Claude Code Integration**: Enhanced PRD handed off for actual code implementation

### 🎯 Enhanced Session Tracking
Complete overhaul of session management across all PM commands:

#### New Session Format
- **Complete Question History**: Full conversation audit trail with timestamps
- **Enhanced Resumability**: Perfect context restoration for interrupted sessions
- **Metadata Preservation**: Question rationale, categories, and response classifications
- **Simplified Format**: Single `questionHistory` array replaces complex dual-format system

#### Updated Commands
- **`/do:define`**: Enhanced question/answer tracking for PRD creation
- **`/do:continue`**: Improved session resumption with complete conversation context
- **`/do:implement`**: Engineering session management with technical question tracking

### 🏗️ Architecture Improvements
- **Command Integration**: Seamless integration with existing PM command suite
- **Error Handling**: Automatic fixes with escalation for complex implementation issues
- **File Management**: Robust PRD parsing with graceful fallback options
- **Performance**: Optimized session handling for large technical contexts

---

## v2.1.1 - Update Command Release
**Release Date**: July 2, 2025  
**Focus**: Automated Command Updates

### 🚀 New `/do:update` Command
Stay current with the latest features and bug fixes through automated command updates!

#### Key Features
- **Version Management**: Check current version, compare with latest from GitHub
- **Automated Updates**: Download new command files with one command
- **Safety First**: Automatic backups before any updates
- **Smart Scope Detection**: Updates user scope (`~/.claude/commands/`) or project scope (`.claude/commands/`)
- **Restore Capability**: Easy recovery from backups if needed

#### Usage
```bash
/do:update              # Update to latest version
/do:update v2.1.0       # Update to specific version  
/do:update --restore    # Restore from backup
```

#### Version Tracking
- **Config Integration**: Version tracking in `.do/config.json`
- **Repository Reference**: `updateRepository` field for fork customization
- **VERSION File**: Central version management via GitHub

#### Safety Features
- **Automatic Backups**: Timestamped backups in `.do/backups/`
- **Atomic Updates**: All-or-nothing file replacement
- **Network Resilience**: Retry logic and graceful error handling
- **Installation Verification**: Validates update success before completion

### 🔧 Technical Implementation
- **File Management**: Downloads all core commands and question templates
- **Error Recovery**: Comprehensive error handling with restore options
- **User Experience**: Clear progress indicators and confirmation prompts

### 📦 Configuration Updates
Updated `.do/config.json` schema:
```json
{
  "version": "2.1.1",
  "updateRepository": "jmcopeland/do-product-engineering",
  // ... existing configuration
}
```

---

## v2.1.0 - Performance Optimization Release
**Release Date**: July 1, 2025  
**Focus**: Smart Caching & Performance

### 🚀 Major Performance Breakthrough
The `/do:plan` command (list mode) now delivers **sub-second response times** through intelligent caching!

#### Performance Improvements
| Metric | Before | After | Improvement |
|--------|--------|-------|-------------|
| Response Time | 3+ minutes | <1 second | **1000x faster** |
| Cache Intelligence | None | Smart invalidation | Automatic updates |
| User Prompts | Required | None | Zero friction |
| Display Quality | Collapsed bash | Native Claude | Perfect readability |

### ⚡ Smart Caching System
- **Intelligent Invalidation**: Cache automatically updates when plans/sessions are modified
- **Native Claude Output**: No more collapsed bash script results
- **Zero Configuration**: Works automatically without setup

### 🔧 Technical Details
- **Cache Location**: `.do/.cache/list-cache.txt`
- **Validation Method**: Direct file modification time comparison
- **Cache Logic**: If cache is newer than all monitored files, use cache; otherwise rebuild
- **Monitored Files**: All `.md` files in `.do/plans/` and `.json` files in `.do/sessions/`

### 🎯 User Experience
- **Instant Results**: Most list operations now return in milliseconds
- **Always Fresh**: Cache invalidates automatically when you modify plans
- **Native Display**: Beautiful, readable output directly in Claude Code
- **No Interruptions**: Zero user prompts or permission requests

### 📦 Updated Commands
- **Enhanced `/do:plan`**: Smart caching with integrated list view
- **Updated Documentation**: Clear cache validation instructions
- **Improved Error Handling**: Graceful fallbacks if cache system unavailable

---

## v2.0.0 - AI-Powered Questioning Release
**Release Date**: July 1, 2025  
**Major Version**: v2.0 - AI-Powered Questioning

## 🎉 What's New

### 🧠 AI-Powered Questioning System
The biggest improvement in Do:PE AI is the introduction of intelligent, adaptive questioning that learns from your codebase and asks only relevant questions.

#### Before (v1):
- Fixed 20-50 template questions per category
- No codebase awareness
- Linear questioning flow

#### After (v2):
- 6-10 focused, relevant questions
- Pre-answers questions from codebase analysis
- Adaptive conversation flow with user control

### ⚡ Key Features

#### 1. Smart Codebase Analysis
- **Framework Detection**: Automatically identifies React, Vue, Django, Laravel, etc.
- **Pattern Recognition**: Finds existing auth, CRUD, UI, and API patterns
- **Pre-answering**: Skips questions already answered by your code
- **Performance Optimized**: 30-second analysis limit, targeted searches

#### 2. Adaptive Conversation Flow
- **One Question at a Time**: Clear context and rationale for each question
- **User Control Signals**: 
  - "good to go" → End questioning early
  - "skip" → Dismiss irrelevant questions
  - "why are you asking" → Get detailed rationale
  - "I don't know" → Get options (explore, defer, default, skip)

#### 3. Skip Questioning Mode
Generate PRDs instantly with codebase-informed assumptions:
```bash
/do:plan "Add user authentication, skip questions"
/do:plan "Add CRUD operations, make assumptions"
```

#### 4. Enhanced Session Management
- **Auto-save**: Progress saved after every interaction
- **Resumable Sessions**: Continue interrupted sessions with full context
- **Session Health**: Status monitoring and cleanup recommendations

#### 5. Improved User Experience
- **Visual Progress**: Topic-based progress indicators
- **Clear Messaging**: Emojis and structured presentation
- **Error Handling**: Comprehensive error messages with actionable guidance


## 📦 Simplified Distribution

### Single Source of Truth
- **Direct installation**: Install script copies directly from `.claude/commands/` structure
- **Easier maintenance**: No more sync issues between distribution and working versions
- **Git-friendly**: Teams can use git subtree for seamless updates

### Installation Benefits
- Simplified installation process
- Reduced repository complexity
- Better team collaboration via git integration
- Single point of maintenance for command updates

## 🔧 Configuration Enhancements

### New AI Options in `.do/config.json`:
```json
{
  "aiQuestioningOptions": {
    "useRelevanceFiltering": true,
    "questionsPerRound": 1,
    "adaptiveDepth": true,
    "includeRationale": true,
    "allowSkipQuestioning": true,
    "priorityThreshold": "medium"
  }
}
```

### New Directory Structure:
```
.do/
├── sessions/         # AI questioning sessions
└── questions/        # Custom question templates
    ├── auth.md      # Authentication (24 questions)
    ├── crud.md      # CRUD operations (34 questions)
    ├── ui.md        # UI components (42 questions)
    ├── api.md       # API integration (48 questions)
    └── general.md   # General features (48 questions)
```

## 🛠️ Technical Architecture

### Enhanced Command Structure
- **Main Command**: 309 lines of AI-powered logic
- **7-Step Process**: Config → Analysis → Codebase → Templates → Questioning → Generation → Cleanup
- **Session Format**: Comprehensive JSON with codebase analysis, question queue, and progress tracking
- **Error Handling**: Graceful degradation with clear user guidance

### Question Template System
- **Modular Templates**: Separate files for different feature types
- **AI Guidance**: Templates guide but don't limit AI questioning
- **Keyword Matching**: Smart template selection based on requirement analysis
- **Custom Templates**: Teams can add domain-specific question sets

## 📖 New Documentation

### Comprehensive Guides
- **[AI Questioning Guide](docs/AI-QUESTIONING.md)**: Complete v2 feature documentation
- **Updated README**: v2 features and installation
- **Enhanced CLAUDE.md**: Latest architecture details

### Installation Improvements
- **Enhanced Install Command**: Handles AI session directories and templates
- **Default AI Config**: New installations use AI-powered mode by default
- **Question Template Distribution**: Install command copies question templates


## 🎯 Use Cases

### Perfect for AI Mode:
- ✅ New complex features you're unfamiliar with
- ✅ Features requiring codebase integration
- ✅ When you want to learn about implementation options
- ✅ Team collaboration with shared context

### Perfect for Skip Mode:
- ⚡ Features you understand well
- ⚡ Simple additions to existing patterns
- ⚡ Rapid prototyping and iteration
- ⚡ When time is more important than exploration

### Perfect for Template Mode (v1):
- 📋 Comprehensive documentation requirements
- 📋 Compliance or audit scenarios
- 📋 Training new team members
- 📋 When you prefer exhaustive questioning

## 🐛 Bug Fixes

### Session Management
- Fixed session file corruption handling
- Improved concurrent session detection
- Better disk space management

### Performance Issues
- Limited git analysis to 10 commits (was 20)
- Added 30-second timeout for codebase analysis
- Optimized search patterns for large codebases

### User Experience
- Clearer error messages with actionable guidance
- Better progress indicators
- Improved question rationale presentation

## 🔮 Future Roadmap

### (Coming Soon)
- **Custom AI Models**: Support for different questioning personalities (engineer, designer, etc.)

### (Planned)
- **Advanced Filtering**: ML-based question relevance scoring
- **Team Templates**: Shared question template marketplace
- **Integration APIs**: Connect with project management tools
- **Analytics**: Question effectiveness and PRD quality metrics

## 📦 Installation

### New Installation
```bash
git clone https://github.com/jmcopeland/do-product-engineering.git
cd do-product-engineering
./install.sh
```

### Upgrade
```bash
git pull origin main
./install.sh
# Existing config automatically upgraded
```

### Team Installation
```bash
/user:do:install
git add .claude/commands/pm*
git commit -m "Upgrade to Do:PE AI with AI questioning"
```

## 🙏 Acknowledgments

### Community Feedback
Special thanks to early adopters who provided feedback on the template system limitations and requested more intelligent questioning.

### Design Principles
v2 was built on the principle that AI should **augment human judgment**, not replace it. The conversation control features ensure you remain in charge of the PRD creation process.

## 🐛 Known Issues

### Minor Limitations
- **Large Codebases**: Analysis limited to 30 seconds (graceful degradation)
- **Binary Files**: Analysis skips non-text files (expected behavior)
- **Git History**: Limited to 10 recent commits for performance

### Workarounds
- Use `/do:configure` to disable git analysis for faster startup
- Set `contextDepth: "surface"` for very large projects
- Use skip mode for rapid iteration on familiar features

## 📞 Support

- **Documentation**: [docs/](docs/) directory
- **Issues**: [GitHub Issues](https://github.com/jmcopeland/do-product-engineering/issues)
- **Status Check**: `/do:status` for system health
- **Configuration Help**: `/do:configure` for interactive setup

---

## 🎊 Welcome to Do:PE AI!

We're excited to see how AI-powered questioning transforms your product development workflow. The intelligent conversation system is designed to respect your expertise while ensuring comprehensive requirements coverage.

**Try it today**: `/do:plan "Add your next feature"` and experience the difference! 🚀