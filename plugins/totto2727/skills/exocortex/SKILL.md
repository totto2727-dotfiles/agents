---
name: exocortex
description: Use when storing development insights, recalling past decisions, building knowledge graphs, or managing AI agent memory with Exocortex MCP server.
---

# Exocortex MCP Server

A "second brain" for AI agents — persist insights, recall past decisions, and build knowledge graphs across sessions.

## Core Tools

| Tool | Purpose |
|---|---|
| `exo_store_memory` | Persist insights with tags, context, and optional "painful memory" flag |
| `exo_recall_memories` | Search knowledge base with natural language queries and filters |
| `exo_link_memories` | Connect memories via relations (`related`, `extends`, `depends_on`, `supersedes`, `contradicts`, `evolved_from`, `rejected_because`, `caused_by`) |
| `exo_explore_related` | Discover adjacent knowledge through links, tags, and context |
| `exo_trace_lineage` | Trace decision evolution backward/forward through relations |
| `exo_curiosity_scan` | Detect contradictions, orphans, and outdated information |
| `exo_sleep` | Background maintenance: deduplication, orphan rescue, pattern mining |
| `exo_consolidate` | Extract common themes from similar memories |
| `exo_analyze_knowledge` | Diagnose health issues (orphans, stale content) |
| `exo_get_stats` | Knowledge base overview with counts and trending tags |

## Basic Workflow

1. **Session Start**: `exo_recall_memories` — retrieve relevant context
2. **During Work**: `exo_store_memory` — persist discoveries with structured Problem/Solution/Rationale sections and specific tags
3. **Session End**: `exo_sleep` — consolidate and maintain the knowledge base

## Reference

- [Usage Guide](https://github.com/fuwasegu/exocortex/blob/main/manuals/usage-guide.md)
