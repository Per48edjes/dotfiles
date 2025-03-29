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
  {
    "adoyle-h/lsp-toggle.nvim",
    dependencies = { "neovim/nvim-lspconfig", "nvim-telescope/telescope.nvim" },
    event = "VeryLazy",
    config = function()
      require("lsp-toggle").setup {
        create_cmds = true,
        telescope = true,
      }
    end,
  },
  {
    "kylechui/nvim-surround",
    version = "*", -- Use for stability; omit to use `main` branch for the latest features
    event = "VeryLazy",
    config = function()
      require("nvim-surround").setup {
        -- Configuration here, or leave empty to use defaults
      }
    end,
  },
  {
    "folke/trouble.nvim",
    dependencies = "nvim-tree/nvim-web-devicons",
    opts = {
      -- Your configuration comes here
      -- or leave it empty to use the default settings
    },
  },
  {
    "folke/twilight.nvim",
    opts = {
      dimming = {
        alpha = 0.25, -- amount of dimming
        -- we try to get the foreground from the highlight groups or fallback color
        color = { "Normal", "#ffffff" },
        term_bg = "#000000", -- if guibg=NONE, this will be used to calculate text color
        inactive = false, -- when true, other windows will be fully dimmed (unless they contain the same buffer)
      },
      context = 10, -- amount of lines we will try to show around the current line
      treesitter = true, -- use treesitter when available for the filetype
      -- treesitter is used to automatically expand the visible text,
      -- but you can further control the types of nodes that should always be fully expanded
      expand = { -- for treesitter, we we always try to expand to the top-most ancestor with these types
        "function",
        "method",
        "table",
        "if_statement",
      },
      exclude = {}, -- exclude these filetypes
    },
  },
  {
    "linux-cultist/venv-selector.nvim",
    dependencies = { "neovim/nvim-lspconfig", "nvim-telescope/telescope.nvim" },
    event = "VeryLazy", -- Optional: needed only if you want to type `:VenvSelect` without a keymapping
    config = function()
      require("venv-selector").setup {
        -- auto_refresh (default: false). Will automatically start a new search every time VenvSelect is opened.
        -- When its set to false, you can refresh the search manually by pressing ctrl-r. For most users this
        -- is probably the best default setting since it takes time to search and you usually work within the same
        -- directory structure all the time.
        auto_refresh = false,

        -- search_venv_managers (default: true). Will search for Poetry and Pipenv virtual environments in their
        -- default location. If you dont use the default location, you can
        search_venv_managers = true,

        -- search_workspace (default: true). Your lsp has the concept of "workspaces" (project folders), and
        -- with this setting, the plugin will look in those folders for venvs. If you only use venvs located in
        -- project folders, you can set search = false and search_workspace = true.
        search_workspace = true,

        -- path (optional, default not set). Absolute path on the file system where the plugin will look for venvs.
        -- Only set this if your venvs are far away from the code you are working on for some reason. Otherwise its
        -- probably better to let the VenvSelect search for venvs in parent folders (relative to your code). VenvSelect
        -- searchs for your venvs in parent folders relative to what file is open in the current buffer, so you get
        -- different results when searching depending on what file you are looking at.
        -- path = "/home/username/your_venvs",

        -- search (default: true) - Search your computer for virtual environments outside of Poetry and Pipenv.
        -- Used in combination with parents setting to decide how it searches.
        -- You can set this to false to speed up the plugin if your virtual envs are in your workspace, or in Poetry
        -- or Pipenv locations. No need to search if you know where they will be.
        search = true,

        -- dap_enabled (default: false) Configure Debugger to use virtualvenv to run debugger.
        -- require nvim-dap-python from https://github.com/mfussenegger/nvim-dap-python
        -- require debugpy from https://github.com/microsoft/debugpy
        -- require nvim-dap from https://github.com/mfussenegger/nvim-dap
        dap_enabled = true,

        -- parents (default: 2) - Used when search = true only. How many parent directories the plugin will go up
        -- (relative to where your open file is on the file system when you run VenvSelect). Once the parent directory
        -- is found, the plugin will traverse down into all children directories to look for venvs. The higher
        -- you set this number, the slower the plugin will usually be since there is more to search.
        -- You may want to set this to to 0 if you specify a path in the path setting to avoid searching parent
        -- directories.
        parents = 2,

        -- name (default: venv) - The name of the venv directories to look for.
        name = "venv", -- NOTE: You can also use a lua table here for multiple names: {"venv", ".venv"}`

        -- fd_binary_name (default: fd) - The name of the fd binary on your system. Some Debian based Linux Distributions like Ubuntu use ´fdfind´.
        fd_binary_name = "fd",

        -- notify_user_on_activate (default: true) - Prints a message that the venv has been activated
        notify_user_on_activate = true,
        pipenv_path = "$HOME/.local/share/virtualenvs",
        pyenv_path = "$HOME/.pyenv/versions",
      }
    end,
  },
  {
    "lervag/vimtex",
    ft = "tex",
    config = function()
      vim.g.tex_flavor = "tex"
      vim.g.vimtex_view_method = "skim"
      vim.g.vimtex_quickfix_mode = 1
      vim.g.vimtex_fold_enabled = 1
      vim.g.tex_conceal = "abdmg"
      vim.g.vimtex_compiler_latexmk = {
        options = {
          "--shell-escape",
          "-verbose",
          "-file-line-error",
          "-synctex=1",
          "-interaction=nonstopmode",
        },
      }
    end,
  },
}
