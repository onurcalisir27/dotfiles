-- Clear search highlighting
-- vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>")

-- Better window navigation
vim.keymap.set("n", "<C-h>", "<C-w><C-h>", { desc = "Move focus to the left window" })
vim.keymap.set("n", "<C-l>", "<C-w><C-l>", { desc = "Move focus to the right window" })
vim.keymap.set("n", "<C-j>", "<C-w><C-j>", { desc = "Move focus to the lower window" })
vim.keymap.set("n", "<C-k>", "<C-w><C-k>", { desc = "Move focus to the upper window" })

-- Better indenting in visual mode
vim.keymap.set("v", "<", "<gv")
vim.keymap.set("v", ">", ">gv")

-- Move text up and down in visual mode
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

-- Keep cursor centered when scrolling
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

-- Quick save
vim.keymap.set("n", "<C-s>", "<cmd>w<CR>", { desc = "Save file" })
vim.keymap.set("i", "<C-s>", "<Esc><cmd>w<CR>a", { desc = "Save file from insert mode" })

-- Quick close
vim.keymap.set("n", "<C-q>", "<cmd>q<CR>", { desc = "Quit nvim in normal mode"})
vim.keymap.set("i", "<C-q>", "<Esc><cmd>q<CR>", { desc = "Quit nvim in insert mode"})
vim.keymap.set("n", "<leader>qa", "<cmd>q<CR>", { desc = "Quit nvim in normal mode"})
vim.keymap.set("i", "<leader>qa", "<Esc><cmd>q<CR>", { desc = "Quit nvim in insert mode"})

-- Easier window splitting
vim.keymap.set("n", "<leader>sv", "<cmd>vsplit<CR>", { desc = "Split window vertically" })
vim.keymap.set("n", "<leader>sh", "<cmd>split<CR>", { desc = "Split window horizontally" })
vim.keymap.set("n", "<leader>se", "<C-w>=", { desc = "Make splits equal size" })
vim.keymap.set("n", "<leader>sx", "<cmd>close<CR>", { desc = "Close current split" })

-- Better buffer navigation
vim.keymap.set("n", "<leader>bn", "<cmd>bnext<CR>", { desc = "Next buffer" })
vim.keymap.set("n", "<leader>bp", "<cmd>bprev<CR>", { desc = "Previous buffer" })
vim.keymap.set("n", "<leader>bd", "<cmd>bdelete<CR>", { desc = "Delete buffer" })

-- Quick comment shortcuts (these will work once Comment.nvim loads)
-- <leader>cc - toggle line comment
-- <leader>cb - toggle block comment
-- <leader>c + motion - comment motion (e.g., <leader>c3j comments 3 lines down)
-- In visual mode: <leader>c comments selection

-- Better file navigation
vim.keymap.set("n", "<leader>pf", "<cmd>find<CR>", { desc = "Find files" })
vim.keymap.set("n", "<leader>ph", "<cmd>find %:h/*<CR>", { desc = "Find files in current directory" })

-- Check LSP
vim.keymap.set("n", "<leader>li", "<cmd>LspInfo<CR>", { desc = "LSP Info" })
