-- Read the docs: https://www.lunarvim.org/docs/configuration
-- Example configs: https://github.com/LunarVim/starter.lvim
-- Video Tutorials: https://www.youtube.com/watch?v=sFA9kX-Ud_c&list=PLhoH5vyxr6QqGu0i7tt_XoVK9v-KvZ3m6
-- Forum: https://www.reddit.com/r/lunarvim/
-- Discord: https://discord.com/invite/Xb9B4Ny

------------------------
-- Treesitter
------------------------
lvim.builtin.treesitter.ensure_installed = {
    "php",
}

------------------------
-- Formatting
------------------------
local formatters = require "lvim.lsp.null-ls.formatters"
formatters.setup {
    { command = "phpcsfixer", filetypes = { "php" } },
}

lvim.format_on_save = {
    pattern = { "*.php" },
}
------------------------
-- Linting
------------------------
local linters = require "lvim.lsp.null-ls.linters"
linters.setup {
    { command = "phpcs", filetypes = { "php" } },
}

------------------------
-- LSP
------------------------
local lsp_manager = require("lvim.lsp.manager")
lsp_manager.setup("intelephense")


vim.opt.tabstop = 4
vim.o.shiftwidth = 4 -- Change the number of space characters inserted for indentation
vim.o.expandtab = true
