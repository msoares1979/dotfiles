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

local function MyTabCarrousel()
  return {
    'filename',
    file_status = false,
    fmt = function(str)
      --    
      local left = string.rep(' ', vim.fn.tabpagenr() - 1)
      local right = string.rep(' ', vim.fn.tabpagenr('$') - vim.fn.tabpagenr())
      --return left .. '' .. '%#lualine_a_normal#' .. str .. '%#lualine_b_normal#' .. right
      return left .. '' .. right
    end,
    -- color = { fg = '#89b4fa', bg = 'black', gui='bold' },
    cond = function() return vim.fn.tabpagenr('$') > 1 end,
  }
end

local function MyLineCount()
  return {
    function()
      local pos = vim.fn.getpos('.')
      local curline = vim.fn.getline('.')
      local linecount = vim.fn.line("$")
      return string.format('󰆣%2d%2d%2d%2d', pos[2], linecount, pos[3], #curline)
    end
  }
end

local function MySearchCount()
  return {
    "searchcount",
    icon = '',
    cond = function()
      local res = vim.fn.searchcount{ maxcount = 1 }
      return res.total > 0
    end
  }
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
          always_show_tabline = false,
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
                modified = "󰎂", --"󰫣",
                readonly = "",
                unnamed = "",
                newfile = "",
              },
            },
          },
          lualine_b = {
            { 'mode', fmt = function(str) return str:sub(1,1) end }
          },
          lualine_c = {
            "fileformat",
            { "branch", icon = ''},
            {
              "diff",
              symbols = { added = icons.git.added, modified = icons.git.modified, removed = icons.git.removed, },
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
          lualine_x = {
            MySearchCount(),
            -- stylua: ignore
            {
              function() return require("noice").api.status.mode.get() end,
              cond = function() return package.loaded["noice"] and require("noice").api.status.mode.has() end,
              color = function() return { fg = Snacks.util.color("Constant") } end,
            },
          },
          lualine_y = {
            {
              "diagnostics",
              symbols = {
                error = icons.diagnostics.Error,
                warn = icons.diagnostics.Warn,
                info = icons.diagnostics.Info,
                hint = icons.diagnostics.Hint,
              },
            },
            {
              function() return "  " .. require("dap").status() end,
              cond = function() return package.loaded["dap"] and require("dap").status() ~= "" end,
              color = "Debug"
            },
            { "filetype" },
          },
          lualine_z = { MyLineCount() }
        },
        inactive_sections = {}, -- not enabled anyway
        tabline = {
          lualine_a = {},
          lualine_b = { MyTabCarrousel() },
          lualine_c = {},
          lualine_x = {},
          lualine_y = {},
          lualine_z = {}
        },
        extensions = {}, --[[add your custom lualine config here]]
      }
    end,
  }
}
