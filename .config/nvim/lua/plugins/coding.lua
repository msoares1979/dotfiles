
return {
  -- auto completion
  {
    "saghen/blink.cmp",
    enabled = true,
    dependencies = {
      { 'L3MON4D3/LuaSnip', version = 'v2.*' }
    },
    opts =  {
      snippets = { preset = 'default' },
      --snippets = { preset = 'luasnip' },
      sources = { default = { "lsp", "path", "snippets", "buffer", "copilot" } },
      completion = {
        keyword = { range = 'prefix' },
        menu = { auto_show = false, border = 'single' },
        -- Don't select by default, auto insert on selection    
        list = { selection = { preselect = true, auto_insert = false } },
        -- Show documentation when selecting a completion item
        documentation = {
          auto_show = true,
          auto_show_delay_ms = 500,
          window = { border = 'single' }
        },
      },
      signature = { window = { border = 'single' } },
      keymap = {
        preset = 'default',
        ['<C-c>'] =  { function(cmp) cmp.cancel() end },
        -- ['<CR>']  =  { 'select_and_accept', 'fallback' },
        ['<C-u>'] =  { 'scroll_documentation_up', 'fallback' },
        ['<C-d>'] =  { 'scroll_documentation_down', 'fallback' },
        ['<Tab>'] =  { 'select_next', 'fallback' },
        ['<Up>'] =   { 'select_prev', 'fallback' },
        ['<Down>'] = { 'select_next', 'fallback' },
      },
    },
  },
}
