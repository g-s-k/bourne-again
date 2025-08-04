return {
  cmd = { 'rust-analyzer' },
  filetypes = { 'rust' },
  root_markers = { 'Cargo.lock' },
  settings = {
    ["rust-analyzer"] = {
      cargo = {
        -- Use a sub-directory of the `target` directory so it doesn't mess with other compilation
        targetDir = true,
      },
      check = {
        command = 'clippy',
      },
      diagnostics = {
        disabled = { 'inactive-code' },
      },
    },
  },
};
