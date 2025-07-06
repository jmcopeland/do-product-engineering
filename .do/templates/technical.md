# RFC: [Feature Name]

**RFC Number**: [YYYY-XXX]  
**Status**: [Draft/Under Review/Approved/Implemented]  
**Last Updated**: [Date]  
**Author(s)**: [Names]  
**Reviewer(s)**: [Names]

## Summary

[One paragraph executive summary of the proposal]

## Motivation

### Problem Statement
[Detailed description of the problem this RFC addresses]

### Why Now?
[Urgency and timing considerations]

### Goals
- [Primary goal]
- [Secondary goal]
- [Success criteria]

### Non-Goals
- [What this RFC explicitly does not address]
- [Scope boundaries]

## Detailed Design

### Architecture Overview

```
[ASCII or mermaid diagram showing system architecture]
```

### Component Design

#### Component A
- **Purpose**: [What it does]
- **Interface**: [API surface]
- **Implementation**: [Key details]

#### Component B
- **Purpose**: [What it does]
- **Interface**: [API surface]
- **Implementation**: [Key details]

### API Design

#### Endpoint: [Method] /api/v1/[resource]

**Request**:
```json
{
  "field1": "value",
  "field2": 123
}
```

**Response** (200 OK):
```json
{
  "id": "uuid",
  "field1": "value",
  "field2": 123,
  "created_at": "2024-01-01T00:00:00Z"
}
```

**Error Response** (4XX/5XX):
```json
{
  "error": {
    "code": "ERROR_CODE",
    "message": "Human readable message",
    "details": {}
  }
}
```

### Data Model

#### Schema Changes

```sql
-- New tables
CREATE TABLE new_feature (
  id UUID PRIMARY KEY,
  field1 VARCHAR(255) NOT NULL,
  field2 INTEGER DEFAULT 0,
  created_at TIMESTAMP DEFAULT NOW()
);

-- Modifications to existing tables
ALTER TABLE existing_table 
ADD COLUMN new_field TYPE;
```

#### Data Migration Strategy
1. [Step 1: Backward compatible change]
2. [Step 2: Data migration script]
3. [Step 3: Cleanup old data]

### Error Handling

| Error Case | Handling Strategy | User Impact |
|------------|------------------|-------------|
| [Case 1] | [How handled] | [What user sees] |
| [Case 2] | [How handled] | [What user sees] |

## Alternatives Considered

### Alternative 1: [Name]
- **Description**: [What it would do differently]
- **Pros**: [Advantages]
- **Cons**: [Disadvantages]
- **Why not chosen**: [Decision rationale]

### Alternative 2: [Name]
- **Description**: [What it would do differently]
- **Pros**: [Advantages]
- **Cons**: [Disadvantages]
- **Why not chosen**: [Decision rationale]

## Security Considerations

### Authentication & Authorization
- [How users are authenticated]
- [Permission model]
- [Access control implementation]

### Data Privacy
- [PII handling]
- [Encryption at rest/in transit]
- [Data retention policies]

### Threat Model
- **Threat 1**: [Description] → **Mitigation**: [Strategy]
- **Threat 2**: [Description] → **Mitigation**: [Strategy]

## Performance Impact

### Expected Load
- **Requests/second**: [Estimate]
- **Data volume**: [Estimate]
- **Growth projection**: [12-month outlook]

### Performance Targets
- **Latency p50**: < [X]ms
- **Latency p99**: < [X]ms
- **Throughput**: [X] requests/second

### Optimization Strategy
- [Caching approach]
- [Database optimization]
- [Async processing where applicable]

### Monitoring Plan
- **Metrics**: [What we'll track]
- **Alerts**: [Threshold and escalation]
- **Dashboards**: [Visibility plan]

## Migration Strategy

### Rollout Plan
1. **Phase 1**: [Internal testing - Date]
2. **Phase 2**: [Beta users - Date]
3. **Phase 3**: [Gradual rollout - Date]
4. **Phase 4**: [General availability - Date]

### Feature Flags
```json
{
  "new_feature_enabled": {
    "default": false,
    "rules": [
      {"user_group": "beta", "value": true},
      {"percentage": 10, "value": true}
    ]
  }
}
```

### Rollback Plan
1. [How to detect issues]
2. [Decision criteria for rollback]
3. [Rollback procedure]
4. [Data recovery if needed]

## Dependencies

### Internal Dependencies
- [Service A]: [What we need from it]
- [Service B]: [Integration requirements]

### External Dependencies
- [Third-party service]: [API version, SLA]
- [Library]: [Version, license]

## Testing Strategy

### Unit Tests
- [Coverage targets]
- [Key test scenarios]

### Integration Tests
- [Service integration scenarios]
- [End-to-end flows]

### Performance Tests
- [Load testing plan]
- [Stress testing scenarios]

### Chaos Engineering
- [Failure scenarios to test]
- [Recovery validation]

## Documentation Plan

- [ ] API documentation
- [ ] Architecture documentation
- [ ] Runbook for operations
- [ ] Migration guide
- [ ] Developer guide

## Timeline

| Milestone | Date | Description |
|-----------|------|-------------|
| Design Review | [Date] | RFC approval |
| Implementation Start | [Date] | Development begins |
| Code Complete | [Date] | Feature ready for testing |
| Launch | [Date] | General availability |

## Open Questions

1. **[Technical question]**
   - Context: [Why this matters]
   - Options: [Possible answers]
   - Impact: [How this affects design]

2. **[Business question]**
   - Context: [Why this matters]
   - Stakeholder: [Who can answer]

## Appendix

### References
- [Link to related RFCs]
- [Link to design docs]
- [Link to research]

### Glossary
- **Term 1**: [Definition]
- **Term 2**: [Definition]