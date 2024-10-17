-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
local opts = { noremap = true, silent = true }

-- Next Tab
vim.keymap.set("n", "gt", ":bnext<Return>", opts)

-- Close Buffer
vim.keymap.set("n", "qq", ":bw<Return>", opts)

-- Redo
vim.keymap.set("n", "U", ":redo<Return>", opts)

-- Replace Text
vim.keymap.set("n", "<C-r>", ":%s/", opts)
