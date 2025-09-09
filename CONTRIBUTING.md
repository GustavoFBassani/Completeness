# Contributing to the Project

## General Requirements
- Always create a **branch** from `main` or from the feature branch you are fixing, if it is still open.
- Name your branch following the convention below.
- Write clear and objective commits.
- If possible, keep PRs small and focused.

## Branch Naming

Use the structure:

```
Type/OptionalIdentifier/ClearDescription
```

Accepted types:
- **feature/usName/tk#** – New feature  
    _Example:_ `feature/userRegistration/tk102`

- **refactor/...** – Refactoring without changing functionality  
    _Example:_ `refactor/organizeServices`

- **fix/...** – Bug fix  
    _Example:_ `fix/invalidLogin`

- **chore/...** – Maintenance tasks (CI/CD, dependencies, etc.)  
    _Example:_ `chore/updateDependencies`

- **docs/...** – Documentation changes  
    _Example:_ `docs/installationGuide`

- **style/...** – Formatting, style, lint changes, etc.  
    _Example:_ `style/reformatFiles`

## Commits

Follow this model for commit messages:

```
<type>: brief and clear description
```

Examples:

- `fix: fixed authentication bug`
- `feature: added login screen`
- `docs: updated README with installation instructions`

## Pull Requests

- Submit PRs to the `main` branch.
- Clearly describe what was done.
- Link related issues if any.
- Wait for review and approval before merging.
- When merged, the task can be marked/considered "done"
