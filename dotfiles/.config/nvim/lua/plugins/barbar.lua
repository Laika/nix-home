-- Move to previous/next
vim.keymap.set("n", "<A-,>", "<Cmd>BufferPrevious<CR>", { remap = false })
vim.keymap.set("n", "<A-.>", "<Cmd>BufferNext<CR>", { remap = false })
-- Re-order to previous/next
vim.keymap.set("n", "<A-<>", "<Cmd>BufferMovePrevious<CR>", { remap = false })
vim.keymap.set("n", "<A->>", "<Cmd>BufferMoveNext<CR>", { remap = false })
-- Goto buffer in position...
vim.keymap.set("n", "<A-1>", "<Cmd>BufferGoto 1<CR>", { remap = false })
vim.keymap.set("n", "<A-2>", "<Cmd>BufferGoto 2<CR>", { remap = false })
vim.keymap.set("n", "<A-3>", "<Cmd>BufferGoto 3<CR>", { remap = false })
vim.keymap.set("n", "<A-4>", "<Cmd>BufferGoto 4<CR>", { remap = false })
vim.keymap.set("n", "<A-5>", "<Cmd>BufferGoto 5<CR>", { remap = false })
vim.keymap.set("n", "<A-6>", "<Cmd>BufferGoto 6<CR>", { remap = false })
vim.keymap.set("n", "<A-7>", "<Cmd>BufferGoto 7<CR>", { remap = false })
vim.keymap.set("n", "<A-8>", "<Cmd>BufferGoto 8<CR>", { remap = false })
vim.keymap.set("n", "<A-9>", "<Cmd>BufferGoto 9<CR>", { remap = false })
vim.keymap.set("n", "<A-0>", "<Cmd>BufferLast<CR>", { remap = false })

-- Pin/unpin buffer
vim.keymap.set("n", "<A-p>", "<Cmd>BufferPin<CR>", { remap = false })
-- Close buffer
vim.keymap.set("", "<A-c>", "<Cmd>BufferClose<CR>", { remap = false })
-- Wipeout buffer
--                 :BufferWipeout
-- Close commands
--                 :BufferCloseAllButCurrent
--                 :BufferCloseAllButPinned
--                 :BufferCloseAllButCurrentOrPinned
--                 :BufferCloseBuffersLeft
--                 :BufferCloseBuffersRight
-- Magic buffer-picking mode
vim.keymap.set("n", "<C-p>", "<Cmd>BufferPick<CR>", { remap = false })
-- Sort automatically by...
vim.keymap.set("n", "<Leader>bb", "<Cmd>BufferCloseAllBufferNumber<CR>", { remap = false })
vim.keymap.set("n", "<Leader>bd", "<Cmd>BufferCloseAllDirectory<CR>", { remap = false })
vim.keymap.set("n", "<Leader>bl", "<Cmd>BufferCloseAllLanguage<CR>", { remap = false })
vim.keymap.set("n", "<Leader>bw", "<Cmd>BufferCloseAllWindowsNumber<CR>", { remap = false })

-- Other:
-- :BarbarEnable - enables barbar (enabled by default)
-- :BarbarDisable - very bad command, should never be used

return {
  "romgrk/barbar.nvim",
  dependencies = "nvim-web-devicons",
}
