# a more minimal Vim configuration

this is me trying to keep things simple.

### External dependencies

Note that the JS/TS dependencies can be installed either globally or locally in each project.

#### Language servers

These power autocomplete, linting and jump-to-definition in their respective 
language modes.

- [`rust-analyzer`](https://github.com/rust-analyzer/rust-analyzer) for Rust (binary must be named `ra_lsp_server`)
- the npm package `typescript` for JS and TS
- [`gopls`](https://github.com/golang/tools/tree/master/gopls) for Go

#### Linters and fixers

These provide additional functionality beyond the language servers.

- [`rustfmt`](https://github.com/rust-lang/rustfmt) for autoformatting Rust 
- `prettier` and `eslint` for JS and TS quality-of-life
- [`golint`](https://github.com/golang/lint) for style linting in Go

### To use

```
~ $ git clone git@github.com:g-s-k/vim-again .vim
~ $ cd .vim && git submodule update --init
```
