return {
  "nvim-tree/nvim-tree.lua",
  dependencies = {
    "nvim-tree/nvim-web-devicons", -- File icons
  },
  config = function()
    -- Disable netrw (built-in file explorer)
    vim.g.loaded_netrw = 1
    vim.g.loaded_netrwPlugin = 1

    require("nvim-tree").setup({
      -- General settings
      disable_netrw = true,
      hijack_netrw = true,
      hijack_cursor = true,
      hijack_unnamed_buffer_when_opening = false,
      sync_root_with_cwd = true,
      respect_buf_cwd = true,
      
      -- Update focused file
      update_focused_file = {
        enable = true,
        update_root = true,
        ignore_list = {},
      },
      
      -- System open settings
      system_open = {
        cmd = nil,
        args = {},
      },
      
      -- Diagnostics integration
      diagnostics = {
        enable = false, -- Disabled to avoid sign conflicts
      },
      
      -- View settings
      view = {
        width = 35,
        side = "left",
        preserve_window_proportions = false,
        number = false,
        relativenumber = false,
        signcolumn = "yes",
        float = {
          enable = false,
          quit_on_focus_loss = true,
          open_win_config = {
            relative = "editor",
            border = "rounded",
            width = 30,
            height = 30,
            row = 1,
            col = 1,
          },
        },
      },
      
      -- Renderer settings (appearance)
      renderer = {
        add_trailing = false,
        group_empty = false,
        highlight_git = true,
        full_name = false,
        highlight_opened_files = "none",
        highlight_modified = "none",
        root_folder_label = ":~:s?$?/..?",
        indent_width = 2,
        indent_markers = {
          enable = true,
          inline_arrows = true,
          icons = {
            corner = "└",
            edge = "│",
            item = "│",
            bottom = "─",
            none = " ",
          },
        },
        icons = {
          webdev_colors = true,
          git_placement = "before",
          modified_placement = "after",
          padding = " ",
          symlink_arrow = " ➛ ",
          show = {
            file = true,
            folder = true,
            folder_arrow = true,
            git = true,
            modified = true,
          },
          glyphs = {
            default = "",
            symlink = "",
            bookmark = "󰆤",
            modified = "●",
            folder = {
              arrow_closed = "",
              arrow_open = "",
              default = "",
              open = "",
              empty = "",
              empty_open = "",
              symlink = "",
              symlink_open = "",
            },
            git = {
              unstaged = "✗",
              staged = "✓",
              unmerged = "",
              renamed = "➜",
              untracked = "★",
              deleted = "",
              ignored = "◌",
            },
          },
        },
        special_files = { "Cargo.toml", "Makefile", "README.md", "readme.md" },
        symlink_destination = true,
      },
      
      -- Hijack directories
      hijack_directories = {
        enable = true,
        auto_open = true,
      },
      
      -- Git integration
      git = {
        enable = true,
        ignore = true,
        show_on_dirs = true,
        show_on_open_dirs = true,
        timeout = 400,
      },
      
      -- Modified files
      modified = {
        enable = true,
        show_on_dirs = true,
        show_on_open_dirs = true,
      },
      
      -- Filesystem watchers
      filesystem_watchers = {
        enable = true,
        debounce_delay = 50,
        ignore_dirs = {},
      },
      
      -- Actions
      actions = {
        use_system_clipboard = true,
        change_dir = {
          enable = true,
          global = false,
          restrict_above_cwd = false,
        },
        expand_all = {
          max_folder_discovery = 300,
          exclude = {},
        },
        file_popup = {
          open_win_config = {
            col = 1,
            row = 1,
            relative = "cursor",
            border = "shadow",
            style = "minimal",
          },
        },
        open_file = {
          quit_on_open = false,
          resize_window = true,
          window_picker = {
            enable = true,
            picker = "default",
            chars = "ABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890",
            exclude = {
              filetype = { "notify", "packer", "qf", "diff", "fugitive", "fugitiveblame" },
              buftype = { "nofile", "terminal", "help" },
            },
          },
        },
        remove_file = {
          close_window = true,
        },
      },
      
      -- Trash settings
      trash = {
        cmd = "gio trash",
        require_confirm = true,
      },
      
      -- Live filter
      live_filter = {
        prefix = "[FILTER]: ",
        always_show_folders = true,
      },
      
      -- Tab settings
      tab = {
        sync = {
          open = false,
          close = false,
          ignore = {},
        },
      },
      
      -- Notify settings
      notify = {
        threshold = vim.log.levels.INFO,
      },
      
      -- Log settings
      log = {
        enable = false,
        truncate = false,
        types = {
          all = false,
          config = false,
          copy_paste = false,
          dev = false,
          diagnostics = false,
          git = false,
          profile = false,
          watcher = false,
        },
      },
    })

    -- Keymaps for nvim-tree
    local keymap = vim.keymap.set
    local opts = { silent = true, noremap = true }

    -- Toggle nvim-tree
    keymap("n", "<leader>t", "<cmd>NvimTreeToggle<CR>", vim.tbl_extend("force", opts, { desc = "Toggle file tree" }))
    
    -- Focus nvim-tree
    keymap("n", "<leader>tf", "<cmd>NvimTreeFocus<CR>", vim.tbl_extend("force", opts, { desc = "Focus file tree" }))
    
    -- Find current file in tree
    keymap("n", "<leader>ff", "<cmd>NvimTreeFindFile<CR>", vim.tbl_extend("force", opts, { desc = "Find current file in tree" }))
    
    -- Collapse all folders
    keymap("n", "<leader>tc", "<cmd>NvimTreeCollapse<CR>", vim.tbl_extend("force", opts, { desc = "Collapse all folders" }))
    
    -- Refresh tree
    keymap("n", "<leader>tr", "<cmd>NvimTreeRefresh<CR>", vim.tbl_extend("force", opts, { desc = "Refresh file tree" }))

    -- Auto-close nvim-tree when it's the last window
    local function auto_close_tree()
      local tree_wins = {}
      local floating_wins = {}
      local wins = vim.api.nvim_list_wins()
      for _, w in ipairs(wins) do
        local bufname = vim.api.nvim_buf_get_name(vim.api.nvim_win_get_buf(w))
        if bufname:match("NvimTree_") ~= nil then
          table.insert(tree_wins, w)
        end
        if vim.api.nvim_win_get_config(w).relative ~= '' then
          table.insert(floating_wins, w)
        end
      end
      if 1 == #wins - #floating_wins and #tree_wins > 0 then
        vim.cmd "quit"
      end
    end

    vim.api.nvim_create_autocmd("BufEnter", {
      group = vim.api.nvim_create_augroup("NvimTreeClose", {clear = true}),
      pattern = "NvimTree_*",
      callback = auto_close_tree
    })
  end,
}