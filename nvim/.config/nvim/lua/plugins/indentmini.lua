return {
  url = 'https://github.com/nvimdev/indentmini.nvim',
  cmd = { 'IndentToggle', 'IndentEnable', 'IndentDisable' },
  keys = {
    {'<leader>ui', '<Cmd>IndentToggle<CR>', desc = 'Toggle indent guides'},
  },
  lazy = true,
  config = function()
    -- IndentLine* groups have no defaults; link to theme (ayu) so colors match
    vim.api.nvim_set_hl(0, 'IndentLine', { link = 'LineNr' })
    vim.api.nvim_set_hl(0, 'IndentLineCurrent', { link = 'CursorLineNr' })

    require("indentmini").setup({
      char = '▏',
      minlevel = 2,
      exclude = { 'markdown', 'help', 'text', 'rst' },
      exclude_nodetype = { 'string', 'comment' }
    })
  end
}
