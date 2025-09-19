return {
  "nvim-lualine/lualine.nvim",
  dependencies = {
    "nvim-tree/nvim-web-devicons", -- File icons
  },
  config = function()
    -- Get catppuccin colors
    local colors = require("catppuccin.palettes").get_palette("mocha")
    
    -- Custom theme based on catppuccin
    local catppuccin_theme = {
      normal = {
        a = { bg = colors.blue, fg = colors.mantle, gui = "bold" },
        b = { bg = colors.surface1, fg = colors.blue },
        c = { bg = colors.mantle, fg = colors.text },
      },
      insert = {
        a = { bg = colors.green, fg = colors.base, gui = "bold" },
        b = { bg = colors.surface1, fg = colors.green },
      },
      visual = {
        a = { bg = colors.mauve, fg = colors.base, gui = "bold" },
        b = { bg = colors.surface1, fg = colors.mauve },
      },
      replace = {
        a = { bg = colors.red, fg = colors.base, gui = "bold" },
        b = { bg = colors.surface1, fg = colors.red },
      },
      command = {
        a = { bg = colors.yellow, fg = colors.base, gui = "bold" },
        b = { bg = colors.surface1, fg = colors.yellow },
      },
      inactive = {
        a = { bg = colors.surface0, fg = colors.overlay1 },
        b = { bg = colors.surface0, fg = colors.overlay1 },
        c = { bg = colors.surface0, fg = colors.overlay1 },
      },
    }

    -- Custom components
    local function location()
      return "%l:%c"
    end
    
    local function progress()
      return "%p%%/%L"
    end

    local function lsp_client()
      local clients = vim.lsp.get_active_clients({ bufnr = 0 })
      if #clients == 0 then
        return "No LSP"
      end
      local names = {}
      for _, client in ipairs(clients) do
        table.insert(names, client.name)
      end
      return table.concat(names, ", ")
    end

    require("lualine").setup({
      options = {
        theme = catppuccin_theme,
        component_separators = { left = "", right = "" },
        section_separators = { left = "", right = "" },
        disabled_filetypes = {
          statusline = { "NvimTree", "alpha", "dashboard" },
          winbar = {},
        },
        ignore_focus = {},
        always_divide_middle = true,
        globalstatus = true, -- Single statusline for all windows
        refresh = {
          statusline = 1000,
          tabline = 1000,
          winbar = 1000,
        },
      },
      sections = {
        -- Left side
        lualine_a = { 
          {
            "mode",
            fmt = function(str)
              local mode_map = {
                ["NORMAL"] = "NORMAL",
                ["INSERT"] = "INSERT",
                ["VISUAL"] = "VISUAL",
                ["V-LINE"] = "V-LINE",
                ["V-BLOCK"] = "V-BLOCK",
                ["COMMAND"] = "COMMAND",
                ["REPLACE"] = "REPLACE",
                ["SELECT"] = "SELECT",
                ["TERMINAL"] = "TERMINAL",
              }
              return mode_map[str] or str
            end,
          }
        },
        lualine_b = {
          {
            "branch",
            icon = "",
            color = { fg = colors.text },
          },
          {
            "diff",
            symbols = { added = " ", modified = " ", removed = " " },
            diff_color = {
              added = { fg = colors.green },
              modified = { fg = colors.yellow },
              removed = { fg = colors.red },
            },
          },
        },
        lualine_c = {
          {
            "filename",
            file_status = true, -- Shows file modification status
            newfile_status = false,
            path = 1, -- 0: Just the filename, 1: Relative path, 2: Absolute path
            shorting_target = 40,
            symbols = {
              modified = " ●",
              readonly = " ",
              unnamed = "[No Name]",
              newfile = "[New]",
            },
            color = { fg = colors.text },
          },
        },
        
        -- Right side
        lualine_x = {
          {
            "diagnostics",
            sources = { "nvim_diagnostic", "nvim_lsp" },
            sections = { "error", "warn", "info", "hint" },
            diagnostics_color = {
              error = { fg = colors.red },
              warn = { fg = colors.yellow },
              info = { fg = colors.sky },
              hint = { fg = colors.teal },
            },
            symbols = { error = " ", warn = " ", info = " ", hint = " " },
            colored = true,
            update_in_insert = false,
            always_visible = false,
          },
          {
            lsp_client,
            icon = " ",
            color = { fg = colors.text },
          },
        },
        lualine_y = {
          {
            "encoding",
            color = { fg = colors.text },
          },
          {
            "fileformat",
            symbols = {
              unix = "LF",
              dos = "CRLF",
              mac = "CR",
            },
            color = { fg = colors.text },
          },
          {
            "filetype",
            colored = true,
            icon_only = false,
            icon = { align = "right" },
            color = { fg = colors.text },
          },
        },
        lualine_z = {
          {
            location,
            color = { fg = colors.mantle, bg = colors.blue, gui = "bold" },
          },
          {
            progress,
            color = { fg = colors.mantle, bg = colors.mauve, gui = "bold" },
          },
        },
      },
      inactive_sections = {
        lualine_a = {},
        lualine_b = {},
        lualine_c = { "filename" },
        lualine_x = { "location" },
        lualine_y = {},
        lualine_z = {},
      },
      tabline = {}, -- Disable tabline (use bufferline if needed)
      winbar = {}, -- Disable winbar
      extensions = {
        "nvim-tree",
        "oil",
        "lazy",
        "mason",
        "telescope",
      },
    })
  end,
}