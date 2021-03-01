# my Vim configuration

this is me trying to keep things simple.

### External dependencies

Note that the JS/TS dependencies can be installed either globally or locally in
each project.

#### Language servers

These power autocomplete, linting and jump-to-definition in their respective
language modes. See [ALE](https://github.com/dense-analysis/ale) and
[nvim-lsp](https://github.com/neovim/nvim-lsp) for more info here.

- [`rust-analyzer`](https://github.com/rust-analyzer/rust-analyzer) for Rust
- [`gopls`](https://github.com/golang/tools/tree/master/gopls) for Go

##### Vim only

Install the `typescript` package from npm for JS/TS LSP integration from ALE

##### neovim only

the following npm packages:

- `bash-language-server` for shell scripts
- `dockerfile-language-server-nodejs` for Dockerfiles
- `vscode-html-languageserver-bin` for HTML
- `typescript-language-server` for neovim linting in JS and TS
- `vim-language-server` for vimscript
- `vscode-css-languageserver-bin` for CSS/SASS/LESS
- `vscode-json-languageserver` for JSON

#### Linters and fixers

These provide additional functionality beyond the language servers.

- [`rustfmt`](https://github.com/rust-lang/rustfmt) for autoformatting Rust
- `prettier-eslint` and `eslint` for JS and TS quality-of-life
- [`golint`](https://github.com/golang/lint) for style linting in Go
