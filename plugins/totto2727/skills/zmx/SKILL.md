---
name: zmx
description: Session persistence for terminal processes using zmx. Use when creating, attaching, detaching, listing, or killing terminal sessions, when retrieving session scrollback history, or when running background processes and long-running services such as development servers.
---

# zmx - Session Persistence for Terminal Processes

## Session

- Create and attach: `zmx attach <name> [command...]`
- Create without attach: `zmx run <name> [command...]`
- List: `zmx list [--short]`
- Kill: `zmx kill <name>`
- Detach: `zmx detach` (detaches all clients from current session)

## History

- Plain text: `zmx history <name>`
- With VT escapes: `zmx history <name> --vt`
- HTML format: `zmx history <name> --html`
