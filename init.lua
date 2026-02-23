vim.g.mapleader = " " 
vim.g.maplocalleader = " " 

vim.opt.swapfile = false
vim.opt.relativenumber = true
vim.opt.number = true
vim.opt.cursorline = false

vim.opt.tabstop = 4 -- Tab width
vim.opt.shiftwidth = 4 -- Indent width
vim.opt.softtabstop = 4 -- Soft tab stop
vim.opt.expandtab = true -- Use spaces instead of tabs
vim.opt.smartindent = true -- Smart auto-indenting
vim.opt.autoindent = true -- Copy indent from current line
vim.opt.grepprg = "rg --vimgrep" -- Use ripgrep if available

vim.opt.laststatus = 3

vim.opt.termguicolors = true

vim.opt.scrolloff = 4
vim.opt.sidescrolloff = 4

-- Set undo directory and ensure it exists
local undodir = "~/.local/share/nvim/undodir" -- Undo directory path
vim.opt.undodir = vim.fn.expand(undodir) -- Expand to full path
local undodir_path = vim.fn.expand(undodir)
if vim.fn.isdirectory(undodir_path) == 0 then
    vim.fn.mkdir(undodir_path, "p") -- Create if not exists
end


vim.opt.undofile = true

vim.opt.errorbells = false -- Disable error sounds
vim.opt.backspace = "indent,eol,start" -- Make backspace behave naturally
vim.opt.autochdir = false -- Don't change directory automatically
vim.opt.iskeyword:append("-") -- Treat dash as part of a word
vim.opt.path:append("**") -- Search into subfolders with `gf`
vim.opt.selection = "inclusive" -- Use inclusive selection

vim.o.ignorecase = true
vim.o.smartcase = true

vim.o.signcolumn = 'yes'

vim.o.updatetime = 250

vim.o.timeoutlen = 1000

vim.o.inccommand = 'split'

vim.o.splitright = true
vim.o.splitbelow = true

vim.opt.guicursor = {
    "n-v-c:block-Cursor/lCursor", 
    "i-ci-ve:block-iCursor",      
    "r-cr:hor20-rCursor",         
    "o:hor50-oCursor",            
    "a:blinkon100",               
}

require("vim._core.ui2").enable({ enable = true, msg = {
    target = "msg",
} })

vim.pack.add({
    { src = "https://github.com/nvim-treesitter/nvim-treesitter" },
    { src = "https://codeberg.org/comfysage/artio.nvim" },
    { src = "https://github.com/rose-pine/neovim" },
    { src = "https://github.com/saghen/blink.cmp" },
    -- { src = "https://github.com/ibhagwan/fzf-lua" },
})

require'blink.cmp'.setup({
    keymap = { preset = 'default' },

    appearance = {
        -- 'mono' (default) for 'Nerd Font Mono' or 'normal' for 'Nerd Font'
        -- Adjusts spacing to ensure icons are aligned
        nerd_font_variant = 'mono'
    },

    -- (Default) Only show the documentation popup when manually triggered
    completion = { documentation = { auto_show = true } },

    -- Default list of enabled providers defined so that you can extend it
    -- elsewhere in your config, without redefining it, due to `opts_extend`
    sources = {
        default = { 'lsp', 'path', 'snippets', 'buffer' },
    },

    -- (Default) Rust fuzzy matcher for typo resistance and significantly better performance
    -- You may use a lua implementation instead by using `implementation = "lua"` or fallback to the lua implementation,
    -- when the Rust fuzzy matcher is not available, by using `implementation = "prefer_rust"`
    --
    -- See the fuzzy documentation for more information
    fuzzy = { implementation = "prefer_rust_with_warning" }
})

require'nvim-treesitter'.setup {
    install_dir = vim.fn.stdpath('data') .. '/site'
}

local function init_treesitter()
    local filetypes = { 'bash', 'c', 'diff', 'html', 'lua', 'luadoc', 'markdown', 'markdown_inline', 'query', 'vim', 'vimdoc' }
    require('nvim-treesitter').install(filetypes)
    vim.api.nvim_create_autocmd('FileType', {
        pattern = filetypes,
        callback = function() vim.treesitter.start() end,
    })
end

init_treesitter()

--
-- local fzf_lua = require("fzf-lua")
-- fzf_lua.setup({
--   { "max-perf", "ivy" },
-- })
--
-- vim.keymap.set("n", "<leader><leader>", fzf_lua.files)
-- vim.keymap.set("n", "<leader>fg", fzf_lua.live_grep)
-- vim.keymap.set("n", "<leader>fo", fzf_lua.oldfiles)
-- vim.keymap.set("n", "<leader>f/", fzf_lua.grep_curbuf)

-- vim.keymap.set("n", "<leader>ff", "<Plug>(artio-smart)")
-- vim.keymap.set("n", "<leader>fh", "<Plug>(artio-helptags)")
-- vim.keymap.set("n", "<leader>fb", "<Plug>(artio-buffers)")
-- vim.keymap.set("n", "<leader>f/", "<Plug>(artio-buffergrep)")
-- vim.keymap.set("n", "<leader>fo", "<Plug>(artio-oldfiles)")


require("artio").setup({
    opts = {
        preselect = true, 
        bottom = true, 
        shrink = true, 
        promptprefix = "", 
        prompt_title = true, 
        pointer = "", 
        marker = "│", 
        infolist = { "list" }, 
        use_icons = false, 
    },
    win = {
        height = 12,
        hidestatusline = false, 
    },
    -- NOTE: if you override the mappings, make sure to provide keys for all actions
    mappings = {
        ["<down>"] = "down",
        ["<up>"] = "up",
        ["<cr>"] = "accept",
        ["<esc>"] = "cancel",
        ["<tab>"] = "mark",
        ["<c-g>"] = "togglelive",
        ["<c-l>"] = "togglepreview",
        ["<c-q>"] = "setqflist",
        ["<m-q>"] = "setqflistmark",
    },
})

vim.ui.select = require("artio").select

vim.keymap.set("n", "<leader><leader>", "<Plug>(artio-files)")
vim.keymap.set("n", "<leader>fg", "<Plug>(artio-grep)")
vim.keymap.set("n", "<leader>ff", "<Plug>(artio-smart)")
vim.keymap.set("n", "<leader>fh", "<Plug>(artio-helptags)")
vim.keymap.set("n", "<leader>fb", "<Plug>(artio-buffers)")
vim.keymap.set("n", "<leader>f/", "<Plug>(artio-buffergrep)")
vim.keymap.set("n", "<leader>fo", "<Plug>(artio-oldfiles)")



vim.keymap.set("n", "<PageUp>", "<C-u>zz")
vim.keymap.set("n", "<PageDown>", "<C-d>zz")

vim.keymap.set("n", "<C-u>", "<C-u>zz")
vim.keymap.set("n", "<C-d>", "<C-d>zz")

require("rose-pine").setup({
    variant = "auto", 
    dark_variant = "main", 
    dim_inactive_windows = false,
    extend_background_behind_borders = true,

    enable = {
        terminal = true,
        legacy_highlights = false, 
        migrations = true, 
    },

    styles = {
        bold = true,
        italic = false,
        transparency = true,
    },

})

vim.api.nvim_create_autocmd('TextYankPost', {
    desc = 'Highlight when yanking (copying) text',
    group = vim.api.nvim_create_augroup('highlight-yank', { clear = true }),
    callback = function() vim.hl.on_yank() end,
})

vim.api.nvim_create_autocmd("CursorMoved", {
    group = vim.api.nvim_create_augroup("auto-hlsearch", { clear = true }),
    callback = function()
        if vim.v.hlsearch == 1 and vim.fn.searchcount().exact_match == 0 then
            vim.schedule(function()
                vim.cmd.nohlsearch()
            end)
        end
    end,
})

function color_my_pencil()
    vim.cmd[[colorscheme rose-pine-main]]
    vim.api.nvim_set_hl(0, "Cursor", { bg = "#e0def4" })
    vim.api.nvim_set_hl(0, "iCursor", { bg = "#00ff00" })
end

vim.schedule(color_my_pencil)


-- Restore last cursor position when reopening a file
local last_cursor_group = vim.api.nvim_create_augroup("LastCursorGroup", {})
vim.api.nvim_create_autocmd("BufReadPost", {
    group = last_cursor_group,
    callback = function()
        local mark = vim.api.nvim_buf_get_mark(0, '"')
        local lcount = vim.api.nvim_buf_line_count(0)
        if mark[1] > 0 and mark[1] <= lcount then
            pcall(vim.api.nvim_win_set_cursor, 0, mark)
        end
    end,
})

