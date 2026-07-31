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
      'nvim-telescope/telescope-ui-select.nvim',
    },
    keys = {
      { '<leader>ff', function() require('telescope.builtin').find_files() end, desc = 'Find Files' },
      { '<leader>fg', function() require('telescope.builtin').live_grep() end, desc = 'Live Grep' },
      { '<leader>fb', function() require('telescope.builtin').buffers() end, desc = 'Find Buffers' },
      { '<leader>fh', function() require('telescope.builtin').help_tags() end, desc = 'Help Tags' },
      { '<leader>fc', function() require('telescope.builtin').commands() end, desc = 'Commands' },
      { '<leader>fp', '<CMD>Telescope project<CR>', desc = 'Projects' },
    },
    config = function()
      local telescope = require('telescope')
      telescope.setup({
        extensions = {
          ['ui-select'] = {
            require('telescope.themes').get_dropdown({}),
          },
        },
      })
      telescope.load_extension('fzf')
      telescope.load_extension('project')
      telescope.load_extension('ui-select')
    end,
  },
}
