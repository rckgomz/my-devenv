return {
  "preservim/vimux",
  name = "Vimux",
  config = function()
    vim.keymap.set("n", "<leader>op", "<cmd>VimuxPromptCommand<CR>", { desc = "Prompt cmd" })
    vim.keymap.set("n", "<leader>ol", "<cmd>VimuxRunLastCommand<CR>", { desc = "Run last cmd" })
  end,
}
