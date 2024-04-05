return {
  {
    "nvim-neotest/neotest",
    dependencies = { "nvim-neotest/neotest-jest" },
    opts = function(_, opts)
      table.insert({
        opts.adapters,
        require("neotest-jest")({
          jestCommnad = "npm test --",
          jestConfig = "jest.config.js",
          env = { "CI=true" },
          cwd = function()
            return vim.fn.getcwd()
          end,
        }),
      })
    end,
  },
}
