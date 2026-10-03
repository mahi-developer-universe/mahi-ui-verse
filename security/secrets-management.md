# Secrets Management

## Never Commit

- API keys, passwords, access tokens, private keys, or session cookies
- .env files containing real credentials
- Personal data, private logs, or production database files
- Cloud credentials and signing certificates

## Safe Configuration

- Keep local secrets in ignored environment files.
- Commit only sanitized examples such as .env.example.
- Validate required environment variables at application startup.
- Use least-privilege credentials and rotate them periodically.
- Use GitHub Actions secrets for CI/CD credentials.
- Never print secrets in logs, error messages, or screenshots.

## If a Secret Is Exposed

1. Revoke or rotate the credential immediately.
2. Check relevant access logs for suspicious activity.
3. Remove the exposed value from the repository.
4. Assess whether Git history also requires remediation.
5. Notify affected service owners when appropriate.

Deleting a secret from the latest commit does not remove it from
earlier Git history.
