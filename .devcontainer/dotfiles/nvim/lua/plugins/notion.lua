return {
  "Al0den/notion.nvim",
  lazy = false,
  dependencies = {
    "nvim-telescope/telescope.nvim",
    "nvim-lua/plenary.nvim",
  },
  opts = function(_, opts)
    require("notion").setup()
  end,
}
