let b:ale_fixers = ['rustfmt']
let b:ale_linters = ['cargo']

if executable('rust-analyzer')
  let b:ale_linters = ['cargo', 'rls']
endif
