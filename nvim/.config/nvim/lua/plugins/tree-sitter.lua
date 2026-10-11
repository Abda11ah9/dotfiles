return {
  'nvim-treesitter/nvim-treesitter',
  lazy = false,
  build = ':TSUpdate',
  config = function()
--  require("nvim-treesitter").setup({})

  -- Installs asynchronously; skips parsers that are already installed
  require("nvim-treesitter").install({ "lua", "c", "javascript", "cpp", "python" })

  vim.api.nvim_create_autocmd("FileType", {
    pattern = { "lua", "c", "cpp", "javascript", "python" },
    callback = function()
      -- Neovim's built-in treesitter highlighting
      vim.treesitter.start()
      -- nvim-treesitter's indent module (experimental)
      vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
    end,
  })
  end
}

