# Dependency Security

- Prefer maintained packages from trusted sources.
- Review dependency changes before merging.
- Check for known vulnerabilities in direct and transitive dependencies.
- Use lockfiles and reproducible dependency installation.
- Remove unused packages and investigate unexpected dependency changes.
- Review automated update pull requests before merging.
- Do not assume that a successful build means dependencies are secure.

For JavaScript projects, use the package manager appropriate to the
project and review its audit output before applying fixes.
