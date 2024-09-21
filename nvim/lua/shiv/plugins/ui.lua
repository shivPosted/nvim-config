return {
	{
		"folke/noice.nvim",
		opts = function(_, opts)
			-- Ensure opts.routes is initialized as a table
			opts.routes = opts.routes or {}

			-- Now safely insert routes
			table.insert(opts.routes, {
				filter = {
					event = "notify",
					find = "No information available",
				},
				opts = { skip = true },
				routes = {
					{
						view = "notify",
						filter = { event = "msg_showmode" },
					},
				},
			})

			-- Focus handling logic
			local focused = true
			vim.api.nvim_create_autocmd("FocusGained", {
				callback = function()
					focused = true
				end,
			})
			vim.api.nvim_create_autocmd("FocusLost", {
				callback = function()
					focused = false
				end,
			})

			-- Ensure opts.routes is still a table and insert a new route
			table.insert(opts.routes, 1, {
				filter = {
					cond = function()
						return not focused
					end,
				},
				view = "notify_send",
				opts = { stop = false },
			})

			-- Ensure opts.commands is initialized
			opts.commands = opts.commands or {}
			opts.commands.all = {
				-- Options for the message history
				view = "split",
				filter = {},
				opts = { enter = true, format = "details" },
			}

			-- Handle markdown FileType
			vim.api.nvim_create_autocmd("FileType", {
				pattern = "markdown",
				callback = function(event)
					vim.schedule(function()
						require("noice.text.markdown").keys(event.buf)
					end)
				end,
			})

			-- Enable LSP doc border preset
			opts.presets = opts.presets or {}
			opts.presets.lsp_doc_border = true
		end,
	},

	-- {
	-- 	"rcarriga/nvim-notify",
	-- 	opts = {
	-- 		timeout = 5000,
	-- 	},
	-- },
	--animations
	-- {
	-- 	"echasnovski/mini.animate",
	-- 	event = "VeryLazy",
	-- 	opts = function(_, opts)
	-- 		opts.scroll = {
	-- 			enable = false,
	-- 		}
	-- 	end,
	-- },

	-- buffer line
	{
		"akinsho/bufferline.nvim",
		event = "VeryLazy",
		keys = {
			{ "<Tab>", "<Cmd>BufferLineCycleNext<CR>", desc = "Next tab" },
			{ "<S-Tab>", "<Cmd>BufferLineCyclePrev<CR>", desc = "Prev tab" },
		},
		opts = {
			options = {
				mode = "tabs",
				separator_style = "slant",
				show_buffer_close_icons = false,
				show_close_icon = false,
			},
		},
	},

	-- filename
	{
		"b0o/incline.nvim",
		dependencies = { "craftzdog/solarized-osaka.nvim" },
		event = "BufReadPre",
		priority = 1200,
		config = function()
			local colors = require("solarized-osaka.colors").setup()
			require("incline").setup({
				highlight = {
					groups = {
						InclineNormal = { guibg = colors.orange100, guifg = colors.base04 },
						InclineNormalNC = { guifg = colors.violet700, guibg = colors.base03 },
					},
				},
				window = { margin = { vertical = 0, horizontal = 1 } },
				hide = {
					cursorline = true,
				},
				render = function(props)
					local filename = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(props.buf), ":t")
					if vim.bo[props.buf].modified then
						filename = "[+] " .. filename
					end

					local icon, color = require("nvim-web-devicons").get_icon_color(filename)
					return { { icon, guifg = color }, { " " }, { filename } }
				end,
			})
		end,
	},
}
