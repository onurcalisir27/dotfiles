-- Vim Options --

-- Leader key
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Basic editor settings
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.mouse = "a"
vim.opt.showmode = false

-- Tabs and indentation
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true
vim.opt.autoindent = true

-- Search settings
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.hlsearch = false
vim.opt.incsearch = true

-- Appearance
vim.opt.termguicolors = true
vim.opt.background = "dark"
vim.opt.signcolumn = "yes"
vim.opt.wrap = false
vim.opt.cursorline = true

-- Better syntax highlighting settings
vim.opt.syntax = "on"
vim.opt.conceallevel = 0 -- Show concealed text
vim.opt.concealcursor = "" -- Don't conceal on cursor line

-- Better color support
vim.opt.pumblend = 10 -- Popup menu transparency
vim.opt.winblend = 0 -- Window transparency

-- Better cursor visibility
vim.opt.cursorcolumn = false -- Don't highlight cursor column (can be distracting)

-- Better visual indicators
vim.opt.list = true -- Show invisible characters
vim.opt.listchars = {
  tab = "→ ",
  trail = "·",
  extends = "›",
  precedes = "‹",
  nbsp = "␣",
}

-- Splits
vim.opt.splitright = true
vim.opt.splitbelow = true

-- Other useful settings
vim.opt.scrolloff = 8
vim.opt.sidescrolloff = 8
vim.opt.clipboard = "unnamedplus"
vim.opt.breakindent = true
vim.opt.undofile = true
vim.opt.updatetime = 250
vim.opt.timeoutlen = 300


vim.g.have_nerd_font = true
vim.o.undofile = true
vim.o.ignorecase = true
vim.o.smartcase = true
vim.o.signcolumn = 'yes'

