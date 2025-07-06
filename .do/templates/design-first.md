# Design PRD: [Feature Name]

**Status**: [Concept/In Design/Ready for Development]  
**Designer**: [Name]  
**Last Updated**: [Date]  
**Figma/Sketch Link**: [URL]

## Vision

### Hero Image
[Primary mockup or screenshot showing the feature in its ideal state]

### Design Inspiration
[Mood board, references, or competitive examples]

### Design Goals
1. [Primary design objective]
2. [Secondary design objective]
3. [Tertiary design objective]

## User Journey

### Entry Points
1. **Primary**: [How most users will discover/access]
2. **Secondary**: [Alternative entry]
3. **Deep link**: [Direct access if applicable]

### Core Flow
```
1. [Starting State]
   ↓
2. [User Action] → [System Response]
   ↓
3. [Next Step]
   ↓
4. [Success State]
```

### Exit Points
- **Success**: [Where users go after completing task]
- **Abandon**: [Graceful exit options]

## Design Principles

### Principle 1: [Name]
- **Definition**: [What this means]
- **Application**: [How we apply it here]
- **Example**: [Specific implementation]

### Principle 2: [Name]
- **Definition**: [What this means]
- **Application**: [How we apply it here]
- **Example**: [Specific implementation]

## Component Specifications

### [Component Name]

#### Visual Design
- **Desktop**: [Mockup/screenshot]
- **Mobile**: [Mockup/screenshot]
- **Tablet**: [Mockup/screenshot if different]

#### States
- **Default**: [Appearance and behavior]
- **Hover**: [Changes on hover]
- **Active**: [During interaction]
- **Focus**: [Keyboard navigation]
- **Disabled**: [When not available]
- **Loading**: [During async operations]
- **Error**: [Error state appearance]
- **Empty**: [No data state]

#### Interaction Patterns
- **Click/Tap**: [What happens]
- **Keyboard**: [Shortcuts and navigation]
- **Gestures**: [Touch gestures if applicable]
- **Animations**: [Transitions and timing]

#### Content Guidelines
- **Text limits**: [Character/word limits]
- **Tone**: [Voice and tone guidelines]
- **Microcopy**: [Button labels, hints, errors]

### [Another Component]
[Repeat structure above]

## Information Architecture

### Navigation Placement
- **Global nav**: [If added to main navigation]
- **Contextual nav**: [Local navigation changes]
- **Breadcrumbs**: [Wayfinding updates]

### Content Hierarchy
1. **Primary**: [Most important element]
2. **Secondary**: [Supporting information]
3. **Tertiary**: [Additional details]

### Layout Grid
- **Desktop**: [12-column, 16-column, etc.]
- **Tablet**: [Grid adjustment]
- **Mobile**: [Single column, cards, etc.]

## Responsive Behavior

### Breakpoints
- **Mobile**: 320px - 767px
- **Tablet**: 768px - 1023px
- **Desktop**: 1024px+
- **Wide**: 1440px+

### Adaptive Strategies
- **Reflow**: [How layout adjusts]
- **Progressive disclosure**: [What hides/shows]
- **Touch targets**: [Size adjustments for touch]

## Accessibility Requirements

### WCAG Compliance
- **Level**: [A/AA/AAA]
- **Key considerations**: [Specific areas of focus]

### Keyboard Navigation
```
Tab Order:
1. [First element]
2. [Second element]
3. [Third element]
...
```

### Screen Reader Support
- **Landmarks**: [ARIA landmarks used]
- **Labels**: [ARIA labels for clarity]
- **Announcements**: [Dynamic content updates]

### Visual Accessibility
- **Color contrast**: [Ratios for text/backgrounds]
- **Focus indicators**: [Visible focus states]
- **Motion**: [Respecting prefers-reduced-motion]

## Brand Alignment

### Color Usage
- **Primary**: [How brand colors are used]
- **Secondary**: [Supporting colors]
- **Semantic**: [Success, warning, error colors]

### Typography
- **Headings**: [Font, size, weight]
- **Body**: [Font, size, line-height]
- **UI text**: [Buttons, labels, etc.]

### Iconography
- **Style**: [Outlined, filled, etc.]
- **Size**: [Standard sizes used]
- **Custom icons**: [Any new icons needed]

### Voice & Tone
- **Personality**: [Brand voice characteristics]
- **Do's**: [Writing guidelines]
- **Don'ts**: [What to avoid]

## Motion & Animation

### Transitions
- **Duration**: [Timing standards]
- **Easing**: [Curves used]
- **Properties**: [What animates]

### Micro-interactions
- **Hover effects**: [Subtle feedback]
- **Loading states**: [Progress indication]
- **Success feedback**: [Completion animation]

## Dark Mode Considerations

### Color Adaptations
- **Backgrounds**: [Dark mode values]
- **Text**: [Contrast adjustments]
- **Semantic colors**: [Dark mode variants]

### Special Considerations
- [Images that need treatment]
- [Icons that need variants]
- [Shadows and elevation]

## Success Metrics

### Usability Metrics
- **Task completion rate**: [Target %]
- **Time to complete**: [Target duration]
- **Error rate**: [Acceptable threshold]

### Engagement Metrics
- **Adoption**: [% of users who try it]
- **Retention**: [% who continue using]
- **Frequency**: [How often used]

### Aesthetic Metrics
- **Design satisfaction**: [Survey score target]
- **Perceived ease**: [Usability score]
- **Brand alignment**: [Brand perception score]

## Handoff Notes

### For Engineers
- [Technical constraints to consider]
- [Performance considerations]
- [Integration points]

### Design Tokens
```json
{
  "colors": {
    "feature-primary": "#value",
    "feature-secondary": "#value"
  },
  "spacing": {
    "feature-gap": "16px"
  }
}
```

### Assets Needed
- [ ] Icon set: [List of new icons]
- [ ] Images: [Photography or illustrations]
- [ ] Lottie files: [Complex animations]

## Future Enhancements

### Phase 2 Considerations
- [Feature to add later]
- [Enhancement opportunity]
- [User request to consider]

### Design Debt
- [Compromise made for speed]
- [Pattern to revisit]
- [Consistency issue to address]