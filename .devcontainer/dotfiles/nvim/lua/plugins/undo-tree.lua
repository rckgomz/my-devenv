return {
  "mbbill/undotree",
  config = function()
    vim.keymap.set("n", "<leader>U", ":UndotreeToggle<CR>", { desc = "[U]ndo tree", noremap = true, silent = true })
  end,
}
