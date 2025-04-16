require("catppuccin").setup {
  custom_highlights = function(colors)
    return {
      WinSeparator = { fg = '#aaaaff' },
    }
  end
}

return {
  {
    "snacks.nvim",
    opts = {
      dashboard = {
        preset = {
          pick = function(cmd, opts)
            return LazyVim.pick(cmd, opts)()
          end,
          header = [[
███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗
████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║
██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║
██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║
██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║
╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝
          ]],
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
          { section = "header", align = "center" },
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
