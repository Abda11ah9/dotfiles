return {
  "nvimtools/none-ls.nvim",
  config = function()
  local null_ls = require("null-ls")
  null_ls.setup({
      sources = {
       null_ls.builtins.formatting.stylua,
       null_ls.builtins.formatting.clang_format,
      }
    })
  vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = { "*.lua", "*.py", "*.c", "*.h", "*.cpp", "*.hpp" },
  callback = function()
    vim.lsp.buf.format({ async = false, timeout_ms = 3000 })
  end,
})
  vim.keymap.set('n', '<leader>gf', vim.lsp.buf.format, {})
  end
}
