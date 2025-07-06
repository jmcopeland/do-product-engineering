# Authentication Question Template

## Core Questions

### Authentication Methods
1. What authentication methods should be supported? (email/password, OAuth providers, SSO, magic links, etc.)
2. Which OAuth providers do you need? (Google, GitHub, Facebook, Twitter, etc.)
3. Do you need multi-factor authentication (2FA)?

### User Management
4. Do you need role-based access control (RBAC) or is simple authentication sufficient?
5. What user roles do you need? (admin, user, moderator, etc.)
6. Should users be able to have multiple roles?

### Session Management
7. Should users stay logged in between sessions? (remember me functionality)
8. How long should sessions last before requiring re-authentication?
9. Should there be different session lengths for different auth methods?

### User Data
10. What user profile data needs to be stored? (name, email, avatar, preferences, etc.)
11. Should users be able to edit their profile?
12. Do you need email verification for new accounts?

### Security
13. How should password reset work? (email link, security questions, admin reset)
14. Should there be account lockout after failed login attempts?
15. Do you need to track login history or suspicious activity?
16. Are there any compliance requirements? (GDPR, HIPAA, etc.)

### Account Lifecycle
17. Can users sign up themselves or are accounts created by admins?
18. Can users delete their own accounts?
19. What happens to user data when an account is deleted?
20. Do you need to support account suspension or deactivation?

### Integration
21. Where should users go after successful login?
22. Where should users go after logout?
23. Should there be different post-login destinations based on role?
24. Do you need single sign-on (SSO) across multiple applications?

## Context Hints
- Check for existing auth libraries (Passport.js, Auth0, Firebase Auth, NextAuth)
- Look for user models or database schemas
- Find existing session management (express-session, JWT)
- Check security requirements in documentation
- Look for existing middleware or auth guards
- Search for environment variables related to auth
- Check for existing OAuth app configurations

## Complexity Indicators
- "enterprise" → likely needs SSO, RBAC, audit trails
- "social" → likely needs OAuth providers
- "banking", "healthcare" → compliance requirements
- "team", "organization" → likely needs roles and permissions
- "API" → might need token-based auth instead of sessions