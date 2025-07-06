-- Customize Treesitter

---@type LazySpec
return {
  "nvim-treesitter/nvim-treesitter",
  opts = function(_, opts)
    -- add more things to the ensure_installed table protecting against community packs modifying it
    opts.ensure_installed = require("astrocore").list_insert_unique(opts.ensure_installed, {
      "lua",
      "vim",
      -- add more arguments for adding more treesitter parsers
    })
    -- Turn off treesitter highlight for LaTeX per vimtex docs
    opts.ignore_install = { "latex" }
    if not opts.highlight then opts.highlight = {} end
    if not opts.highlight.disable then opts.highlight.disable = {} end
    table.insert(opts.highlight.disable, "latex")
  end,
}
