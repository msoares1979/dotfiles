return {
  -- Highly experimental plugin that completely replaces the UI for messages, cmdline and the popupmenu.
  {
    "folke/noice.nvim",
    event = "VeryLazy",
    opts = {
      lsp = {
        override = {
          ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
          ["vim.lsp.util.stylize_markdown"] = true,
          ["cmp.entry.get_documentation"] = true,
        },
      },
      routes = {
        {
          filter = {
            event = "msg_show",
            any = {
              { find = "%d+L, %d+B" },
              { find = "; after #%d+" },
              { find = "; before #%d+" },
            },
          },
          view = "mini",
        },
      },
      presets = {
        bottom_search = false,
        command_palette = true,
        long_message_to_split = true,
        inc_rename = true,
        lsp_doc_border = true
      },
    },
    -- stylua: ignore
    keys = {
      { "<S-Enter>", function() require("noice").redirect(vim.fn.getcmdline()) end, mode = "c", desc = "Redirect Cmdline" },
      { "<leader>snl", function() require("noice").cmd("last") end, desc = "Noice Last Message" },
      { "<leader>snh", function() require("noice").cmd("history") end, desc = "Noice History" },
      { "<leader>sna", function() require("noice").cmd("all") end, desc = "Noice All" },
      { "<leader>snd", function() require("noice").cmd("dismiss") end, desc = "Dismiss All" },
      { "<c-f>", function() if not require("noice.lsp").scroll(4) then return "<c-f>" end end, silent = true, expr = true, desc = "Scroll forward", mode = {"i", "n", "s"} },
      { "<c-b>", function() if not require("noice.lsp").scroll(-4) then return "<c-b>" end end, silent = true, expr = true, desc = "Scroll backward", mode = {"i", "n", "s"}},
    },
    views = {
      cmdline_popup = {
        position = { row = 5, col = "50%", },
        size = { width = 60, height = "auto", },
      },
      popupmenu = {
        relative = "editor",
        position = { row = 8, col = "50%", },
        size = { width = 60, height = 10, },
        border = { style = "rounded", padding = { 0, 1 }, },
        win_options = { winhighlight = { Normal = "Normal", FloatBorder = "DiagnosticInfo" }, },
      },
    },
  },

  {
    "nvim-lualine/lualine.nvim",
    event = "VeryLazy",
    opts = function()
      local Util = require("lazyvim.util")
      local icons = require("lazyvim.config").icons

      return {
        options = {
          theme = "auto",
          globalstatus = true,
          disabled_filetypes = { statusline = { "dashboard", "alpha", "starter" } },
          component_separators = {}, -- { left = "▌", right = "▐" },
          section_separators = { left = "", right = "" },
        },
        sections = {
          lualine_a = {
            function()
              return "[" .. vim.fn.bufnr() .. "]"
            end,
            {
              "filename",
              file_status = true, -- Displays file status (readonly status, modified status)
              newfile_status = false, -- Display new file status (new file means no write after created)
              path = 1, -- 0: Just the filename 1: Relative path 2: Absolute path 3: Absolute path, with tilde as home 4: Filename and parent dir, with tilde as home
              symbols = { -- text to show according to file state
                modified = "[+]",
                readonly = "[-]",
                unnamed = "(no name)",
                newfile = "[*]",
              },
            },
          },
          lualine_b = { "mode" },
          lualine_c = {
            "fileformat",
            "filetype",
            "branch",
            {
              "diagnostics",
              symbols = {
                error = icons.diagnostics.Error,
                warn = icons.diagnostics.Warn,
                info = icons.diagnostics.Info,
                hint = icons.diagnostics.Hint,
              },
            },
          },
          lualine_x = {
            { "searchcount" },
            -- stylua: ignore
            {
              function() return "  " .. require("dap").status() end,
              cond = function() return package.loaded["dap"] and require("dap").status() ~= "" end,
              color = Util.ui.fg("Debug"),
            },
            {
              require("lazy.status").updates,
              cond = require("lazy.status").has_updates,
              color = Util.ui.fg("Special"),
            },
            {
              "diff",
              symbols = {
                added = icons.git.added,
                modified = icons.git.modified,
                removed = icons.git.removed,
              },
              source = function()
                local gitsigns = vim.b.gitsigns_status_dict
                if gitsigns then
                  return {
                    added = gitsigns.added,
                    modified = gitsigns.changed,
                    removed = gitsigns.removed,
                  }
                end
              end,
            },
          },
          lualine_y = {
            function() -- show progress
              require("math")
              local endviewport = vim.fn.line("w$")
              local startviewport = vim.fn.line("w0")
              local linescount = vim.fn.line("$")

              local f = function(slices)
                local active, inactive = "", "" -- 
                local filler = ""
                local start = math.ceil(startviewport * slices / linescount)
                local stop = math.ceil(endviewport * slices / linescount)
                for i = 1, slices, 1 do
                  filler = filler .. (i >= start and i <= stop and active or inactive)
                end
                return filler
              end

              return "[" .. f(5) .. "]"
            end,
            { "location", padding = { left = 0, right = 1 } },
          },
          lualine_z = {
            function()
              return " " .. os.date("%R")
            end,
          },
        },
        inactive_sections = {}, -- not enabled anyway
        tabline = {},
        extensions = {}, --[[add your custom lualine config here]]
      }
    end,
  },

  {
    "lewis6991/gitsigns.nvim",
    event = "LazyFile",
    opts = {
      signs = {
        add = { text = "▎" },
        change = { text = "▎" },
        delete = { text = "" },
        topdelete = { text = "" },
        changedelete = { text = "▎" },
        untracked = { text = "▎" },
      },
      on_attach = function(buffer)
        local gs = package.loaded.gitsigns

        local function map(mode, l, r, desc)
          vim.keymap.set(mode, l, r, { buffer = buffer, desc = desc })
        end

        -- stylua: ignore start
        map("n", "]h", gs.next_hunk, "Next Hunk")
        map("n", "[h", gs.prev_hunk, "Prev Hunk")
      end,
    },
  },
}
