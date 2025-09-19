return {
  "neovim/nvim-lspconfig",
  dependencies = {
    "williamboman/mason.nvim",
    "williamboman/mason-lspconfig.nvim",
    "folke/neodev.nvim",
  },
  config = function()
    require("neodev").setup({
      library = {
        enabled = true,
        runtime = true,
        types = true,
        plugins = true,
      },
    })

    require("mason").setup({
      ui = {
        icons = {
          package_installed = "✓",
          package_pending = "➜",
          package_uninstalled = "✗"
        }
      }
    })

    -- Setup mason-lspconfig FIRST, but with handlers
    require("mason-lspconfig").setup({
      ensure_installed = { "clangd", "pylsp", "cmake", "lua_ls" },
      automatic_installation = true,
      -- Use handlers to properly configure each server
      handlers = {
        -- Default handler
        function(server_name)
          require("lspconfig")[server_name].setup({})
        end,

        -- Custom clangd handler
        ["clangd"] = function()
          local lspconfig = require("lspconfig")
          lspconfig.clangd.setup({
            cmd = {
              -- Use Mason's clangd explicitly
              vim.fn.stdpath("data") .. "/mason/bin/clangd",
              "--background-index",
              "--suggest-missing-includes",
              "--clang-tidy",
              "--header-insertion=iwyu",
              "--completion-style=detailed",
              "--function-arg-placeholders",
              "--fallback-style=google",
              "--log=verbose", -- Add logging to debug crashes
            },
            init_options = {
              usePlaceholders = true,
              completeUnimported = true,
              clangdFileStatus = true,
            },
            root_dir = function(fname)
              local util = require("lspconfig.util")
              -- More specific root detection for ROS2
              return util.root_pattern(
                "compile_commands.json",
                "package.xml",
                "CMakeLists.txt"
              )(fname) or util.find_git_root(fname)
            end,
            on_attach = function(client, bufnr)
              print("clangd attached to buffer " .. bufnr)

              local map = function(mode, lhs, rhs, desc)
                vim.keymap.set(mode, lhs, rhs, { buffer = bufnr, desc = desc })
              end

              -- Essential LSP keymaps
              map("n", "gd", vim.lsp.buf.definition, "Go to Definition")
              map("n", "gr", vim.lsp.buf.references, "Go to References")
              map("n", "gI", vim.lsp.buf.implementation, "Go to Implementation")
              map("n", "gy", vim.lsp.buf.type_definition, "Go to Type Definition")
              map("n", "gD", vim.lsp.buf.declaration, "Go to Declaration")

              map("n", "K", vim.lsp.buf.hover, "Hover Documentation")
              map("n", "<C-k>", vim.lsp.buf.signature_help, "Signature Help")
              map("i", "<C-k>", vim.lsp.buf.signature_help, "Signature Help")

              map("n", "<leader>ca", vim.lsp.buf.code_action, "Code Actions")
              map("n", "<leader>rn", vim.lsp.buf.rename, "Rename Symbol")
              map("n", "<leader>f", function()
                vim.lsp.buf.format({ async = true })
              end, "Format Document")

              map("n", "[d", vim.diagnostic.goto_prev, "Previous Diagnostic")
              map("n", "]d", vim.diagnostic.goto_next, "Next Diagnostic")
              map("n", "<leader>e", vim.diagnostic.open_float, "Show Line Diagnostics")
              map("n", "<leader>q", vim.diagnostic.setloclist, "Open Diagnostic List")

              -- Inlay hints
              if client.server_capabilities.inlayHintProvider then
                vim.lsp.inlay_hint.enable(true, { bufnr = bufnr })
                map("n", "<leader>ih", function()
                  local current_setting = vim.lsp.inlay_hint.is_enabled({ bufnr = bufnr })
                  vim.lsp.inlay_hint.enable(not current_setting, { bufnr = bufnr })
                end, "Toggle Inlay Hints")
              end
            end,
            capabilities = vim.lsp.protocol.make_client_capabilities(),
          })
        end,

        -- Custom pylsp handler
        ["pylsp"] = function()
          require("lspconfig").pylsp.setup({
            settings = {
              pylsp = {
                plugins = {
                  pycodestyle = { enabled = false },
                  mccabe = { enabled = false },
                  pyflakes = { enabled = true },
                  rope_completion = { enabled = true },
                  rope_autoimport = { enabled = true },
                }
              }
            },
            on_attach = function(client, bufnr)
              print("pylsp attached to buffer " .. bufnr)
              -- Same keymaps as clangd (you can extract this to a function)
            end,
            capabilities = vim.lsp.protocol.make_client_capabilities(),
          })
        end,

        -- Custom lua_ls handler
        ["lua_ls"] = function()
          require("lspconfig").lua_ls.setup({
            on_init = function(client)
              local path = client.workspace_folders[1].name
              if vim.loop.fs_stat(path..'/.luarc.json') or vim.loop.fs_stat(path..'/.luarc.jsonc') then
                return
              end

              client.config.settings.Lua = vim.tbl_deep_extend('force', client.config.settings.Lua, {
                runtime = { version = 'LuaJIT' },
                workspace = {
                  checkThirdParty = false,
                  library = { vim.env.VIMRUNTIME, "${3rd}/luv/library" }
                }
              })
            end,
            settings = {
              Lua = {
                completion = { callSnippet = "Replace" },
                diagnostics = { globals = { "vim" } },
                telemetry = { enable = false },
              }
            },
            on_attach = function(client, bufnr)
              print("lua_ls attached to buffer " .. bufnr)
            end,
            capabilities = vim.lsp.protocol.make_client_capabilities(),
          })
        end,
      },
    })

    -- Diagnostics configuration
    vim.diagnostic.config({
      virtual_text = { prefix = "●", severity = vim.diagnostic.severity.ERROR },
      signs = true,
      underline = true,
      update_in_insert = false,
      severity_sort = true,
      float = {
        focusable = false,
        style = "minimal",
        border = "rounded",
        source = "always",
        header = "",
        prefix = "",
      },
    })

    local signs = { Error = " ", Warn = " ", Hint = "󰌶 ", Info = " " }
    for type, icon in pairs(signs) do
      local hl = "DiagnosticSign" .. type
      vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
    end
  end,
}
