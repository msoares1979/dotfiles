return {
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      -- auto-merge may not work with lists, so we use vim.list_extend
      vim.list_extend(opts.ensure_installed, {
        "bash",
        "c",
        "cmake",
        "cpp",
        "css",
        "html",
        "gitignore",
        "graphql",
        "javascript",
        "json",
        "lua",
        "markdown",
        "markdown_inline",
        "python",
        "regex",
        "sql",
        "vim",
        "yaml",
      })
    end,
  },
  {
    "nvim-treesitter/nvim-treesitter-textobjects",
    opts = {
      textobjects = {
        move = {
          enable = true,
          goto_next_start = {
            ["]]"] = "@function.outer",
            ["]c"] = "@class.outer",
          },
          goto_previous_start = {
            ["[["] = "@function.outer",
            ["[c"] = "@class.outer",
          },
        }
      }
    }
  }
}
