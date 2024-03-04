-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

local keymap = vim.keymap
local opts = { noremap = true, silent = true }

-- Restore vim's original H and L cursor handling
vim.keymap.del("n", "<S-h>", {})
vim.keymap.del("n", "<S-l>", {})

-- My Original mappings

keymap.set("n", "<F3>", "<cmd>e %:h<Return>")

keymap.set("n", "<F7>", "<cmd>cp<Return>")
keymap.set("n", "<F8>", "<cmd>cn<Return>")

-- New mappings

keymap.set("n", "<C-p>", "<cmd>cp<Return>")
keymap.set("n", "<C-n>", "<cmd>cn<Return>")

-- Window navigation
keymap.set("n", "<C-Tab>", "gt")
keymap.set("n", "<C-S-Tab>", "gT")
