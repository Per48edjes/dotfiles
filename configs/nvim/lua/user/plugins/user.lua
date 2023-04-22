return {
  -- You can also add new plugins here as well:
  -- Add plugins, the lazy syntax
  -- "andweeb/presence.nvim",
  -- {
  --   "ray-x/lsp_signature.nvim",
  --   event = "BufRead",
  --   config = function()
  --     require("lsp_signature").setup()
  --   end,
  -- },
  "zbirenbaum/copilot.lua",
  "Mofiqul/dracula.nvim",
  {
    "kylechui/nvim-surround",
    version = "*", -- Use for stability; omit to use `main` branch for the latest features
    event = "VeryLazy",
    config = function()
      require("nvim-surround").setup({
        -- Configuration here, or leave empty to use defaults
      })
    end
  },
  -- TODO: Make cmd to load on start up
  {
    "folke/todo-comments.nvim",
    requires = "nvim-lua/plenary.nvim",
    event = "VeryLazy",
    config = function()
      require("todo-comments").setup {
        -- Configuration here, or leave empty to use defaults
      }
    end
  }
}
