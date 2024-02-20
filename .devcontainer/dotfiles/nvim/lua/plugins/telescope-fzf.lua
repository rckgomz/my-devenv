return {
  "nvim-telescope/telescope-fzf-native.nvim",
  dependencies = {
    "telescope.nvim",
  },
  build = "make",
  config = function()
    require("telescope").load_extension("fzf")
  end,
}
