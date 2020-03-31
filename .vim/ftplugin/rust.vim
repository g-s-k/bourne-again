let b:ale_fixers = ['rustfmt', 'remove_trailing_lines', 'trim_whitespace']
let b:ale_linters = ['cargo']

if executable('rust-analyzer')
  let b:ale_linters = ['cargo', 'rls']
endif
