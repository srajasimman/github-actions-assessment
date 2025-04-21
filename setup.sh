#!/bin/bash

# Create directories
mkdir -p template-repo/.github/workflows
mkdir -p template-repo/.github/actions

# Create README with instructions
cat >template-repo/README.md <<'EOF'
# GitHub Actions Assessment

This repository contains assessment tasks for GitHub Actions and JavaScript actions development.

## Environment Setup

This environment is pre-configured with:
- VS Code Server (browser-based IDE)
- nektos/act for running GitHub Actions locally
- Docker for container operations
- All necessary dependencies

EOF
cat assessment-tasks.md >>template-repo/README.md

cat >>template-repo/README.md <<'EOF'
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

EOF

echo "Do you want to create a sample app for the assessment? (y/n)"
read -r REPLY
if [ "$REPLY" == "n" ]; then
  echo "Skipping sample app creation."
  exit 0
elif [ "$REPLY" == "y" ]; then
  echo "Creating sample app..."
else
  echo "Invalid input. Exiting."
  exit 1
fi

# Create sample app files
cat >template-repo/package.json <<'EOF'
{
  "name": "github-actions-assessment",
  "version": "1.0.0",
  "description": "Assessment for GitHub Actions skills",
  "main": "index.js",
  "scripts": {
    "lint": "eslint .",
    "test": "jest",
    "build": "echo 'Building project...'"
  },
  "dependencies": {
    "express": "^4.18.2"
  },
  "devDependencies": {
    "eslint": "^8.44.0",
    "jest": "^29.6.0"
  }
}
EOF

cat >template-repo/index.js <<'EOF'
const express = require('express');
const app = express();
const port = process.env.PORT || 3000;

app.get('/', (req, res) => {
  res.send('Hello GitHub Actions!');
});

app.listen(port, () => {
  console.log(`App listening at http://localhost:${port}`);
});

module.exports = app;
EOF

cat >template-repo/test.js <<'EOF'
const app = require('./index');

test('App should be defined', () => {
  expect(app).toBeDefined();
});
EOF

# Create a sample workflow file
cat >template-repo/.github/workflows/sample-workflow.yml <<'EOF'
name: Sample Workflow

on:
  push:
    branches: [ main ]
  pull_request:
    branches: [ main ]

jobs:
  test:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v3
      - name: Setup Node.js
        uses: actions/setup-node@v3
        with:
          node-version: '16'
      - name: Install dependencies
        run: npm ci
      - name: Run tests
        run: npm test
EOF

# Create a sample JavaScript action template
mkdir -p template-repo/.github/actions/sample-action
cat >template-repo/.github/actions/sample-action/action.yml <<'EOF'
name: 'Sample Action'
description: 'A template for a JavaScript action'
inputs:
  input-name:
    description: 'Sample input'
    required: true
    default: 'World'
outputs:
  output-name:
    description: 'Sample output'
runs:
  using: 'node16'
  main: 'index.js'
EOF

cat >template-repo/.github/actions/sample-action/index.js <<'EOF'
const core = require('@actions/core');
const github = require('@actions/github');

try {
  // Get inputs
  const inputName = core.getInput('input-name');
  
  // Do something with inputs
  const output = `Hello ${inputName}`;
  
  // Set outputs
  core.setOutput('output-name', output);
  
  // Log success
  core.info(`Action completed successfully: ${output}`);
} catch (error) {
  core.setFailed(error.message);
}
EOF

cat >template-repo/.github/actions/sample-action/package.json <<'EOF'
{
  "name": "sample-action",
  "version": "1.0.0",
  "description": "Sample GitHub Action",
  "main": "index.js",
  "dependencies": {
    "@actions/core": "^1.10.0",
    "@actions/github": "^5.1.1"
  }
}
EOF

echo "Template repository setup complete!"
