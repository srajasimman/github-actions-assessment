# GitHub Actions Assessment

This repository contains assessment tasks for GitHub Actions and JavaScript actions development.

## Environment Setup

This environment is pre-configured with:

- VS Code Server (browser-based IDE)
- nektos/act for running GitHub Actions locally
- Docker for container operations
- All necessary dependencies

## Assessment Tasks

### 1. Workflow Challenge

Create a GitHub Actions workflow that:

### 2. JavaScript Action Challenge

Create a custom JavaScript action that:

## Testing Your Solutions

You can test your workflows using the following commands:

```bash
# Test a workflow
act -j job_name

# Test with specific event
act pull_request

# Test with environment variables
act -j job_name -e vars.env
```

## Submission

When you're finished, please create a zip file of your solution.
