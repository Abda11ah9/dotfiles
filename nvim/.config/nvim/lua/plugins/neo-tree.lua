return {
	"nvim-tree/nvim-tree.lua",
	--	branch = "v3.x",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"MunifTanjim/nui.nvim",
		"nvim-tree/nvim-web-devicons", -- optional, but recommended
	},
	lazy = false, -- neo-tree will lazily load itself
	config = function()
		local nvimtree = require("nvim-tree")

		nvimtree.setup({
			sync_root_with_cwd = true,
			respect_buf_cwd = false,
			update_focused_file = {
				enable = true,
				update_root = false,
			},
			view = {
				side = "left",
				width = 35,
				preserve_window_proportions = true,
			},
			actions = {
				open_file = {
					quit_on_open = false,
					resize_window = true,
				},
			},
			renderer = {
				highlight_opened_files = "all",
			},
			git = { enable = false },
			tab = {
				sync = {
					open = false,
					close = false,
					ignore = {},
				},
			},
		})

		local keymap = vim.keymap
		keymap.set("n", "<C-n>", "<cmd>NvimTreeToggle<CR>", { desc = "Toggle file explorer" })
		keymap.set("n", "<leader>e", "<cmd>NvimTreeFocus<CR>", { desc = "Focus file explorer" })
	end,
}
