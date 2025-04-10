return {
  {
    -- Highly experimental plugin that completely replaces the UI for messages, cmdline and the popupmenu.
    "folke/noice.nvim",
    enabled = true,
    event = "VeryLazy",
    opts = {
      presets = {
        bottom_search = false,
        command_palette = true,
        long_message_to_split = true,
        lsp_doc_border = true
      },
      views = {
        cmdline_popup = {
          position = { row = 5, col = "50%", },
          size = { width = 60, height = "auto", },
        },
        popupmenu = {
          relative = "editor",
          position = { row = 8, col = "50%", },
          size = { width = 60, height = 20, },
          border = { style = "rounded", padding = { 0, 1 }, },
          win_options = { winhighlight = { Normal = "Normal", FloatBorder = "DiagnosticInfo" }, },
        },
        notify = { merge = true },
        split = { enter = true },
      },
    },
  }
}
