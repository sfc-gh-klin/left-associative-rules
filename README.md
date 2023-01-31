# left-associative-rules

This [commit](https://github.com/lezer-parser/lr/commit/84bb8aaf89940bd67b2e1fb9491d40c9e4098b30) in lezer/lr was done to fix an [issue](https://github.com/codemirror/dev/issues/1030).

However, the fix for that issue ended up affecting SQL statement boundary parsing behavior in a project I work on.

This repository attempts to show a minimal reproduction of the no parse error that causes SQL statements to be broken up in the middle of the statement incorrectly in the project affected.

## Instructions

- `pnpm install` - to install packages
- `pnpm build` - to generate the parser
- `pnpm test` - to run the test

The parse error that occurs after a certain length is caused by the if-condition linked in the commit above. The test in test-errorNodes.js will fail due to that no-parse but this parse according to the grammar rules should be valid.

## Things I've tried with the grammar

### Fixed length repetitions

Tried creating a term that was made of a fixed number of the generic subterm, like

```
AnyA {
  A | A2
}

A2 {
 A A
}
```

This is okay for 2 counts of the subterm but at 3 counts it fails with

```
Tokenizer tables too big to represent with 16-bit offsets
```

### Uncapitalized term

Also tried using the uncapitalized term since capitalized rules show up as nodes in the syntax trees and uncapitalized won't, but since the parser is still seeing the term and working its shift or reduce magic on it, it still hits the same parsing problem regardless of saving the node or not. At least, that's my understanding.
