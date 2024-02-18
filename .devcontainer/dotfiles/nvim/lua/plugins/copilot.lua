return {
  "zbirenbaum/copilot.lua",
  opts = function(_, opts)
    opts.suggestion = {
      enabled = true,
      keymap = {
        accept = "<C-l>",
        next = "<C-j>",
        prev = "<C-k>",
        dismiss = "<C-h>",
      },
    }
    opts.panel = { enabled = true }
  end,
}
