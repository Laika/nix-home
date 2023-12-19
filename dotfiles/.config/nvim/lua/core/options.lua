-- Clipboard
vim.opt.clipboard = "unnamedplus"

-- Case
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- Undo
vim.opt.undodir = vim.fn.stdpath("config") .. "/undo"
vim.opt.undofile = true

-- Timeout
vim.opt.updatetime = 250
vim.opt.timeout = true
vim.opt.timeoutlen = 300

-- Visual
vim.opt.syntax = "on"
vim.opt.termguicolors = true
vim.opt.background = "dark"
vim.opt.cursorline = true
vim.opt.signcolumn = "yes"
vim.opt.winbar = "%{%v:lua.require'nvim-navic'.get_location()%}"
vim.opt.scrolloff = 10

vim.opt.virtualedit = "onemore"
vim.opt.wrap = true
vim.opt.wrapscan = true

vim.opt.number = true

vim.opt.hlsearch = true
vim.opt.showmatch = true

-- Encoding
vim.opt.fileencodings = "utf-8,iso-2022-jp,euc-jp,ucs-2,cp932,sjis"
vim.opt.fileencoding = "utf-8"
vim.opt.encoding = "utf-8"

-- Fold
vim.opt.foldcolumn = "0"
vim.opt.foldexpr = "nvim_treesitter#foldexpr()"
vim.opt.foldlevel = 100
vim.opt.foldmethod = "expr"

-- Indent
vim.opt.autoindent = true
vim.opt.backspace = "indent,eol,start"
vim.opt.smartindent = true
vim.opt.expandtab = true
vim.opt.shiftwidth = 4
vim.opt.tabstop = 4

vim.opt.listchars:append("eol:↴")
vim.opt.listchars:append("space:⋅")
vim.opt.list = true

-- Misc
vim.opt.ambiwidth = "single"
vim.opt.autoread = true

vim.opt.conceallevel = 0
vim.opt.backup = false
vim.opt.completeopt = "menu,menuone,noselect"

vim.opt.hidden = true
vim.opt.shellcmdflag = "-ic"
vim.opt.showmode = true
vim.opt.swapfile = false
vim.opt.writebackup = false

vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
