-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

vim.wo.number = true
vim.wo.conceallevel = 0

-- hides the tabline, which is the line that displays the tabs at the top of Neovim.
vim.opt.showtabline = 0

-- open splits in a more natural direction
-- https://vimtricks.com/p/open-splits-more-naturally/
vim.opt.splitright = true
vim.opt.splitbelow = true

-- Search options
vim.opt.hlsearch = true
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- Navigation
vim.opt.whichwrap = "<,>,[,],h,l"
vim.opt.scrolloff = 0

-- Clipboard
vim.opt.clipboard = "unnamed"
vim.opt.mouse = ''

-- Coding, Formatting
vim.g.autoformat = false
-- See https://github.com/LazyVim/LazyVim/issues/1759
vim.opt.formatexpr = nil

-- Fix-up gqq (avoid formatexpr from LSP)
-- See https://vi.stackexchange.com/a/39800
 vim.api.nvim_create_autocmd('LspAttach', {
   callback = function(args)
     vim.bo[args.buf].formatexpr = nil
   end,
 })
