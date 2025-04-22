return {
  'voldikss/vim-floaterm',
  config = function()
    vim.cmd([[hi FloatermNC guifg=gray]])
  end,
  keys = {
    { "<leader>tf", "<cmd>FloatermNew<cr>", desc = "New floating terminal" },
  }
}
