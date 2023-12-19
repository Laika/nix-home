vim.g.mapleader = " "
vim.g.maplocalleader = " "

vim.keymap.set("n", ";", ":", { remap = false })

vim.keymap.set("n", "WQ", ":wq<Enter>", { remap = false })
vim.keymap.set("n", "WW", ":w<Enter>", { remap = false })
vim.keymap.set("n", "QQ", ":q!<Enter>", { remap = false })

vim.keymap.set("i", "<C-c>", "<Esc>", { remap = false })
vim.keymap.set("c", "w!!", "w !sudo -S tee >/dev/null %", { remap = false })
vim.keymap.set("n", "x", '"_x', { remap = false })

vim.keymap.set("n", "<Leader>a", "0", { remap = false })
vim.keymap.set("n", "<Leader>;", "$", { remap = false })

vim.keymap.set("n", "j", "gj", { remap = false })
vim.keymap.set("n", "k", "gk", { remap = false })
vim.keymap.set("v", "j", "gj", { remap = false })
vim.keymap.set("v", "k", "gk", { remap = false })
vim.keymap.set("n", "gj", "j", { remap = false })
vim.keymap.set("n", "gk", "k", { remap = false })
vim.keymap.set("v", "gj", "j", { remap = false })
vim.keymap.set("v", "gk", "k", { remap = false })

vim.keymap.set("v", "<", "<gv", { remap = false })
vim.keymap.set("v", ">", ">gv", { remap = false })
vim.keymap.set("v", "v", "$h", { remap = false })
