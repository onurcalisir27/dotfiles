return {
  -- Better file explorer
  {
    "stevearc/oil.nvim",
    config = function()
      require("oil").setup({
        default_file_explorer = true,
        columns = {
          "icon",
          -- "permissions",
          "size",
          -- "mtime",
        },
        keymaps = {
          ["g?"] = "actions.show_help",
          ["<CR>"] = "actions.select",
          ["<C-v>"] = "actions.select_vsplit",
          ["<C-h>"] = "actions.select_split",
          ["<C-p>"] = "actions.preview",
          ["<C-c>"] = "actions.close",
          ["<C-r>"] = "actions.refresh",
          ["-"] = "actions.parent",
          ["_"] = "actions.open_cwd",
          ["`"] = "actions.cd",
          ["~"] = "actions.tcd",
          ["gs"] = "actions.change_sort",
          ["gx"] = "actions.open_external",
          ["g."] = "actions.toggle_hidden",
        },
      })
      -- Keymap to open file explorer
      vim.keymap.set("n", "<leader>-", "<CMD>Oil<CR>", { desc = "Open parent directory" })
      vim.keymap.set("n", "<leader>e", "<CMD>Oil<CR>", { desc = "Open file explorer" })
    end,
  },

  -- Auto-pairs for brackets
  {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    config = function()
      require("nvim-autopairs").setup({
        check_ts = true, -- Use treesitter
        ts_config = {
          lua = {'string'},
          javascript = {'template_string'},
          java = false,
        }
      })
    end,
  },

  -- Highlight matching words under cursor
  {
    "RRethy/vim-illuminate",
    config = function()
      require('illuminate').configure({
        providers = {
          'lsp',
          'treesitter',
          'regex',
        },
        delay = 100,
        filetypes_denylist = {
          'dirvish',
          'fugitive',
          'NvimTree',
          'oil',
        },
      })

      -- Keymaps for navigating highlighted words
      vim.keymap.set('n', '<leader>]', function()
        require('illuminate').goto_next_reference()
      end, { desc = "Next reference" })

      vim.keymap.set('n', '<leader>[', function()
        require('illuminate').goto_prev_reference()
      end, { desc = "Previous reference" })
    end,
  },
}
