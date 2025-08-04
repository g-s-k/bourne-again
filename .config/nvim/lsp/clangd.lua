return {
  cmd = { 'clangd', '--clang-tidy' },
  filetypes = { 'c', 'cpp' },
  root_markers = { 'CMakeLists.txt', 'Makefile', 'README.md' },
};
