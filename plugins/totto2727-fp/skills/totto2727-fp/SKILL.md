---
name: totto2727-fp
description: >-
  Guide for working with the @totto2727/fp package — a TypeScript functional
  programming utility library that re-exports and bridges Effect, option-t,
  and other FP libraries. Use when modifying, extending, or consuming
  @totto2727/fp modules.
---

# @totto2727/fp

Unified TypeScript functional programming utility library. Re-exports multiple FP libraries under a single namespace and provides custom bridge modules between Effect and option-t ecosystems.

## Module Map

### Core Re-exports

| Export Path  | Source Library    | Description                                     |
| ------------ | ----------------- | ----------------------------------------------- |
| `./effect`   | effect            | Full Effect library re-export                   |
| `./type`     | type-fest         | TypeScript utility types                        |
| `./option-t` | option-t          | Nullable, Maybe, Undefinable, Result namespaces |
| `./temporal` | temporal-polyfill | Temporal API polyfill                           |
| `./memo`     | micro-memoize     | Memoization                                     |
| `./case`     | change-case       | String case conversion                          |
| `./di`       | velona            | Dependency injection                            |

### Custom Modules

| Export Path           | Description                                                                                                             |
| --------------------- | ----------------------------------------------------------------------------------------------------------------------- |
| `./duration`          | Locale-aware duration formatting with caching                                                                           |
| `./effect/cuid`       | CUID generator with Effect Schema validation and branded types                                                          |
| `./effect/util`       | Effect utility types and helpers (`EffectFnSuccess`, `EffectFnError`, `EffectFnServices`, `nonEmptyArrayOrNone`, `tap`) |
| `./effect/option-t`   | Bridge: option-t `Result` → Effect `Exit`                                                                               |
| `./option-t/effect`   | Bridge: Effect `Exit` → option-t `Result` (dual function)                                                               |
| `./option-t/safe-try` | Rust-like `?` operator for option-t Result using generators                                                             |

### TypeScript Config Exports

| Export Path       | Description           |
| ----------------- | --------------------- |
| `./tsconfig/vite` | Vite project tsconfig |

## Key Patterns

- **Re-export strategy**: Most modules are thin re-exports (`export * from "library"`). Custom logic exists only in bridge modules, CUID, duration, and test helpers.
- **Effect/option-t bridge**: Bidirectional conversion between Effect `Exit` and option-t `Result` via `./effect/option-t` and `./option-t/effect`.
- **Branded types**: CUID uses Effect Schema branding for type-safe ID handling.

## Dependencies Reference

### Effect Ecosystem

- **effect** — Core Effect library for typed functional programming
  - [llms.txt](https://effect.website/llms.txt)
  - [llms-full.txt](https://effect.website/llms-full.txt)
  - [llms-small.txt](https://effect.website/llms-small.txt)

### Utility Libraries

| Package                                                                | Description                            | GitHub                                                      |
| ---------------------------------------------------------------------- | -------------------------------------- | ----------------------------------------------------------- |
| [option-t](https://github.com/option-t/option-t)                       | Option/Result types inspired by Rust   | [GitHub](https://github.com/option-t/option-t)              |
| [type-fest](https://github.com/sindresorhus/type-fest)                 | TypeScript utility types collection    | [GitHub](https://github.com/sindresorhus/type-fest)         |
| [micro-memoize](https://github.com/planttheidea/micro-memoize)         | High-performance memoization           | [GitHub](https://github.com/planttheidea/micro-memoize)     |
| [change-case](https://github.com/blakeembrey/change-case)              | String case conversion utilities       | [GitHub](https://github.com/blakeembrey/change-case)        |
| [velona](https://github.com/frouriojs/velona)                          | Dependency injection for TypeScript    | [GitHub](https://github.com/frouriojs/velona)               |
| [temporal-polyfill](https://github.com/fullcalendar/temporal-polyfill) | TC39 Temporal API polyfill             | [GitHub](https://github.com/fullcalendar/temporal-polyfill) |
| [@formatjs/intl-durationformat](https://github.com/formatjs/formatjs)  | Intl.DurationFormat polyfill           | [GitHub](https://github.com/formatjs/formatjs)              |
| [@noble/hashes](https://github.com/paulmillr/noble-hashes)             | Audited cryptographic hash functions   | [GitHub](https://github.com/paulmillr/noble-hashes)         |
| [base-x](https://github.com/cryptocoinjs/base-x)                       | Base encoding/decoding                 | [GitHub](https://github.com/cryptocoinjs/base-x)            |
| [bignumber.js](https://github.com/MikeMcl/bignumber.js)                | Arbitrary-precision decimal arithmetic | [GitHub](https://github.com/MikeMcl/bignumber.js)           |
| [seedrandom](https://github.com/davidbau/seedrandom)                   | Seeded pseudo-random number generator  | [GitHub](https://github.com/davidbau/seedrandom)            |
