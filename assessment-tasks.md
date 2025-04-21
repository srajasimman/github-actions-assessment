## Assessment Tasks

### 1. Workflow Challenge

Create a GitHub Actions workflow that:

- Runs on pull requests and pushes to main
- Performs linting and unit tests
- Builds and packages an application
- Performs a mock deployment to staging/production based on branch
- Notifies a Slack channel (mock) on completion

### 2. JavaScript Action Challenge

Create a custom JavaScript action that:

- Scans a repository for specific patterns (e.g., secrets, outdated dependencies)
- Generates a report of findings
- Posts a summary as a PR comment
- Fails the workflow if critical issues are found
