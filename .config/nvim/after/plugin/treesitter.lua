require'nvim-treesitter.configs'.setup {
  ensure_installed = { "c", "lua", "vim", "vimdoc", "query", "go", "typescript", "javascript", "tsx", "rust", "sql", "python", "bash", "dockerfile", "html", "latex", "pug", "yaml" },

  sync_install = false,
  auto_install = true,
}
