return {
  {
    "lewis6991/gitsigns.nvim",
    event = "LazyFile",
    opts = {
      signs = {
        add = { text = "" },
        change = { text = "▎" },
        delete = { text = "" },
        topdelete = { text = "" },
        changedelete = { text = "" },
        untracked = { text = "▎" },
      },
      on_attach = function(buffer)
        local gs = package.loaded.gitsigns

        local function map(mode, l, r, desc)
          vim.keymap.set(mode, l, r, { buffer = buffer, desc = desc })
        end

        -- stylua: ignore start
        local opts = { wrap = true }
        map("n", "]c", function() gs.nav_hunk("next", opts, nil) end, "Next Hunk")
        map("n", "[c", function() gs.nav_hunk("prev", opts, nil) end, "Prev Hunk")
      end,
    },
  }
}
