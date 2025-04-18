ProgressBar = function(slices)
  require("math")
  local endviewport = vim.fn.line("w$")
  local startviewport = vim.fn.line("w0")
  local linescount = vim.fn.line("$")

  local f = function()
    local active, inactive = "▰", "▱" --             
    local filler = ""
    local start = math.ceil(startviewport * slices / linescount)
    local stop = math.ceil(endviewport * slices / linescount)
    for i = 1, slices, 1 do
      filler = filler .. (i >= start and i <= stop and active or inactive)
    end
    return filler
  end

  return f()
end

return {
  {
    "nvim-lualine/lualine.nvim",
    event = "VeryLazy",
    opts = function()
      local icons = require("lazyvim.config").icons

      return {
        options = {
          theme = "auto",
          globalstatus = true,
          disabled_filetypes = { statusline = { "dashboard", "alpha", "starter" } },
          -- component_separators = { left = '', right = '' },
          component_separators = {},
          section_separators = { left = "", right = "" },
        },
        sections = {
          lualine_a = {
            function() return "[" .. vim.fn.bufnr() .. "]" end,
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
              function() return require("noice").api.status.mode.get() end,
              cond = function() return package.loaded["noice"] and require("noice").api.status.mode.has() end,
              color = function() return { fg = Snacks.util.color("Constant") } end,
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
            {
              function() return "  " .. require("dap").status() end,
              cond = function() return package.loaded["dap"] and require("dap").status() ~= "" end,
              color = "Debug"
            },
          },
          lualine_y = {
            { function() return ProgressBar(7) end },
            { "location", padding = { left = 0, right = 1 } },
          },
          lualine_z = { function() return "  " .. os.date("%R") end }
        },
        inactive_sections = {}, -- not enabled anyway
        tabline = {},
        extensions = {}, --[[add your custom lualine config here]]
      }
    end,
  }
}
