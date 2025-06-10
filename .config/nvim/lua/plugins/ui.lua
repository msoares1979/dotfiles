return {
  {
    "catppuccin",
    opts = {
      custom_highlights = { WinSeparator = { fg = '#aaaaff' } },
      dim_inactive = { enabled = true, shade = "dark", percentage = 0.15 },
    }
  },
  {
    "snacks.nvim",
    opts = {
      dashboard = {
        preset = {
          pick = function(cmd, opts)
            return LazyVim.pick(cmd, opts)()
          end,
          header = (function ()
            local lines = {}
            local f = io.open(vim.fn.stdpath("config") .. "/lua/plugins/header.ascii", "r")
            if not f then return "" end
            for line in f:lines() do
              table.insert(lines, #lines + 1, line)
            end
            f:close()
            return table.concat(lines, "\n")
          end)(),
          -- stylua: ignore
          ---@type snacks.dashboard.Item[]
          keys = {
            { hidden = true, icon = " ", key = "n", desc = "New File", action = ":ene | startinsert" },
            { hidden = true, icon = " ", key = "f", desc = "Find File", action = ":lua Snacks.dashboard.pick('files')" },
            { hidden = true, icon = " ", key = "g", desc = "Find Text", action = ":lua Snacks.dashboard.pick('live_grep')" },
            { hidden = true, icon = "󰒲 ", key = "l", desc = "Lazy", action = ":Lazy" },
            { hidden = true, icon = " ", key = "q", desc = "Quit", action = ":qa" },
          },
        },
        sections = {
          { section = "header", align = "center", enabled = false },
          {
            section = "terminal",
            cmd = "chafa -s 64x32 --symbols block " .. vim.fn.stdpath("config") .. "/lua/plugins/header.jpg",
            width = 64,
            height = 20,
            padding = 1
          },
          { section = "keys", gap = 1, padding = 1 },
          {
            align = 'center',
            padding = 1,
            text = {
              { "   New File (n)" },
              { "   Find File (f)" },
              { "   Find Text (g)" },
              { " 󰒲  Lazy (l)" },
              { "   Quit (q)" }
            }
          },
          { section = "recent_files", icon = " ", title = "Recent Files", indent = 2, padding = 1 },
          { section = "session", indent = 2, padding = 1 },
          {
            section = "terminal",
            icon = " ",
            title = "Git Status",
            enabled = function()
              return Snacks.git.get_root() ~= nil
            end,
            cmd = "git status --short --branch --renames",
            height = 7,
            padding = 1,
            indent = 2,
          },
          { section = "startup" }
        }
      },
    },
  }
}
