let b:ale_fixers = ['rustfmt', 'remove_trailing_lines', 'trim_whitespace']
let b:ale_linters = ['cargo', 'rls']

if executable('ra_lsp_server')
  let b:ale_rust_rls_executable = 'ra_lsp_server'
endif
