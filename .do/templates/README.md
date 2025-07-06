# PRD Templates for Do:PE AI

This directory contains various Product Requirements Document (PRD) templates optimized for different use cases and methodologies. Each template is designed to capture the right level of detail for specific contexts.

## Available Templates

### 📋 Standard Template (`standard.md`)
**Best for**: Comprehensive feature documentation, enterprise projects, complex features

**Use when**:
- You need thorough documentation
- Multiple stakeholders are involved
- Feature has significant technical complexity
- Long-term maintenance is important

**Sections**: Context, User Stories, Requirements, Acceptance Criteria, Implementation Notes, Success Metrics, TODOs

---

### 🏃 Agile User Story Template (`agile.md`)
**Best for**: Scrum teams, sprint planning, iterative development

**Use when**:
- Working in sprints
- Need to estimate story points
- Following agile methodology
- Feature can be broken into small chunks

**Sections**: Story, Acceptance Criteria (Given/When/Then), Technical Tasks, Definition of Done

---

### 💡 Lean Canvas Template (`lean.md`)
**Best for**: Startups, MVPs, feature validation, rapid experimentation

**Use when**:
- Building an MVP
- Need to validate assumptions
- Limited resources
- Focus on business value

**Sections**: Problem, Solution, Key Metrics, Value Proposition, Customer Segments, Risks

---

### 🔧 Technical RFC Template (`technical.md`)
**Best for**: Architecture changes, API design, platform features, technical deep-dives

**Use when**:
- Making architectural decisions
- Designing APIs
- Need peer review from engineers
- Performance/security is critical

**Sections**: Architecture, API Design, Data Model, Alternatives, Security, Performance, Migration

---

### 🎨 Design-First Template (`design-first.md`)
**Best for**: UI-heavy features, consumer products, design-led development

**Use when**:
- Design drives the feature
- Visual experience is critical
- Need detailed component specs
- Accessibility is important

**Sections**: Vision, User Journey, Component Specs, Accessibility, Brand Alignment, Handoff Notes

---

### 📄 One-Pager Template (`one-pager.md`)
**Best for**: Executive reviews, quick decisions, initial pitches

**Use when**:
- Need quick approval
- Presenting to executives
- Initial feature pitch
- Resource allocation decisions

**Sections**: Problem, Solution, Benefits, Effort, ROI, Risks, Decision Needed

---

### 🧪 BDD Specification Template (`bdd.md`)
**Best for**: Test-driven development, QA handoff, behavior specification

**Use when**:
- Test-first approach
- Need clear behavior specs
- Strong QA involvement
- Automation is priority

**Sections**: Feature Description, Scenarios (Gherkin), Test Data, Automation Guidelines

## How to Use Templates

### With Do:PE AI Commands

1. **Configure your preferred template** in `.do/config.json`:
   ```json
   {
     "prdTemplate": "standard"  // or "agile", "lean", etc.
   }
   ```

2. **Use the template** when running commands:
   ```bash
   /do:plan "Add user authentication"
   # Will use your configured template
   ```

3. **Override template** for specific use:
   ```bash
   /do:plan "Add quick fix" --template=one-pager
   # Note: Use --template=<name> syntax (with equals sign)
   ```

### New in v2.5.0: Template Flag Override

You can now override the default template using the `--template` flag:

```bash
# Override for this specific PRD
/do:plan "Add user authentication" --template=lean
# Shows: 🚀 Analyzing: "Add user authentication" (using lean template)

# Use different templates for different scenarios
/do:plan "Add complex API" --template=technical
/do:plan "Quick UI fix" --template=one-pager
/do:plan "Sprint feature" --template=agile
```

**Available template names:**
- `standard` - Default comprehensive template
- `agile` - Sprint-ready with story points
- `lean` - Minimal viable PRD
- `technical` - Architecture and implementation focus
- `design-first` - UI/UX driven development
- `one-pager` - Executive summary format
- `bdd` - Behavior-driven development specs

**Error handling:**
If you specify an invalid template, Do:PE AI will show available options and let you choose.

### Manual Usage

1. **Copy the template**:
   ```bash
   cp .do/templates/agile.md my-feature-prd.md
   ```

2. **Fill in the sections** with your content

3. **Remove unused sections** if not applicable

## Choosing the Right Template

```
Is it a technical/architecture change?
  Yes → technical.md
  No ↓

Is it for executive approval?
  Yes → one-pager.md
  No ↓

Is design the primary driver?
  Yes → design-first.md
  No ↓

Are you in a startup/MVP mode?
  Yes → lean.md
  No ↓

Do you follow strict agile/scrum?
  Yes → agile.md
  No ↓

Need comprehensive documentation?
  Yes → standard.md
  No ↓

Focus on test specifications?
  Yes → bdd.md
```

## Customizing Templates

Feel free to:
1. **Modify existing templates** to match your team's needs
2. **Create new templates** for your specific use cases
3. **Combine sections** from different templates
4. **Add company-specific sections** (compliance, legal, etc.)

### Creating a Custom Template

1. Copy an existing template as a starting point:
   ```bash
   cp standard.md custom-template.md
   ```

2. Modify sections to match your needs

3. Update `.do/config.json` to use your template:
   ```json
   {
     "prdTemplate": "custom-template"
   }
   ```

## Best Practices

1. **Start simple**: Use one-pager or lean for initial ideas
2. **Graduate to detailed**: Move to standard or technical as feature matures
3. **Match the audience**: Technical RFC for engineers, one-pager for executives
4. **Iterate**: PRDs are living documents, update as you learn
5. **Don't over-document**: Choose the right level of detail for the context

## Template Maintenance

- Templates are versioned with Do:PE AI
- Updates to templates won't affect existing PRDs
- Feel free to evolve templates based on team feedback
- Share useful templates back to the community!

## Questions?

- See main [Do:PE AI documentation](../../README.md)
- Submit template suggestions via GitHub issues
- Share your custom templates with the community