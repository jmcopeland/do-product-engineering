# UI Components Question Template

## Core Questions

### Component Type & Purpose
1. What type of UI component do you need? (form, table, modal, navigation, etc.)
2. What is the primary purpose of this component?
3. Is this a new component or modification of an existing one?

### Visual Design
4. Do you have designs or mockups for this component?
5. Should it follow existing design patterns in the app?
6. What color scheme or theme should it use?
7. Does it need to support dark mode?

### Responsive Design
8. What devices/screen sizes need to be supported? (mobile, tablet, desktop)
9. How should the component adapt to different screen sizes?
10. Are there any mobile-specific interactions? (swipe, tap, pinch)

### Component State
11. What states does the component need to handle? (loading, error, empty, success)
12. How should each state be displayed to the user?
13. Does the component need to maintain internal state?
14. Should state persist across page refreshes?

### User Interactions
15. What user interactions are needed? (click, hover, drag, keyboard)
16. Should there be animations or transitions?
17. How should the component handle user errors?
18. Are there any keyboard shortcuts or accessibility requirements?

### Data & Props
19. What data does the component need to display?
20. What props/parameters should the component accept?
21. Should the component fetch its own data or receive it as props?
22. How should the component handle missing or invalid data?

### Forms (if applicable)
23. What fields does the form need?
24. What validation rules apply to each field?
25. Should validation happen on blur, submit, or real-time?
26. How should validation errors be displayed?
27. Does the form need to save drafts automatically?

### Tables/Lists (if applicable)
28. What columns/data should be displayed?
29. Does it need sorting capabilities?
30. Should users be able to reorder or resize columns?
31. Do you need row selection or bulk actions?
32. Should it support inline editing?

### Integration
33. How does this component fit into the existing page/layout?
34. Does it need to communicate with other components?
35. Should it emit events or use callbacks?
36. Are there any existing components it should be consistent with?

### Performance
37. Will this component render large amounts of data?
38. Does it need virtualization or lazy loading?
39. Should it be optimized for re-renders?

### Accessibility
40. What ARIA labels or roles are needed?
41. How should the component work with screen readers?
42. Is keyboard navigation required?

## Context Hints
- Check existing component library or design system
- Look for similar components in the codebase
- Find CSS framework or styling approach (Tailwind, CSS Modules, etc.)
- Check for component testing patterns
- Look for state management (Redux, Context, etc.)
- Find existing form libraries (React Hook Form, Formik)
- Check for animation libraries (Framer Motion, React Spring)
- Look for accessibility utilities or standards

## Complexity Indicators
- "dashboard", "analytics" → likely needs charts/graphs
- "wizard", "multi-step" → needs state management across steps
- "drag", "drop", "reorder" → needs drag-and-drop library
- "real-time", "live" → needs websocket updates
- "rich text", "editor" → needs specialized editor component
- "upload", "file" → needs file handling UI