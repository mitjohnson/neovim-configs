-- General Settings
vim.opt.expandtab = true
vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.shiftwidth = 2

vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.scrolloff = 999

vim.opt.spelllang = 'en_us'

vim.api.nvim_create_autocmd('FileType', {
  pattern = { 'markdown', 'text', 'gitcommit' },
  callback = function()
    vim.opt_local.spell = true
  end,
})

-- code folding (managed by nvim-ufo)
vim.opt.foldenable = true
vim.opt.foldlevel = 99
vim.opt.foldlevelstart = 99
vim.opt.foldtext = ''

vim.opt.fillchars = {
  fold = ' ',
  foldopen = '',
  foldclose = '',
  foldsep = '│',
}

vim.cmd([[
    highlight Folded guibg=NONE guifg=NONE
    highlight FoldColumn guibg=NONE
]])

vim.opt.laststatus = 3
