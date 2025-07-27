return {
  {
    "catppuccin",
    opts = {
      custom_highlights = { WinSeparator = { fg = '#aaaaff' } },
      dim_inactive = { enabled = true, shade = "dark", percentage = 2 },
    }
  },
  {
    "sphamba/smear-cursor.nvim",
    enabled = false, -- breaks noice UI
    opts = {
      smear_between_buffers = true,
      smear_between_neighbor_lines = true,
      scroll_buffer_space = true,
      legacy_computing_symbols_support = true,
      smear_insert_mode = false,
      stiffness = 0.8,
      --trailing_stiffness = 0.5,
      --stiffness_insert_mode = 0.6,
      --trailing_stiffness_insert_mode = 0.6,
      distance_stop_animating = 0.6,
    },
  },
  {
    "snacks.nvim",
    opts = {
      dashboard = {
        width = 40,
        pane_gap = 2,
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
            { icon = " ", key = "n", desc = "New File", action = ":ene | startinsert" },
            { icon = " ", key = "f", desc = "Find File", action = ":lua Snacks.dashboard.pick('files')" },
            { icon = " ", key = "g", desc = "Find Text", action = ":lua Snacks.dashboard.pick('live_grep')" },
            { icon = " ", key = "c", desc = "Config", action = ":lua Snacks.dashboard.pick('files', {cwd = vim.fn.stdpath('config')})" },
            { icon = "󰒲 ", key = "l", desc = "Lazy", action = ":Lazy" },
            { icon = " ", key = "q", desc = "Quit", action = ":qa" },
          },
        },
        sections = {
          { section = "header", align = "center", enabled = false },
          { section = "keys", icon = "󰍜 ", title = "Actions", indent = 2, gap = 0, padding = 0 },
          { section = "recent_files", icon = " ", title = "Recent Files", indent = 2, padding = 2 },
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
          {
            pane = 2,
            section = "terminal",
            cmd = "chafa -s 48x16 --symbols block " .. vim.fn.stdpath("config") .. "/lua/plugins/header.jpg",
            width = 48,
            height = 16,
            padding = 0
          },
          { pane = 2, section = "startup" },
        }
      },
    },
  }
}
