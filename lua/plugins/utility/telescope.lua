---@module 'telescope'
return {
  {
    'nvim-telescope/telescope.nvim',
    version = '*',
    dependencies = {
      'nvim-lua/plenary.nvim',
      { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
      'nvim-tree/nvim-web-devicons',
      'nvim-telescope/telescope-project.nvim',
    },
    lazy = true,
    init = function()
      local builtin = require('telescope.builtin');

      require('telescope').load_extension('project')  

      local wk = require('which-key')
      wk.add({
        { '<leader>ff', builtin.find_files, desc = 'Find Files' },
        { '<leader>fg', builtin.live_grep, desc = 'Live Grep' },
        { '<leader>fb', builtin.buffers, desc = 'Find Buffers' },
        { '<leader>fh', builtin.help_tags, desc = 'Help Tags' },
        { '<leader>fc', builtin.commands, desc = 'Commands' },
        { '<leader>fp', '<CMD>Telescope project<CR>', desc = 'Projects' }
      })
    end,
  },
}
