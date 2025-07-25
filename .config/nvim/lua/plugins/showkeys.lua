return {
	"nvzone/showkeys",

	keys = {
		{ "<Leader>uk", "<cmd>ShowkeysToggle<cr>", desc = "Toogle Showkeys", }
	},

	opts = {
		winopts = {
			focusable = false,
			relative = "editor",
			style = "minimal",
			border = "single",
			height = 1,
			row = 1,
			col = 0,
			zindex = 100,
		},

		--winhl = "FloatBorder:Comment,Normal:Normal",

		timeout = 5, -- in secs
		maxkeys = 5,
		show_count = false,
		excluded_modes = {}, -- example: {"i"}

		-- bottom-left, bottom-right, bottom-center, top-left, top-right, top-center
		position = "bottom-right",

		keyformat = {
			["<BS>"] = "󰁮 ",
			["<CR>"] = "󰘌",
			["<Space>"] = "󱁐",
			["<Tab>"] = "",
			["<Up>"] = "󰁝",
			["<Down>"] = "󰁅",
			["<Left>"] = "󰁍",
			["<Right>"] = "󰁔",
			["<PageUp>"] = "Pg 󰁝",
			["<PageDown>"] = "Pg 󰁅",
			["<M>"] = "󰘵",
			["<C>"] = "󰘴",
			["<S>"] = "󰘶",
		},
	}
}
