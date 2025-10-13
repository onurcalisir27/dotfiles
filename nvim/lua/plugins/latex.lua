return {
  {
    "lervag/vimtex",
    lazy = false,  -- Don't lazy load VimTeX
    config = function()
      -- PDF viewer
      vim.g.vimtex_view_method = 'zathura_simple'

      vim.g.vimtex_compiler_method = 'latexmk'
      -- Don't auto open quickfix on compile errors
      vim.g.vimtex_quickfix_mode = 1

      -- Suppress some compilation warnings
      vim.g.vimtex_quickfix_ignore_filters = {
        'Underfull',
        'Overfull',
      }

      -- Enable folding (optional)
      vim.g.vimtex_fold_enabled = 1

      -- Disable some features you might not need
      vim.g.vimtex_imaps_enabled = 0  -- Disable insert mode mappings if you don't want them

      vim.g.vimtex_syntax_conceal = {
        accents = 1,
        ligatures = 1,
        cites = 1,
        fancy = 1,
        spacing = 0,
        greek = 1,
        math_bounds = 0,
        math_delimiters = 1,
        math_fracs = 1,
        math_super_sub = 1,
        math_symbols = 1,
        sections = 0,
        styles = 1,
      }

      -- Better indentation
      vim.g.vimtex_indent_enabled = 1

      -- Table of contents settings
      vim.g.vimtex_toc_config = {
        name = 'TOC',
        layers = {'content', 'todo', 'include'},
        split_width = 30,
        todo_sorted = 0,
        show_help = 1,
        show_numbers = 1,
      }
      -- LaTeX-specific keymaps (only active in .tex files)
      vim.api.nvim_create_autocmd("FileType", {
        pattern = "tex",
        callback = function()
          local opts = { buffer = true, silent = true }

          -- VimTeX compile commands
          vim.keymap.set("n", "<localleader>ll", "<cmd>VimtexCompile<cr>", vim.tbl_extend("force", opts, { desc = "Toggle Compile" }))
          vim.keymap.set("n", "<localleader>lv", "<cmd>VimtexView<cr>", vim.tbl_extend("force", opts, { desc = "View PDF" }))
          vim.keymap.set("n", "<localleader>lc", "<cmd>VimtexClean<cr>", vim.tbl_extend("force", opts, { desc = "Clean Aux Files" }))
          vim.keymap.set("n", "<localleader>lC", "<cmd>VimtexClean!<cr>", vim.tbl_extend("force", opts, { desc = "Clean All" }))
          vim.keymap.set("n", "<localleader>le", "<cmd>VimtexErrors<cr>", vim.tbl_extend("force", opts, { desc = "Show Errors" }))
          vim.keymap.set("n", "<localleader>lo", "<cmd>VimtexCompileOutput<cr>", vim.tbl_extend("force", opts, { desc = "Show Output" }))
          vim.keymap.set("n", "<localleader>lt", "<cmd>VimtexTocOpen<cr>", vim.tbl_extend("force", opts, { desc = "Table of Contents" }))
          vim.keymap.set("n", "<localleader>lT", "<cmd>VimtexTocToggle<cr>", vim.tbl_extend("force", opts, { desc = "Toggle TOC" }))

          -- Navigation
          vim.keymap.set("n", "<localleader>li", "<cmd>VimtexInfo<cr>", vim.tbl_extend("force", opts, { desc = "VimTeX Info" }))
          vim.keymap.set("n", "<localleader>ls", "<cmd>VimtexStatus<cr>", vim.tbl_extend("force", opts, { desc = "Status" }))

          -- Text objects (these work with operators like d, c, v)
          -- Example: dse = delete surrounding environment, csc = change surrounding command
          -- These are built into VimTeX, just documenting them here
        end
      })
    end
  },
}
