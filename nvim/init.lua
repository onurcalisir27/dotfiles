local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out, "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)

-- Load configuration
require("config.options")
require("config.keymaps")
require("config.autocmds")

local plugins_path = vim.fn.stdpath("config") .. "/lua/plugins"
local plugins_exist = vim.fn.isdirectory(plugins_path) == 1 and #vim.fn.glob(plugins_path .. "/*.lua", false, true) > 0

if plugins_exist then
  require("lazy").setup("plugins", {
    change_detection = { notify = false },
  })
else
  require("lazy").setup({}, {
    change_detection = { notify = false },
  })
end
