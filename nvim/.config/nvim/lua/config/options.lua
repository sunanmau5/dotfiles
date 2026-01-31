vim.g.mapleader = " "
vim.g.maplocalleader = " "

vim.g.autoformat = false

local opt = vim.opt

opt.number = true
opt.relativenumber = true

opt.tabstop = 2
opt.shiftwidth = 2
opt.expandtab = true
opt.smartindent = true

opt.ignorecase = true
opt.smartcase = true
opt.hlsearch = true
opt.incsearch = true

opt.termguicolors = true
opt.signcolumn = "yes"
opt.cursorline = true
opt.scrolloff = 8
opt.sidescrolloff = 8
opt.wrap = false
opt.showmode = false

opt.splitright = true
opt.splitbelow = true

opt.undofile = true
opt.swapfile = false

opt.clipboard = "unnamedplus"
opt.mouse = "a"
opt.updatetime = 250
opt.timeoutlen = 300

opt.completeopt = "menuone,noselect,popup"
opt.cmdheight = 0
opt.title = true

-- use a thin/invisible window separator
opt.fillchars:append({ vert = " ", horiz = " ", horizup = " ", horizdown = " ", vertleft = " ", vertright = " ", verthoriz = " " })

opt.laststatus = 3
