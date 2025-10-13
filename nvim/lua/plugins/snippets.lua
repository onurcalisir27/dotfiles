return {
  {
    "L3MON4D3/LuaSnip",
    version = "v2.*",
    build = "make install_jsregexp",
    dependencies = {
      "rafamadriz/friendly-snippets",  -- Pre-made snippets
    },
    config = function()
      require("luasnip.loaders.from_vscode").lazy_load()

      -- Load custom LaTeX snippets
      require("luasnip.loaders.from_lua").load({
        paths = "~/.config/nvim/snippets/"
      })

      -- Keymaps for snippet jumping
      vim.keymap.set({"i", "s"}, "<C-j>", function()
        require("luasnip").jump(1)
      end, { desc = "Jump to next snippet position" })

      vim.keymap.set({"i", "s"}, "<C-k>", function()
        require("luasnip").jump(-1)
      end, { desc = "Jump to previous snippet position" })
    end,
  },
}
