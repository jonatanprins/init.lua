require("vim._core.ui2").enable({ enable = true, msg = {
	target = "msg",
} })

vim.g.mapleader = " "
vim.g.maplocalleader = " "
vim.g.loaded_netrwplugin = 1
vim.g.loaded_netrw = 1

vim.loader.enable = true

vim.g.have_nerd_font = false

vim.o.number = true
vim.o.relativenumber = true

vim.o.mouse = "a"

vim.o.showmode = true

vim.schedule(function()
	vim.o.clipboard = "unnamedplus"
end)

vim.o.breakindent = true

vim.o.undofile = true

vim.o.ignorecase = true
vim.o.smartcase = true

vim.o.signcolumn = "yes"

vim.o.updatetime = 250

vim.o.timeoutlen = 300

vim.o.splitright = true
vim.o.splitbelow = true

vim.o.list = true
vim.opt.listchars = { tab = "» ", trail = "·", nbsp = "␣" }

vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true

vim.o.inccommand = "split"

vim.o.cursorline = false

vim.o.scrolloff = 10

vim.o.confirm = true

vim.keymap.set("n", "<c-f>", "<cmd>silent !tmux neww tmux-sessionizer<cr>")
vim.keymap.set("n", "<leader>p", function()
	vim.cmd([[oil]])
end)
vim.keymap.set("n", "<c-d>", "<c-d>zz")
vim.keymap.set("n", "<c-u>", "<c-u>zz")

vim.keymap.set("n", "<pageup>", "<pageup>m")
vim.keymap.set("n", "<pagedown>", "<pagedown>m")

vim.keymap.set("n", "<esc>", "<cmd>nohlsearch<cr>")

vim.diagnostic.config({
	update_in_insert = false,
	severity_sort = false,
	float = { border = "rounded", source = "if_many" },
	underline = { severity = vim.diagnostic.severity.error },

	virtual_text = true, -- text shows up at the end of the line
	virtual_lines = false, -- teest shows up underneath the line, with virtual lines

	jump = { float = true },
})

vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist, { desc = "open diagnostic [q]uickfix list" })

vim.keymap.set("t", "<esc><esc>", "<c-\\><c-n>", { desc = "exit terminal mode" })

vim.keymap.set("n", "<c-h>", "<c-w><c-h>", { desc = "move focus to the left window" })
vim.keymap.set("n", "<c-l>", "<c-w><c-l>", { desc = "move focus to the right window" })
vim.keymap.set("n", "<c-j>", "<c-w><c-j>", { desc = "move focus to the lower window" })
vim.keymap.set("n", "<c-k>", "<c-w><c-k>", { desc = "move focus to the upper window" })

vim.pack.add({
	{ src = "https://github.com/nvim-treesitter/nvim-treesitter" },
	{ src = "https://github.com/nvim-mini/mini.nvim" },
	{ src = "https://github.com/stevearc/oil.nvim" },
	{ src = "https://github.com/stevearc/conform.nvim" },
	{ src = "https://codeberg.org/comfysage/artio.nvim" },
	{ src = "https://github.com/mason-org/mason.nvim" },
	{ src = "https://github.com/whoissethdaniel/mason-tool-installer.nvim" },
	{ src = "https://github.com/saghen/blink.cmp" },
	{ src = "https://github.com/ibhagwan/fzf-lua" },
	{ src = "https://github.com/folke/flash.nvim" },
	{ src = "https://github.com/kylechui/nvim-surround" },
})

--setup artio
-- vim.keymap.set("n", "<leader><leader>", function()
-- 	require("artio.builtins").files({ findprg = "rg --files$*" })
-- end)

-- setup flash
require("flash").setup({
	-- labels = "abcdefghijklmnopqrstuvwxyz",
	labels = "asdfghjklqwertyuiopzxcvbnm",
	search = {
		-- search/jump in all windows
		multi_window = true,
		-- search direction
		forward = true,
		-- when `false`, find only matches in the given direction
		wrap = true,
		---@type Flash.Pattern.Mode
		-- Each mode will take ignorecase and smartcase into account.
		-- * exact: exact match
		-- * search: regular search
		-- * fuzzy: fuzzy search
		-- * fun(str): custom function that returns a pattern
		--   For example, to only match at the beginning of a word:
		--   mode = function(str)
		--     return "\\<" .. str
		--   end,
		mode = "exact",
		-- behave like `incsearch`
		incremental = false,
		-- Excluded filetypes and custom window filters
		---@type (string|fun(win:window))[]
		exclude = {
			"notify",
			"cmp_menu",
			"noice",
			"flash_prompt",
			function(win)
				-- exclude non-focusable windows
				return not vim.api.nvim_win_get_config(win).focusable
			end,
		},
		-- Optional trigger character that needs to be typed before
		-- a jump label can be used. It's NOT recommended to set this,
		-- unless you know what you're doing
		trigger = "",
		-- max pattern length. If the pattern length is equal to this
		-- labels will no longer be skipped. When it exceeds this length
		-- it will either end in a jump or terminate the search
		max_length = false, ---@type number|false
	},
	jump = {
		-- save location in the jumplist
		jumplist = true,
		-- jump position
		pos = "start", ---@type "start" | "end" | "range"
		-- add pattern to search history
		history = false,
		-- add pattern to search register
		register = false,
		-- clear highlight after jump
		nohlsearch = false,
		-- automatically jump when there is only one match
		autojump = false,
		-- You can force inclusive/exclusive jumps by setting the
		-- `inclusive` option. By default it will be automatically
		-- set based on the mode.
		inclusive = nil, ---@type boolean?
		-- jump position offset. Not used for range jumps.
		-- 0: default
		-- 1: when pos == "end" and pos < currentrposition
		offset = nil, ---@type number
	},
	label = {
		-- allow uppercase labels
		uppercase = true,
		-- add any labels with the correct case here, that you want to exclude
		exclude = "",
		-- add a label for the first match in the current window.
		-- you can always jump to the first match with `<CR>`
		current = true,
		-- show the label after the match
		after = true, ---@type boolean|number[]
		-- show the label before the match
		before = false, ---@type boolean|number[]
		-- position of the label extmark
		style = "overlay", ---@type "eol" | "overlay" | "right_align" | "inline"
		-- flash tries to re-use labels that were already assigned to a position,
		-- when typing more characters. By default only lower-case labels are re-used.
		reuse = "lowercase", ---@type "lowercase" | "all" | "none"
		-- for the current window, label targets closer to the cursor first
		distance = true,
		-- minimum pattern length to show labels
		-- Ignored for custom labelers.
		min_pattern_length = 0,
		-- Enable this to use rainbow colors to highlight labels
		-- Can be useful for visualizing Treesitter ranges.
		rainbow = {
			enabled = false,
			-- number between 1 and 9
			shade = 1,
		},
		-- With `format`, you can change how the label is rendered.
		-- Should return a list of `[text, highlight]` tuples.
		---@class Flash.Format
		---@field state Flash.State
		---@field match Flash.Match
		---@field hl_group string
		---@field after boolean
		---@type fun(opts:Flash.Format): string[][]
		format = function(opts)
			return { { opts.match.label, opts.hl_group } }
		end,
	},
	highlight = {
		-- show a backdrop with hl FlashBackdrop
		backdrop = true,
		-- Highlight the search matches
		matches = true,
		-- extmark priority
		priority = 5000,
		groups = {
			match = "FlashMatch",
			current = "FlashCurrent",
			backdrop = "FlashBackdrop",
			label = "FlashLabel",
		},
	},
	-- action to perform when picking a label.
	-- defaults to the jumping logic depending on the mode.
	---@type fun(match:Flash.Match, state:Flash.State)|nil
	action = nil,
	-- initial pattern to use when opening flash
	pattern = "",
	-- When `true`, flash will try to continue the last search
	continue = false,
	-- Set config to a function to dynamically change the config
	config = nil, ---@type fun(opts:Flash.Config)|nil
	-- You can override the default options for a specific mode.
	-- Use it with `require("flash").jump({mode = "forward"})`
	---@type table<string, Flash.Config>
	modes = {
		-- options used when flash is activated through
		-- a regular search with `/` or `?`
		search = {
			-- when `true`, flash will be activated during regular search by default.
			-- You can always toggle when searching with `require("flash").toggle()`
			enabled = false,
			highlight = { backdrop = false },
			jump = { history = true, register = true, nohlsearch = true },
			search = {
				-- `forward` will be automatically set to the search direction
				-- `mode` is always set to `search`
				-- `incremental` is set to `true` when `incsearch` is enabled
			},
		},
		-- options used when flash is activated through
		-- `f`, `F`, `t`, `T`, `;` and `,` motions
		char = {
			enabled = true,
			-- dynamic configuration for ftFT motions
			config = function(opts)
				-- autohide flash when in operator-pending mode
				opts.autohide = opts.autohide or (vim.fn.mode(true):find("no") and vim.v.operator == "y")

				-- disable jump labels when not enabled, when using a count,
				-- or when recording/executing registers
				opts.jump_labels = opts.jump_labels
					and vim.v.count == 0
					and vim.fn.reg_executing() == ""
					and vim.fn.reg_recording() == ""

				-- Show jump labels only in operator-pending mode
				-- opts.jump_labels = vim.v.count == 0 and vim.fn.mode(true):find("o")
			end,
			-- hide after jump when not using jump labels
			autohide = false,
			-- show jump labels
			jump_labels = false,
			-- set to `false` to use the current line only
			multi_line = true,
			-- When using jump labels, don't use these keys
			-- This allows using those keys directly after the motion
			label = { exclude = "hjkliardc" },
			-- by default all keymaps are enabled, but you can disable some of them,
			-- by removing them from the list.
			-- If you rather use another key, you can map them
			-- to something else, e.g., { [";"] = "L", [","] = H }
			keys = { "f", "F", "t", "T", ";", "," },
			---@alias Flash.CharActions table<string, "next" | "prev" | "right" | "left">
			-- The direction for `prev` and `next` is determined by the motion.
			-- `left` and `right` are always left and right.
			char_actions = function(motion)
				return {
					[";"] = "next", -- set to `right` to always go right
					[","] = "prev", -- set to `left` to always go left
					-- clever-f style
					[motion:lower()] = "next",
					[motion:upper()] = "prev",
					-- jump2d style: same case goes next, opposite case goes prev
					-- [motion] = "next",
					-- [motion:match("%l") and motion:upper() or motion:lower()] = "prev",
				}
			end,
			search = { wrap = false },
			highlight = { backdrop = true },
			jump = {
				register = false,
				-- when using jump labels, set to 'true' to automatically jump
				-- or execute a motion when there is only one match
				autojump = false,
			},
		},
		-- options used for treesitter selections
		-- `require("flash").treesitter()`
		treesitter = {
			labels = "abcdefghijklmnopqrstuvwxyz",
			jump = { pos = "range", autojump = true },
			search = { incremental = false },
			label = { before = true, after = true, style = "inline" },
			highlight = {
				backdrop = false,
				matches = false,
			},
		},
		treesitter_search = {
			jump = { pos = "range" },
			search = { multi_window = true, wrap = true, incremental = false },
			remote_op = { restore = true },
			label = { before = true, after = true, style = "inline" },
		},
		-- options used for remote flash
		remote = {
			remote_op = { restore = true, motion = true },
		},
	},
	-- options for the floating window that shows the prompt,
	-- for regular jumps
	-- `require("flash").prompt()` is always available to get the prompt text
	prompt = {
		enabled = true,
		prefix = { { "⚡", "FlashPromptIcon" } },
		win_config = {
			relative = "editor",
			border = "none",
			width = 1, -- when <=1 it's a percentage of the editor width
			height = 1,
			row = -1, -- when negative it's an offset from the bottom
			col = 0, -- when negative it's an offset from the right
			zindex = 1000,
		},
	},
	-- options for remote operator pending mode
	remote_op = {
		-- restore window views and cursor position
		-- after doing a remote operation
		restore = false,
		-- For `jump.pos = "range"`, this setting is ignored.
		-- `true`: always enter a new motion when doing a remote operation
		-- `false`: use the window's cursor position and jump target
		-- `nil`: act as `true` for remote windows, `false` for the current window
		motion = false,
	},
})
vim.keymap.set("n", "s", function()
	require("flash").jump()
end)
vim.keymap.set("n", "S", function()
	require("flash").treesitter()
end)

--setup treesitter
local ts_parsers = {
	"bash",
	"c",
	"dockerfile",
	"fish",
	"git_config",
	"git_rebase",
	"gitattributes",
	"gitcommit",
	"gitignore",
	"go",
	"gomod",
	"gosum",
	"html",
	"javascript",
	"json",
	"lua",
	"make",
	"markdown",
	"python",
	"rust",
	"sql",
	"toml",
	"tsx",
	"typescript",
	"typst",
	"vim",
	"yaml",
	"zig",
}
local nts = require("nvim-treesitter")

nts.install(ts_parsers)

local autocmd = vim.api.nvim_create_autocmd

require("conform").setup({
	notify_on_error = false,
	format_on_save = function(bufnr)
		local disable_filetypes = { c = true, cpp = true }
		if disable_filetypes[vim.bo[bufnr].filetype] then
			return nil
		else
			return {
				timeout_ms = 500,
				lsp_format = "fallback",
			}
		end
	end,
	formatters_by_ft = {
		lua = { "stylua" },
	},
})

vim.keymap.set("n", "<leader>f", function()
	require("conform").format({ async = true, lsp_format = "fallback" })
end)

require("mini.ai").setup({ n_lines = 500 })

local fzf_lua = require("fzf-lua")
fzf_lua.setup({
	{ "max-perf", "skim" },
	winopts = {
		row = 1,
		col = 0,
		width = 1,
		height = 1,
		-- uncomment to supress cmdline
		zindex = 200,
		title_pos = "left",
		toggle_behavior = "extend",
		border = function(_, m)
			assert(m.type == "nvim" and m.name == "fzf")
			-- { "╭", "─", "╮", "│", "╯", "─", "╰", "│" }
			local b = { "", "", "", "", "", "", "", "" }
			if m.layout == "down" then
				-- b[2] = "─"
				b[6] = "─"
			elseif m.layout == "up" then
				b[2] = "─"
			elseif m.layout == "left" then
				b[8] = "│"
			else -- right
				b[4] = "│"
			end
			return b
		end,
		preview = {
			layout = "vertical",
			vertical = "up:60%",
			-- title_pos = "right",
			winopts = { signcolumn = "yes" },
			border = function(_, m)
				if m.type == "fzf" then
					return "border-line"
				else
					if m.layout == "down" then
						-- uncomment for preview title
						-- return { "", "─", "", "", "", "", "", "" }
						return { "", "", "", "", "", "", "", "" }
					else
						return "none"
					end
				end
			end,
		},
	},
})
vim.keymap.set("n", "<leader><leader>", fzf_lua.files)
vim.keymap.set("n", "<leader>sg", fzf_lua.live_grep)
vim.keymap.set("n", "<leader>so", fzf_lua.oldfiles)
vim.keymap.set("n", "<leader>/", fzf_lua.grep_curbuf)

require("mason").setup()

local capabilities = require("blink.cmp").get_lsp_capabilities()

local servers = {}

local ensure_installed = vim.tbl_keys(servers or {})
vim.list_extend(ensure_installed, {
	"stylua", -- used to format lua code
})

require("mason-tool-installer").setup({ ensure_installed = ensure_installed })

require("blink.cmp").setup({
	keymap = {
		preset = "default",
	},

	completion = {
		documentation = { auto_show = false, auto_show_delay_ms = 500 },
	},

	sources = {
		default = { "lsp", "path", "buffer" },
	},

	-- snippets = { preset = "luasnip" },

	fuzzy = { implementation = "prefer_rust_with_warning" },

	signature = { enabled = true },
})

local function load_oil()
	require("oil").setup({
		default_file_explorer = true,
		delete_to_trash = true,
		skip_confirm_for_simple_edits = true,
		view_options = {
			show_hidden = true,
			natural_order = true,
			is_always_hidden = function(name, _)
				return name == ".." or name == ".git"
			end,
		},
		win_options = {
			wrap = true,
		},
	})
end

load_oil()

local function color_my_pencil()
	vim.cmd([[
       augroup transparentbackground
       autocmd!
       autocmd colorscheme * highlight normal ctermbg=none guibg=none
       autocmd colorscheme * highlight nontext ctermbg=none guibg=none
       augroup end
     ]])

	vim.cmd([[colorscheme catppuccin]])
end

color_my_pencil()

local last_cursor_group = vim.api.nvim_create_augroup("lastcursorgroup", {})
autocmd("bufreadpost", {
	group = last_cursor_group,
	callback = function()
		local mark = vim.api.nvim_buf_get_mark(0, '"')
		local lcount = vim.api.nvim_buf_line_count(0)
		if mark[1] > 0 and mark[1] <= lcount then
			pcall(vim.api.nvim_win_set_cursor, 0, mark)
		end
	end,
})

autocmd("cursormoved", {
	group = vim.api.nvim_create_augroup("auto-hlsearch", { clear = true }),
	callback = function()
		if vim.v.hlsearch == 1 and vim.fn.searchcount().exact_match == 0 then
			vim.schedule(function()
				vim.cmd.nohlsearch()
			end)
		end
	end,
})

autocmd("textyankpost", {
	desc = "highlight when yanking (copying) text",
	group = vim.api.nvim_create_augroup("kickstart-highlight-yank", { clear = true }),
	callback = function()
		vim.hl.on_yank()
	end,
})

autocmd("packchanged", {
	callback = function()
		nts.update()
	end,
})

autocmd("filetype", {
	callback = function(args)
		local filetype = args.match
		local lang = vim.treesitter.language.get_lang(filetype)
		if vim.treesitter.language.add(lang) then
			vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
			vim.treesitter.start()
		end
	end,
})

autocmd("bufenter", {
	callback = function()
		vim.o.formatoptions = vim.opt.formatoptions:remove({ "c", "r", "o" })
	end,
})
