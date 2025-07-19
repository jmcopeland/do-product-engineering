# PRD: Do Validate Command - Feature Validation Workflow

**Generated**: 2025-07-05 22:58:00  
**Requirement**: "Create /do:validate command using lean template for feature validation"  
**Complexity**: 4/5  
**Status**: Ready for Development

## Context

The Do:PE AI system currently provides comprehensive planning and implementation workflows but lacks a crucial validation step to determine whether features should be built in the first place. This PRD introduces a new `/do:validate` command that uses lean startup methodology adapted for feature validation, creating a vital gate before the planning phase.

This establishes a complete development lifecycle: **validate → plan → design → review → build**, ensuring teams validate assumptions and business value before investing in detailed planning and development.

## User Stories

### As a Product Manager
- I want to validate feature ideas before investing time in detailed planning
- So that I can filter out low-value features and focus resources on high-impact work
- I want a standardized validation framework that my team can consistently apply

### As a Startup Founder  
- I want to validate product ideas with lean methodology
- So that I can test assumptions and reduce the risk of building something nobody wants
- I want both lightweight and thorough validation depending on the idea's complexity

### As a Developer
- I want validation insights to inform technical planning
- So that I understand the business context and constraints before building features
- I want validation data to pre-populate planning questions where relevant

### As a Team Lead
- I want configurable validation scoring to match our decision criteria
- So that our team makes consistent go/no-go decisions
- I want validation documentation that can be referenced throughout development

## Core Requirements

### 1. Command Structure and Integration
- **Command Name**: `/do:validate "[requirement]"`
- **Workflow Position**: Optional but recommended step before `/do:plan`
- **Integration**: `/do:plan <validation-file>` to feed validation into planning
- **Override Flags**: `--type product|feature` to manually specify validation type

### 2. Intelligent Validation Type Detection
- **Auto-Detection Logic**:
  - **Product signals**: "startup idea", "new platform", "create app", standalone concepts
  - **Feature signals**: "add to existing", "improve our", "enhance", mentions of current systems
  - **Codebase analysis**: Large codebase = feature, empty/scaffold = product
  - **User override**: Manual flags always take precedence

- **Detection Process**:
  1. Analyze requirement text for product/feature keywords
  2. Scan codebase size and structure (fast analysis)
  3. Present recommendation with confidence level
  4. Allow user to accept or override with explanation

### 3. Validation Depth Selection
- **Smart Depth Detection**:
  - **Lightweight**: Simple features, UI changes, minor enhancements
  - **Full**: Complex features, new systems, high business risk, significant effort
  
- **Depth Factors**:
  - Complexity indicators (integration, real-time, collaborative)
  - User impact scope (internal tool vs customer-facing)
  - Business risk level (revenue impact, strategic importance)
  - Development effort (new technology, architecture changes)

- **User Experience**:
  ```
  🎯 Validation Recommendation: Full validation
  
  Detected signals:
  • High complexity: "social media integration"
  • Customer-facing feature with business risk
  • Significant development effort required
  
  Proceed with full validation? (y/n)
  Alternative: lightweight validation (l)
  ```

### 4. Question Templates and Flow
- **Template Files**:
  - `validate_product.md` - Product-level lean canvas questions
  - `validate_feature.md` - Feature-level validation questions adapted from lean methodology

- **Questioning Flow**: Sequential CLI format consistent with existing commands
  - One question at a time with progress indicators
  - Session auto-save and resumability
  - Standard user controls (skip, good to go, explain, etc.)

- **Question Categories for Features**:
  - Problem validation (user pain, frequency, current solutions)
  - Solution fit (proposed approach, alternatives considered)
  - User segments (who benefits, adoption likelihood)
  - Success metrics (measurable outcomes, success criteria)
  - Business case (resource investment, strategic alignment)
  - Risk assessment (technical, market, execution risks)

### 5. Configurable Scoring System
- **Default Scoring Framework** (`validation_score.md`):
  ```markdown
  # Validation Scoring System
  
  ## Scoring Criteria (1-5 scale)
  
  ### Problem Severity (25% weight)
  - 5: Critical pain point, high frequency
  - 3: Moderate inconvenience  
  - 1: Nice-to-have improvement
  
  ### Solution Confidence (25% weight)
  - 5: Proven solution, clear user validation
  - 3: Reasonable approach, some uncertainty
  - 1: Experimental, high uncertainty
  
  ### Strategic Alignment (20% weight)
  - 5: Core to business strategy
  - 3: Supports strategic goals
  - 1: Tangential benefit
  
  ### Resource Efficiency (15% weight)
  - 5: Low effort, high impact
  - 3: Moderate effort/impact ratio
  - 1: High effort, uncertain impact
  
  ### Market Opportunity (15% weight)
  - 5: Large addressable market
  - 3: Niche but valuable market
  - 1: Limited market opportunity
  
  ## Scoring Thresholds
  - 4.0+: Strong Go (high confidence)
  - 3.0-3.9: Conditional Go (proceed with caution)
  - 2.0-2.9: Weak No (significant concerns)
  - <2.0: Strong No (do not proceed)
  ```

- **Customization**: Teams can modify `validation_score.md` to match their criteria
- **Transparency**: Always show how the score was calculated

### 6. Lean Validation Document (LVD) Output
- **File Format**: `[feature-name]-validation-[timestamp].md`
- **Template**: Adapted from `lean.md` template for feature context
- **Sections**:
  - Executive summary with go/no-go recommendation
  - Problem analysis and validation
  - Solution approach and confidence level
  - Market/user segment analysis
  - Success metrics and measurement plan
  - Resource requirements and timeline
  - Risk assessment and mitigation strategies
  - Validation score breakdown
  - Next steps and follow-up questions

### 7. Session Management and Integration
- **Session Structure**: 
  ```json
  {
    "sessionId": "validate-[requirement-slug]-[timestamp]",
    "sessionType": "validation",
    "validationType": "product|feature",
    "validationDepth": "lightweight|full",
    "requirement": "[original requirement]",
    "detectionAnalysis": {
      "productSignals": ["signal1", "signal2"],
      "featureSignals": ["signal1", "signal2"], 
      "codebaseAnalysis": "large|medium|small|empty",
      "confidence": "high|medium|low"
    },
    "questionHistory": [...],
    "validationScore": {
      "finalScore": 3.4,
      "breakdown": {...},
      "recommendation": "conditional_go"
    }
  }
  ```

- **Planning Integration**: 
  - When running `/do:plan validation-file.md`, load LVD content
  - Use validation insights to pre-answer relevant planning questions
  - Reference validation decisions in PRD assumptions section
  - Maintain separation between validation and planning sessions

## Acceptance Criteria

1. **Command Execution**
   - [ ] `/do:validate "[requirement]"` creates validation session
   - [ ] Auto-detects product vs feature validation type
   - [ ] Presents detection rationale and allows override
   - [ ] Supports manual type selection with `--type` flag

2. **Validation Type Detection**
   - [ ] Correctly identifies product vs feature based on requirement text
   - [ ] Analyzes codebase size/structure for additional context
   - [ ] Presents clear reasoning for detection decision
   - [ ] Allows user override with explanation

3. **Depth Selection**
   - [ ] Recommends lightweight vs full validation based on complexity
   - [ ] Explains recommendation rationale
   - [ ] Allows user to accept or choose alternative depth

4. **Question Templates**
   - [ ] `validate_product.md` template covers lean canvas methodology
   - [ ] `validate_feature.md` template adapts lean principles for features
   - [ ] Questions flow logically and build on each other
   - [ ] Template selection matches validation type

5. **Scoring System**
   - [ ] Default `validation_score.md` provides balanced framework
   - [ ] Configuration is user-customizable
   - [ ] Score calculation is transparent and explained
   - [ ] Recommendation thresholds are clear

6. **LVD Generation**
   - [ ] Creates comprehensive validation document
   - [ ] Includes clear go/no-go recommendation with reasoning
   - [ ] Shows validation score breakdown
   - [ ] Provides actionable next steps

7. **Planning Integration**
   - [ ] `/do:plan validation-file.md` successfully loads validation data
   - [ ] Validation insights pre-answer relevant planning questions
   - [ ] Planning PRD references validation decisions appropriately
   - [ ] Sessions remain separate but linked

8. **Session Management**
   - [ ] Auto-saves session after each question/answer
   - [ ] Supports resumption via `/do:continue`
   - [ ] Archives completed sessions appropriately
   - [ ] Handles interruptions gracefully

## Implementation Notes

### Technical Considerations
- **Command File**: Create `do:validate.md` following existing command patterns
- **Question Templates**: Create `validate_product.md` and `validate_feature.md` in `.do/questions/`
- **Scoring Configuration**: Create default `validation_score.md` in `.do/templates/`
- **Template Integration**: Modify existing `lean.md` template for LVD output format

### File Structure Updates
```
.do/
├── questions/
│   ├── validate_product.md    # Product validation questions
│   └── validate_feature.md    # Feature validation questions
├── templates/
│   ├── validation_score.md    # Default scoring system
│   └── lean.md               # Enhanced for LVD output
└── sessions/
    └── validate-*-*.json     # Validation sessions
```

### Integration Points
- **Detection Logic**: Enhance requirement analysis in existing commands
- **Planning Commands**: Modify `/do:plan` to handle validation file input
- **Configuration**: Extend `.do/config.json` for validation preferences

### Dependencies
- Existing session management infrastructure
- Question template loading system
- File generation and management utilities
- Codebase analysis capabilities

## Success Metrics

1. **Adoption**: % of features that go through validation before planning
2. **Quality**: Reduction in cancelled projects after planning phase
3. **Efficiency**: Time saved by avoiding planning of low-value features
4. **Accuracy**: Validation score correlation with actual feature success
5. **User Satisfaction**: Team feedback on validation process value

## TODOs and Future Considerations

1. **Question Template Development**:
   - [ ] Create comprehensive `validate_product.md` question set
   - [ ] Create feature-focused `validate_feature.md` questions
   - [ ] Test question flow with various requirement types

2. **Scoring System Refinement**:
   - [ ] Validate default scoring weights with product teams
   - [ ] Create industry-specific scoring templates
   - [ ] Add support for custom scoring algorithms

3. **Integration Testing**:
   - [ ] Test validation → planning handoff with various scenarios
   - [ ] Ensure session data flows correctly between commands
   - [ ] Validate pre-answering logic works as expected

4. **Documentation**:
   - [ ] Create validation methodology guide
   - [ ] Document scoring system customization
   - [ ] Provide workflow integration examples

## Assumptions Made

**From Codebase Analysis:**
- Existing command infrastructure supports new validation command pattern
- Session management system can handle validation-specific data structure
- Question template system can accommodate new validation templates
- File generation utilities support LVD format output

**From Requirements Discussion:**
- Teams want structured validation process before detailed planning
- Lean methodology is appropriate for both product and feature validation
- Configurable scoring provides better team adoption than fixed criteria
- Sequential questioning flow fits CLI environment better than visual canvas

**Areas for Future Clarification:**
- Specific validation questions that provide most value for feature decisions
- Optimal scoring weights for different types of organizations
- Integration patterns with existing product management tools
- Metrics collection for validation effectiveness measurement