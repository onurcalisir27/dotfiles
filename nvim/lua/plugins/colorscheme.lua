return {
  {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000,
    config = function()
      require("catppuccin").setup({
        flavour = "mocha", -- latte, frappe, macchiato, mocha
        background = {
          light = "latte",
          dark = "mocha",
        },
        transparent_background = false,
        show_end_of_buffer = false,
        term_colors = true,
        dim_inactive = {
          enabled = false,
          shade = "dark",
          percentage = 0.15,
        },
        no_italic = false,
        no_bold = false,
        no_underline = false,
        styles = {
          comments = { "italic" },
          conditionals = { "italic" },
          loops = {},
          functions = { "bold" },
          keywords = { "italic" },
          strings = {},
          variables = {},
          numbers = {},
          booleans = {},
          properties = {},
          types = { "bold" },
          operators = {},
        },
        color_overrides = {
          mocha = {
            -- Enhanced colors for better syntax visibility
            text = "#cdd6f4",
            subtext1 = "#bac2de",
            subtext0 = "#a6adc8",
            overlay2 = "#9399b2",
            overlay1 = "#7f849c",
            overlay0 = "#6c7086",
            surface2 = "#585b70",
            surface1 = "#45475a",
            surface0 = "#313244",
            base = "#1e1e2e",
            mantle = "#181825",
            crust = "#11111b",
          },
        },
        custom_highlights = function(colors)
          return {
            -- Better comment visibility
            Comment = { fg = colors.overlay1, style = { "italic" } },

            -- Enhanced string highlighting
            String = { fg = colors.green, style = {} },

            -- Better function visibility
            Function = { fg = colors.blue, style = { "bold" } },
            ["@function"] = { fg = colors.blue, style = { "bold" } },
            ["@function.method"] = { fg = colors.blue, style = { "bold" } },
            ["@function.call"] = { fg = colors.blue, style = {} },

            -- Improved keyword highlighting
            Keyword = { fg = colors.mauve, style = { "italic" } },
            ["@keyword"] = { fg = colors.mauve, style = { "italic" } },
            ["@keyword.function"] = { fg = colors.mauve, style = { "italic" } },
            ["@keyword.return"] = { fg = colors.mauve, style = { "italic" } },

            -- Better variable highlighting
            ["@variable"] = { fg = colors.text, style = {} },
            ["@variable.builtin"] = { fg = colors.red, style = {} },
            ["@parameter"] = { fg = colors.maroon, style = {} },

            -- Type highlighting
            Type = { fg = colors.yellow, style = { "bold" } },
            ["@type"] = { fg = colors.yellow, style = { "bold" } },
            ["@type.builtin"] = { fg = colors.yellow, style = { "bold" } },

            -- Constants and numbers
            Constant = { fg = colors.peach, style = {} },
            ["@constant"] = { fg = colors.peach, style = {} },
            ["@constant.builtin"] = { fg = colors.peach, style = {} },
            Number = { fg = colors.peach, style = {} },
            ["@number"] = { fg = colors.peach, style = {} },
            Boolean = { fg = colors.peach, style = {} },
            ["@boolean"] = { fg = colors.peach, style = {} },

            -- Operators and punctuation
            Operator = { fg = colors.sky, style = {} },
            ["@operator"] = { fg = colors.sky, style = {} },
            ["@punctuation.delimiter"] = { fg = colors.overlay2, style = {} },
            ["@punctuation.bracket"] = { fg = colors.overlay2, style = {} },

            -- Better cursor and selection
            CursorLine = { bg = colors.surface0 },
            CursorLineNr = { fg = colors.lavender, style = { "bold" } },
            LineNr = { fg = colors.surface1 },
            Visual = { bg = colors.surface1 },

            -- Search highlighting
            Search = { bg = colors.surface1, fg = colors.pink },
            IncSearch = { bg = colors.pink, fg = colors.base },

            -- Matching brackets
            MatchParen = { fg = colors.peach, style = { "bold" } },

            -- Diagnostics
            DiagnosticError = { fg = colors.red },
            DiagnosticWarn = { fg = colors.yellow },
            DiagnosticInfo = { fg = colors.sky },
            DiagnosticHint = { fg = colors.teal },

            -- Better popup menu
            Pmenu = { bg = colors.surface0, fg = colors.overlay2 },
            PmenuSel = { bg = colors.surface1, fg = colors.text },
            PmenuSbar = { bg = colors.surface1 },
            PmenuThumb = { bg = colors.overlay0 },
          }
        end,
        integrations = {
          cmp = true,
          gitsigns = true,
          nvimtree = true,
          treesitter = true,
          telescope = {
            enabled = true,
            style = "nvchad",
          },
          illuminate = {
            enabled = true,
            lsp = false,
          },
          native_lsp = {
            enabled = true,
            virtual_text = {
              errors = { "italic" },
              hints = { "italic" },
              warnings = { "italic" },
              information = { "italic" },
            },
            underlines = {
              errors = { "underline" },
              hints = { "underline" },
              warnings = { "underline" },
              information = { "underline" },
            },
          },
        },
      })

      vim.cmd.colorscheme("catppuccin-mocha")
    end,
  },
}
