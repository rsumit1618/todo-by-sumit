# Project Rules

AI agents must read root `AGENTS.md` before using these rules.

This project follows Clean Architecture with three main layers:

- `domain`: business entities, repository contracts, use cases, errors.
- `data`: repository implementations, data sources, DTOs/models, network, Firebase, SQLite, dependency providers.
- `lib`: Flutter presentation, pages, view models, navigation, app-level DI wiring.

Rules in this folder are intended to preserve the current architecture while adding features.

Read these before making changes:

0. `../AGENTS.md`
1. `clean_architecture.rules.md`
2. `domain.rules.md`
3. `data.rules.md`
4. `repository.rules.md`
5. `presentation_mvvm.rules.md`
6. `dependency_injection.rules.md`
7. `routing_flavor_firebase.rules.md`
8. `ai_agent.rules.md`
9. `current_findings.rules.md`
10. `../docs/ARCHITECTURE.md`
11. `../docs/AI_REVIEW_CHECKLIST.md`
