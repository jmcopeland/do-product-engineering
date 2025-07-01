# CRUD Operations Question Template

## Core Questions

### Data Model
1. What type of data/entity are you working with? (users, products, posts, etc.)
2. What fields/properties does this entity have?
3. Are there any required vs optional fields?
4. Do any fields need validation? (email format, phone numbers, etc.)

### Create Operation
5. Who can create new records? (anyone, authenticated users, specific roles)
6. Do you need bulk creation capabilities?
7. Should creation trigger any notifications or side effects?
8. Are there any uniqueness constraints? (unique email, username, etc.)

### Read Operation
9. Who can view these records? (public, owner only, role-based)
10. Do you need list/search functionality?
11. What filters or search parameters are needed?
12. Do you need pagination for large datasets?
13. Should there be different view permissions for different fields?

### Update Operation
14. Who can update records? (owner, admin, specific roles)
15. Can all fields be updated or are some immutable?
16. Do you need update history or audit trails?
17. Should updates trigger any notifications?
18. Do you need optimistic locking to prevent concurrent updates?

### Delete Operation
19. Who can delete records?
20. Should deletes be soft (marked as deleted) or hard (permanently removed)?
21. What happens to related data when a record is deleted?
22. Do you need to archive data before deletion?
23. Can deleted records be restored?

### Relationships
24. Does this entity relate to other entities? How? (one-to-many, many-to-many)
25. Should related data be included when fetching? (eager vs lazy loading)
26. What happens to relationships when records are deleted?

### Performance & Scale
27. How many records do you expect? (hundreds, thousands, millions)
28. How often will records be created/updated/deleted?
29. Do you need caching for read operations?
30. Are there any real-time update requirements?

### API Design
31. What format should the API use? (REST, GraphQL, RPC)
32. What data format for requests/responses? (JSON, XML)
33. Do you need versioning for the API?
34. Should there be rate limiting?

## Context Hints
- Look for existing models or schemas
- Check database migrations or DDL
- Find existing CRUD endpoints or services
- Look for validation rules or middleware
- Check for existing pagination utilities
- Find authorization/permission checks
- Look for caching layers (Redis, Memcached)
- Check for existing API patterns in the codebase

## Complexity Indicators
- "audit", "history" → needs versioning/audit trails
- "bulk", "import", "export" → needs batch operations
- "real-time", "live" → needs websockets or polling
- "search", "filter" → needs advanced query capabilities
- "file", "image", "document" → needs file handling