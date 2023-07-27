-- Mapping data with "desc" stored directly by vim.keymap.set().
--
-- Please use this mappings table to set keyboard mapping since this is the
-- lower level configuration and more robust one. (which-key will
-- automatically pick-up stored data by this setting.)
return {
  -- first key is the mode
  n = {
    -- second key is the lefthand side of the map
    -- tables with the `name` key will be registered with which-key if it's installed
    -- this is useful for naming menus
    -- mappings seen under group name "Buffer"
    ["<leader>bn"] = { "<cmd>tabnew<cr>", desc = "New tab" },
    ["<leader>bD"] = {
      function()
        require("astronvim.utils.status").heirline.buffer_picker(
          function(bufnr) require("astronvim.utils.buffer").close(bufnr) end
        )
      end,
      desc = "Pick to close",
    },
    ["<leader>fT"] = { "<cmd>TodoTelescope<cr>", desc = "Find TODOs" },
    -- mappings seen under group name "Trouble"
    ["<leader>x"] = { name = " Trouble" },
    ["<leader>xx"] = { "<cmd>TroubleToggle<cr>", desc = "Toggle Trouble" },
    ["<leader>xw"] = { "<cmd>TroubleToggle workspace_diagnostics<cr>", desc = "Trouble workspace diagnostics" },
    ["<leader>xd"] = { "<cmd>TroubleToggle document_diagnostics<cr>", desc = "Trouble document diagnostics" },
    ["<leader>xq"] = { "<cmd>TroubleToggle quickfix<cr>", desc = "Trouble quickfix list" },
    ["<leader>xl"] = { "<cmd>TroubleToggle loclist<cr>", desc = "Trouble local list" },
    ["gR"] = { "<cmd>TroubleToggle lsp_references<cr>", desc = "Trouble LSP references" },
    ["<F1>"] = { "<NOP>" },
  },
  i = {
    ["<F1>"] = { "<NOP>" },
  },
  t = {
    -- setting a mapping to false will disable it
    -- ["<esc>"] = false,
  },
}
