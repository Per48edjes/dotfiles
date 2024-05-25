return {
  -- Add the community repository of plugin specifications
  "AstroNvim/astrocommunity",
  -- For local AstroCommunity development, use the following instead:
  -- { dir = "~/code/astrocommunity" },
  -- example of imporing a plugin, comment out to use it or add your own
  -- available plugins can be found at https://github.com/AstroNvim/astrocommunity

  { import = "astrocommunity.colorscheme.dracula-nvim" },
  { import = "astrocommunity.comment.mini-comment" },
  { import = "astrocommunity.completion.copilot-lua-cmp" },
  { import = "astrocommunity.markdown-and-latex.vimtex" },
  { import = "astrocommunity.editing-support.todo-comments-nvim" },
  { import = "astrocommunity.pack.lua" },
  { import = "astrocommunity.pack.bash" },
  { import = "astrocommunity.pack.markdown" },
  { import = "astrocommunity.pack.cpp" },
  { import = "astrocommunity.pack.python" },
  { import = "astrocommunity.pack.typescript" },
  { import = "astrocommunity.pack.haskell" },
}
