-- Highlight when yanking (copying) text
vim.api.nvim_create_autocmd("TextYankPost", {
  desc = "Highlight when yanking (copying) text",
  group = vim.api.nvim_create_augroup("highlight-yank", { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})

-- Remove trailing whitespace on save
vim.api.nvim_create_autocmd("BufWritePre", {
  desc = "Remove trailing whitespace on save",
  group = vim.api.nvim_create_augroup("remove-trailing-whitespace", { clear = true }),
  callback = function()
    local save_cursor = vim.fn.getpos(".")
    vim.cmd([[%s/\s\+$//e]])
    vim.fn.setpos(".", save_cursor)
  end,
})

-- Auto-save after 10 minutes of inactivity
vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
  desc = "Auto-save after 10 minutes of inactivity",
  group = vim.api.nvim_create_augroup("auto-save", { clear = true }),
  callback = function()
    if vim.bo.modified and vim.bo.buftype == "" and vim.fn.expand("%") ~= "" then
      vim.cmd("silent! write")
      print("File auto-saved")
    end
  end,
})

-- Set updatetime for auto-save (10 minutes = 600000ms)
vim.opt.updatetime = 600000
