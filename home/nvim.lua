-- this file is a WIP
-- ideally, options will be in their own config
-- and plugins would be in their own folder
-- this is fine for now though

-- a little scary, but secure enough
vim.opt.exrc = true

vim.opt.showmode = false

vim.opt.shiftwidth = 4
vim.opt.expandtab = true

vim.opt.tabstop = 4

vim.g.mapleader = " "

vim.opt.numberwidth = 4
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.signcolumn = "yes"

vim.opt.swapfile = false

-- undos/redos are saved between sessions
vim.opt.undodir = vim.fn.stdpath("data") .. "/undodir"
vim.opt.undofile = true

vim.opt.clipboard = "unnamedplus"

vim.opt.smartcase = true
vim.opt.ignorecase = true

vim.opt.scrolloff = 8

vim.opt.splitbelow = true
vim.opt.splitright = true

vim.opt.shada = { "'10", "<0", "s10", "h" }

-- normal searches should not highlight the possible occurences
vim.opt.hlsearch = false
vim.opt.incsearch = true -- but substitution should

-- line breaks when wrapping text
vim.opt.linebreak = true

-- Basic movement keybinds, these make navigating splits easy for me
vim.keymap.set("n", "<c-j>", "<c-w><c-j>")
vim.keymap.set("n", "<c-k>", "<c-w><c-k>")
vim.keymap.set("n", "<c-l>", "<c-w><c-l>")
vim.keymap.set("n", "<c-h>", "<c-w><c-h>")

-- moving selected block around
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")
vim.keymap.set("v", "L", ">gv")
vim.keymap.set("v", "H", "<gv")

vim.keymap.set("n", ";", ":", { noremap = true })

vim.cmd.packadd("nvim.undotree")
vim.keymap.set("n", "<leader>u", "<CMD>Undotree<CR>", {})

vim.pack.add({
    "https://github.com/rebelot/kanagawa.nvim",
    "https://github.com/nvim-lua/plenary.nvim",
    "https://github.com/j-hui/fidget.nvim",
    -- "https://github.com/MeanderingProgrammer/render-markdown.nvim",

    require("plugin.harpoon").spec,
    require("plugin.treesitter").spec,
    require("plugin.oil").spec,
    require("plugin.supermaven").spec,

    { src = "https://github.com/saghen/blink.cmp", version = vim.version.range("^1.10") },
    -- best Git UI to ever exist
    { src = "https://github.com/tpope/vim-fugitive", version = vim.version.range("3") },
})

require("plugin.lspconfig")
require("plugin.mini")

vim.g.markdown_fenced_languages = {
    "ts=typescript"
}


require("plugin.languages.zig")
require("plugin.languages.go")
-- require("plugin.languages.vue")
require("plugin.languages.java")
require("plugin.languages.rust")
require("plugin.languages.c")
require("plugin.languages.javascript")
vim.lsp.enable('emmet_language_server')
vim.lsp.enable('bicep')
vim.lsp.enable("csharp-ls")

vim.cmd([[
colorscheme kanagawa
    hi DiagnosticUnderlineHint gui=underline
    hi DiagnosticUnderlineError gui=underline
    hi DiagnosticUnderlineWarn gui=underline
]])

vim.keymap.set("n", "<leader>pf", "<CMD>Pick files<CR>", {})
vim.keymap.set("n", "<leader>ps", "<CMD>Pick grep_live<CR>", {})
vim.keymap.set("n", "<leader>fb", "<CMD>Pick buffers<CR>", {})
vim.keymap.set("n", "<leader>fh", "<CMD>Pick help<CR>", {})

vim.keymap.set("n", "<leader>gs", "<CMD>0Git<CR>", {})

-- these plugins can chose to do lazy-loading or whatever themselves
require("plugin.treesitter").config()
require("plugin.harpoon").config()
require("plugin.oil").config()

require("fidget").setup()

vim.api.nvim_create_user_command("Plugins", function()
    for i, v in pairs(vim.pack.get()) do
        if v.active then
            vim.print(v.spec.name)
        else
            vim.print(string.format("%s INACTIVE", v.spec.name))
        end
    end
end, { desc = "List all the plugins" })

vim.api.nvim_create_user_command("PluginsPrune", function()
    local to_remove = {}

    for _, v in pairs(vim.pack.get()) do
        if not v.active then
            table.insert(to_remove, v.spec.name)
        end
    end

    if #to_remove > 0 then
        vim.pack.del(to_remove)
    end
end, { desc = "Prune inactive plugins" })

local capabilities = require("blink.cmp").get_lsp_capabilities()

-- vim.opt.winborder = 'rounded'
local orig_util_open_floating_preview = vim.lsp.util.open_floating_preview
function vim.lsp.util.open_floating_preview(contents, syntax, opts, ...)
    -- these can be overwritten by keymaps etc when calling the function
    opts = opts or {}

    opts.max_width = opts.max_width or 100
    opts.max_height = opts.max_height or 20

    -- none single double rounded solid shadow
    opts.border = opts.border or "rounded"

    return orig_util_open_floating_preview(contents, syntax, opts, ...)
end

local ie_lazy_grp = vim.api.nvim_create_augroup("LazyLoadInsertEnterBlink", { clear = true })
vim.api.nvim_create_autocmd("InsertEnter", {
    group = ie_lazy_grp,
    once = true,
    callback = function()
        require("blink.cmp").setup({
            keymap = {
                ['<C-j>'] = { 'snippet_forward', 'fallback' },
                ['<C-k>'] = { 'snippet_backward', 'fallback' },
            }
        })
    end,
})
-- require("blink.cmp").setup()

vim.keymap.set("i", "jj", "<Esc>", { noremap = true })

vim.keymap.set("n", "gd", vim.lsp.buf.definition)
vim.keymap.set("n", "gr", vim.lsp.buf.references)
vim.keymap.set("n", "gD", vim.lsp.buf.declaration)
vim.keymap.set("n", "gT", vim.lsp.buf.type_definition)
vim.keymap.set("n", "K", vim.lsp.buf.hover)

vim.keymap.set("n", "<space>ra", vim.lsp.buf.rename)
vim.keymap.set("n", "<space>ca", vim.lsp.buf.code_action)
vim.keymap.set("n", "<space>lf", vim.diagnostic.open_float)

vim.keymap.set("i", "<C-h>", vim.lsp.buf.signature_help)

vim.keymap.set("n", "[d", vim.diagnostic.goto_next)
vim.keymap.set("n", "]d", vim.diagnostic.goto_prev)
