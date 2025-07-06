# Do: AI-Powered Questioning - PRD

**Created:** 2025-06-30  
**Complexity Estimate:** 3/5  
**Status:** ✅ Completed

## Context

Claude PM v1.0 successfully implemented a template-based questioning system that helps transform vague requirements into detailed PRDs. However, the current system relies on predefined question templates for different feature types (auth, CRUD, UI, API). This limits its ability to adapt to unique project contexts and ask truly relevant follow-up questions based on user responses.

By leveraging Claude's advanced language understanding capabilities, we can create a dynamic questioning system that:
- Adapts questions based on project context and user responses
- Asks more relevant and insightful follow-up questions
- Learns from the conversation flow to avoid redundant questions
- Provides a more natural, conversational experience

### Related Existing Features
- Current template-based questioning in `pm.md`
- Context discovery system that analyzes project structure
- Session management for continuing conversations
- Claude's native language understanding capabilities

## User Stories

**As a developer**, I want Claude PM to ask intelligent follow-up questions based on my answers, so that I don't have to answer irrelevant template questions.

**As a developer**, I want the questioning to feel like talking to a real PM who understands my project, so that I can have a natural conversation about requirements.

**As a developer**, I want Claude PM to recognize when it has enough information, so that I don't get asked unnecessary questions when requirements are already clear.

**As a developer**, I want Claude PM to probe deeper into complex or vague areas, so that edge cases and important details aren't missed.

**As a project lead**, I want consistent quality in PRDs regardless of how well initial requirements are stated, so that all features are well-documented.

## Core Requirements

### AI-Powered Question Generation
- **Conversational Flow**: Ask questions one at a time with context
  - Show question progress (e.g., "Question 2 of approximately 5")
  - Provide brief rationale for each question
  - Explain why information is needed for the PRD
- **Hybrid AI/Template System**:
  - Start with AI-generated questions based on context
  - Consult relevant templates for requirement type
  - Check codebase for answers before asking
  - Include unanswered template questions in AI flow
- Generate follow-up questions based on:
  - User's previous answers
  - Detected gaps in requirements
  - Project-specific patterns and conventions
  - Complexity indicators in responses

### Intelligent Context Analysis
- **Complexity Assessment**:
  - Analyze scope of code changes required
  - Estimate number of files/components affected
  - Identify integration complexity
  - Offer to break down complex requirements into smaller plans
- **Codebase Pattern Recognition**:
  - Find similar existing features
  - Reference relevant code patterns
  - Pre-answer questions from codebase analysis
  - Suggest consistency with existing patterns
- **Response Analysis**:
  - Detect uncertainty ("I don't know", "not sure", "maybe")
  - Identify dismissive responses ("doesn't matter", "not relevant")
  - Recognize completion signals ("good to go", "looks good", "continue")
  - Parse technical complexity from descriptions

### Conversational Flow Management
- **Question Presentation**:
  - One question at a time with clear rationale
  - Progress indicator (e.g., "3 of ~7 questions")
  - Context about why each question matters
  - Natural transitions between topics
- **User Control Signals**:
  - Completion: "good to go", "looks good", "sounds good", "continue", "proceed"
  - Dismissal: "doesn't matter", "not relevant", "not important", "skip"
  - Uncertainty: "I don't know", "not sure" → offer to explore or defer as TODO
  - Clarification: "why are you asking" → provide deeper explanation
- **Adaptive Behavior**:
  - Skip redundant questions based on previous answers
  - Adjust depth based on response detail level
  - Recognize when sufficient detail gathered
  - Handle topic transitions gracefully

### Adaptive Questioning Depth
- Start with high-level questions
- Drill down based on response complexity
- Skip obvious questions when context is clear
- Expand questioning for vague or complex areas
- Allow user to indicate desired depth

### Question Quality Control
- **AI-Driven Relevance** - No hard question limits in AI mode
- **Priority-based filtering** - Only ask high/medium priority questions
- Ensure questions are:
  - Relevant to the specific requirement
  - Clear and unambiguous
  - Actionable (lead to useful information)
  - Appropriately technical for the context
- Avoid questions already answered implicitly
- **Quality over quantity** - Ask all relevant questions, let user decide when to stop

## Acceptance Criteria

**AI Question Generation**
- [ ] Generates contextually relevant questions without templates
- [ ] Follow-up questions directly relate to previous answers
- [ ] Questions adapt to technical level of responses
- [ ] Avoids asking about already-provided information

**Conversation Quality**
- [ ] Questioning feels natural and conversational
- [ ] Smooth transitions between related topics
- [ ] Appropriate depth based on requirement complexity
- [ ] Recognizes and respects user's communication style

**Intelligence Features**
- [ ] Identifies gaps in requirements automatically
- [ ] Probes edge cases based on requirement type
- [ ] Suggests related considerations user might have missed
- [ ] Learns from conversation context to improve questions

**User Control**
- [ ] Users can indicate when they've provided enough detail
- [ ] Support for "brief mode" vs "thorough mode"
- [ ] Ability to skip or defer questions
- [ ] Clear progress indication

**Backwards Compatibility**
- [ ] Existing template system remains as fallback
- [ ] Configuration option to use templates vs AI
- [ ] Graceful degradation if AI questioning fails

## Implementation Notes

### Technical Approach
1. **Hybrid Question System**
   - Template questions stored in `.claude-pm/questions/` directory:
     - `auth.md` - Authentication & user management questions
     - `crud.md` - Create, Read, Update, Delete operations
     - `ui.md` - User interface components
     - `api.md` - API integration questions
     - `general.md` - General/fallback questions
   - AI analyzes requirement to select relevant templates
   - Analyze entire codebase to pre-answer template questions
   - Generate AI questions for gaps and follow-ups
   - Templates guide AI, not used as fallback

2. **Enhanced Context Analysis**
   - Extract semantic meaning from requirements
   - Identify requirement type and complexity
   - Find similar patterns in existing codebase
   - Build rich context object for AI questioning

3. **AI Question Generation**
   - Use Claude's reasoning to generate contextual questions
   - Provide: context + templates + previous Q&A + codebase patterns
   - Generate one question at a time with rationale
   - Include progress indicator and importance explanation

4. **Response Analysis**
   - Parse user responses for completeness and sentiment
   - Detect control signals (completion, dismissal, uncertainty)
   - Identify complexity indicators for breakdown offers
   - Update context and adjust question count dynamically

5. **Flow Control**
   - Implement conversation state machine
   - Store session state in `.claude-pm/sessions/` directory
   - Dynamically adjust progress estimation during conversation
   - Track template coverage + AI-generated coverage
   - Handle "I don't know" with exploration/deferral options
   - Support interruption, resumption, and early completion
   - Allow "skip questioning" → AI makes assumptions from codebase

### Configuration Updates
```json
{
  "questioningMode": "ai-powered", // "template" | "ai-powered" | "hybrid"
  "aiQuestioningOptions": {
    "maxRounds": 5,
    "questionsPerRound": 1,
    "adaptiveDepth": true,
    "includeRationale": true,
    "allowSkipQuestioning": true
  }
}
```

### Migration Strategy
1. Add AI questioning as opt-in feature
2. Run both systems in parallel for testing
3. Gradually make AI default with template fallback
4. Maintain template system for specific use cases

## Example Scenarios

### Scenario 1: Simple Requirement
**User Input**: "Add user authentication"

**AI Behavior**:
1. Check codebase for existing auth patterns
2. Find template questions for authentication
3. Pre-answer questions from codebase analysis

**Question Flow**:
```
AI: I see you want to add user authentication. I've analyzed your codebase and found 
    you're using Express with sessions. 

    Question 1 of ~4: What authentication methods should users have?
    (I'm asking because this determines the complexity of the implementation and 
    what dependencies we'll need)

User: Email/password and Google OAuth

AI: Great choice. I notice you already have Passport.js installed.

    Question 2 of ~4: Do you need role-based access control, or is simple 
    authentication sufficient?
    (This helps determine if we need a permissions system)

User: Just simple auth for now

AI: Question 3 of ~4: Should users stay logged in between sessions?
    (This affects whether we implement "remember me" functionality)

User: I don't know

AI: No problem! Would you like to:
    1. Explore this now (I can explain the implications)
    2. Defer as a TODO for later
    3. Use a sensible default (7-day sessions)

User: Use the default

AI: Perfect. Last question: Where should users go after successful login?
    (This helps me document the user flow)

User: Good to go

AI: Excellent! I have enough information to create a comprehensive PRD.
```

### Scenario 2: Complex Requirement
**User Input**: "Build a real-time collaborative document editor"

**AI Behavior**:
1. Detect high complexity from "real-time" and "collaborative"
2. Offer to break down into smaller plans

**Initial Response**:
```
AI: This is a complex feature that could involve:
    - Real-time synchronization (WebSockets/SSE)
    - Conflict resolution algorithms
    - Document persistence and versioning
    - User presence indicators
    - Permission management

    Would you like to:
    1. Create separate PRDs for each component
    2. Focus on a basic version first
    3. Continue with the full implementation

User: Let's focus on basic version

AI: Smart approach! Let's define a basic collaborative editor.
    
    Question 1 of ~5: What type of documents will users edit?
    (This determines the editor complexity - plain text, rich text, or markdown)
```

### Scenario 3: Dismissing Irrelevant Questions
```
AI: Question 3 of ~6: Should we track document revision history?
    (This helps with conflict resolution and undo functionality)

User: Not relevant for MVP

AI: Understood, skipping revision history. 
    
    Question 4 of ~5: How should we handle when two users edit the same section?
    (This is crucial for the collaborative experience)
```

## Success Metrics

**Immediate**
- 50% reduction in average questions asked
- 90% of questions rated as relevant by users
- 80% of PRDs require no additional clarification
- Natural conversation flow in 95% of sessions

**Long-term**
- Higher quality PRDs with better edge case coverage
- Reduced time from requirement to implementation
- Increased developer satisfaction scores
- Fewer feature revisions due to missed requirements

## TODOs

- Research optimal prompt engineering for question generation
- Design conversation state management system
- Create evaluation framework for question quality
- Plan A/B testing strategy (template vs AI)
- Consider caching strategies for similar requirements
- Design fallback behavior for edge cases

## Resolved Design Decisions

1. **✓ Include rationale for each question** - Provides context and allows informed responses
2. **✓ Use hybrid AI/template approach** - Templates guide AI, not used as fallback
3. **✓ Reference existing codebase patterns** - Search entire codebase for context
4. **✓ One question at a time** - More conversational with dynamic progress indicators
5. **✓ Support complexity breakdown** - Offer to split complex requirements into smaller PRDs
6. **✓ Handle uncertainty gracefully** - Offer exploration, deferral, or sensible defaults
7. **✓ Allow dismissal of irrelevant questions** - Respect user's domain knowledge
8. **✓ Template storage** - `.claude-pm/questions/` directory with type-specific .md files
9. **✓ Session management** - Store state in `.claude-pm/sessions/` directory
10. **✓ Skip option** - Allow users to skip questioning, AI makes assumptions from codebase
11. **✓ No PRD question tracking** - Keep PRDs clean, don't include question transcript
12. **✓ Dynamic progress** - Adjust question count estimate during conversation

## Remaining Open Questions

1. Should the system remember user preferences across sessions? (e.g., always skip certain types of questions)
2. How to handle technical jargon that Claude might not understand?
3. Should there be a "expert mode" that asks fewer basic questions?
4. How to balance between following templates strictly vs allowing AI creativity?

## Implementation Plan

A detailed implementation plan has been created: `claude-pm-v2-implementation-plan-20250630-144500.md`

The plan breaks down the work into 5 phases over approximately 10 days:
- Phase 1: Foundation Setup (Templates & Config)
- Phase 2: Core AI Integration 
- Phase 3: Conversation Management
- Phase 4: Integration & Polish
- Phase 5: Documentation & Release

---

*This PRD focuses on making Claude PM's questioning system truly intelligent and adaptive, moving from templates to AI-powered dynamic questioning.*