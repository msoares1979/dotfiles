local M = {
  'patrickpichler/hovercraft.nvim',

  dependencies = {
    { 'nvim-lua/plenary.nvim' },
  },

  debug = true,

  -- this is the default config and can be skipped
  opts = function()
    return {
      providers = {
        providers = {
          { 'LSP',  require('hovercraft.provider.lsp.hover').new() },
          { 'Man',  require('hovercraft.provider.man').new() },
          { 'Dict', require('hovercraft.provider.dictionary').new() },
          { 'Diagnostics', require('hovercraft.provider.diagnostics').new() },
        }
      },

      window = { border = 'single', },

      keys = {
        { '<C-u>', function() require('hovercraft').scroll({ delta = -4 }) end },
        { '<C-d>', function() require('hovercraft').scroll({ delta = 4 }) end },
        { '<C-n>', function() require('hovercraft').hover_next() end },
        { '<C-p>', function() require('hovercraft').hover_next({ step = -1 }) end },
      }
    }
  end,

  event = 'VeryLazy',

  keys = {
    {
      "<leader>k",
      function()
        local hovercraft = require("hovercraft")
        if hovercraft.is_visible() then
          hovercraft.enter_popup()
        else
          hovercraft.hover()
        end
      end,
      desc = 'Hovercraft keywords'
    },
  },
}

return M
