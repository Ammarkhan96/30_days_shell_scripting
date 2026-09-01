# AI Auto-Remediation System

An AI-assisted Linux remediation system built with Bash.

## Objective

The system detects high disk usage, collects system context,
requests an AI remediation decision, executes only approved
remediation actions, and verifies the result.

## Architecture

Monitor
    |
    v
Disk Threshold Detection
    |
    v
Context Collection
    |
    v
AI Decision
    |
    v
Approved Remediation
    |
    v
Verification
    |
    v
Incident Report

## Features

- Linux disk monitoring
- Bash automation
- System context collection
- AI-assisted decision making
- Allowlisted remediation actions
- Docker cleanup
- Post-remediation verification
- Incident report generation
- Security against arbitrary AI commands

## Technologies

- Linux
- Bash
- Docker
- jq
- REST API
- AI
- Git

## Security Model

The AI does not execute arbitrary shell commands.

AI returns an action such as:

docker_cleanup

The Bash remediation layer validates the action against
an allowlist before execution.

## Run

```bash
chmod +x run.sh
./run.sh
