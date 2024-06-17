local cmp_status_ok, cmp = pcall(require, "cmp")
if not cmp_status_ok then
	return
end

local snip_status_ok, luasnip = pcall(require, "luasnip")
if not snip_status_ok then
	return
end

require("luasnip/loaders/from_vscode").lazy_load()

local check_backspace = function()
	local col = vim.fn.col(".") - 1
	return col == 0 or vim.fn.getline("."):sub(col, col):match("%s")
end

--   פּ ﯟ   some other good icons
-- local kind_icons = {
-- 	Text = "",
-- 	Method = "m",
-- 	Function = "",
-- 	Constructor = "",
-- 	Field = "",
-- 	Variable = "",
-- 	Class = "",
-- 	Interface = "",
-- 	Module = "",
-- 	Property = "",
-- 	Unit = "",
-- 	Value = "",
-- 	Enum = "",
-- 	Keyword = "",
-- 	Snippet = "",
-- 	Color = "",
-- 	File = "",
-- 	Reference = "",
-- 	Folder = "",
-- 	EnumMember = "",
-- 	Constant = "",
-- 	Struct = "",
-- 	Event = "",
-- 	Operator = "",
-- 	TypeParameter = "",
-- }
-- find more here: https://www.nerdfonts.com/cheat-sheet
local new_kind_icon = {
	kind = {
		Array = "",
		Boolean = "",
		Class = "",
		Color = "",
		Constant = "",
		Constructor = "",
		Enum = "",
		EnumMember = "",
		Event = "",
		Field = "",
		File = "",
		Folder = "",
		Function = "",
		Interface = "",
		Key = "",
		Keyword = "",
		Method = "",
		Module = "",
		Namespace = "",
		Null = "ﳠ",
		Number = "",
		Object = "",
		Operator = "",
		Package = "",
		Property = "",
		Reference = "",
		Snippet = "",
		String = "",
		Struct = "",
		Text = "",
		TypeParameter = "",
		Unit = "",
		Value = "",
		Variable = "",
	},
	git = {
		LineAdded = "",
		LineModified = "",
		LineRemoved = "",
		FileDeleted = "",
		FileIgnored = "◌",
		FileRenamed = "",
		FileStaged = "S",
		FileUnmerged = "",
		FileUnstaged = "",
		FileUntracked = "U",
		Diff = "",
		Repo = "",
		Octoface = "",
		Branch = "",
	},
	ui = {
		ArrowCircleDown = "",
		ArrowCircleLeft = "",
		ArrowCircleRight = "",
		ArrowCircleUp = "",
		BoldArrowDown = "",
		BoldArrowLeft = "",
		BoldArrowRight = "",
		BoldArrowUp = "",
		BoldClose = "",
		BoldDividerLeft = "",
		BoldDividerRight = "",
		BoldLineLeft = "▎",
		BookMark = "",
		BoxChecked = "",
		Bug = "",
		Stacks = "",
		Scopes = "",
		Watches = "",
		DebugConsole = "",
		Calendar = "",
		Check = "",
		ChevronRight = ">",
		ChevronShortDown = "",
		ChevronShortLeft = "",
		ChevronShortRight = "",
		ChevronShortUp = "",
		Circle = "",
		Close = "",
		CloudDownload = "",
		Code = "",
		Comment = "",
		Dashboard = "",
		DividerLeft = "",
		DividerRight = "",
		DoubleChevronRight = "»",
		Ellipsis = "",
		EmptyFolder = "",
		EmptyFolderOpen = "",
		File = "",
		FileSymlink = "",
		Files = "",
		FindFile = "",
		FindText = "",
		Fire = "",
		Folder = "",
		FolderOpen = "",
		FolderSymlink = "",
		Forward = "",
		Gear = "",
		History = "",
		Lightbulb = "",
		LineLeft = "▏",
		LineMiddle = "│",
		List = "",
		Lock = "",
		NewFile = "",
		Note = "",
		Package = "",
		Pencil = "",
		Plus = "",
		Project = "",
		Search = "",
		SignIn = "",
		SignOut = "",
		Tab = "",
		Table = "",
		Target = "",
		Telescope = "",
		Text = "",
		Tree = "",
		Triangle = "契",
		TriangleShortArrowDown = "",
		TriangleShortArrowLeft = "",
		TriangleShortArrowRight = "",
		TriangleShortArrowUp = "",
	},
	diagnostics = {
		BoldError = "",
		Error = "",
		BoldWarning = "",
		Warning = "",
		BoldInformation = "",
		Information = "",
		BoldQuestion = "",
		Question = "",
		BoldHint = "",
		Hint = "",
		Debug = "",
		Trace = "✎",
	},
	misc = {
		Robot = "ﮧ",
		Squirrel = "",
		Tag = "",
		Watch = "",
		Smiley = "",
		Package = "",
		CircuitBoard = "",
	},
}

cmp.setup({
	snippet = {
		expand = function(args)
			luasnip.lsp_expand(args.body) -- For `luasnip` users.
		end,
	},
	mapping = {
		["<Up>"] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Select }),
		["<Down>"] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Select }),
		["<C-k>"] = cmp.mapping.select_prev_item(),
		["<C-j>"] = cmp.mapping.select_next_item(),
		["<C-b>"] = cmp.mapping(cmp.mapping.scroll_docs(-1), { "i", "c" }),
		["<C-f>"] = cmp.mapping(cmp.mapping.scroll_docs(1), { "i", "c" }),
		["<C-Space>"] = cmp.mapping(cmp.mapping.complete(), { "i", "c" }),
		["<C-y>"] = cmp.config.disable, -- Specify `cmp.config.disable` if you want to remove the default `<C-y>` mapping.
		["<C-e>"] = cmp.mapping({
			i = cmp.mapping.abort(),
			c = cmp.mapping.close(),
		}),
		-- Accept currently selected item. If none selected, `select` first item.
		-- Set `select` to `false` to only confirm explicitly selected items.
		["<CR>"] = cmp.mapping.confirm({ select = true }),
		["<Tab>"] = cmp.mapping(function(fallback)
			if cmp.visible() then
				cmp.select_next_item()
			elseif luasnip.expandable() then
				luasnip.expand()
			elseif luasnip.expand_or_jumpable() then
				luasnip.expand_or_jump()
			elseif check_backspace() then
				fallback()
			else
				fallback()
			end
		end, {
			"i",
			"s",
		}),
		["<S-Tab>"] = cmp.mapping(function(fallback)
			if cmp.visible() then
				cmp.select_prev_item()
			elseif luasnip.jumpable(-1) then
				luasnip.jump(-1)
			else
				fallback()
			end
		end, {
			"i",
			"s",
		}),
	},
	formatting = {
		fields = { "kind", "abbr", "menu" },
		format = function(entry, vim_item)
			-- Kind icons
			-- vim_item.kind = string.format("%s", kind_icons[vim_item.kind])
			vim_item.kind = string.format("%s", new_kind_icon["kind"][vim_item.kind])
			-- vim_item.kind = string.format('%s %s', kind_icons[vim_item.kind], vim_item.kind) -- This concatonates the icons with the name of the item kind
			vim_item.menu = ({
				-- nvim_lsp = "[LSP]",
				-- luasnip = "[Snippet]",
				-- buffer = "[Buffer]",
				-- path = "[Path]",
				nvim_lsp = "(LSP)",
				luasnip = "(Snippet)",
				buffer = "(Buffer)",
				path = "(Path)",
			})[entry.source.name]
			return vim_item
		end,
	},
	sources = {
		{ name = "nvim_lsp" },
		{ name = "luasnip" },
		{ name = "buffer" },
		{ name = "path" },
	},
	confirm_opts = {
		behavior = cmp.ConfirmBehavior.Replace,
		select = false,
	},
	window = {
		completion = cmp.config.window.bordered(),
		documentation = cmp.config.window.bordered(),
		-- documentation = {
		-- 	border = { "╭", "─", "╮", "│", "╯", "─", "╰", "│" },
		-- },
	},
	experimental = {
		ghost_text = false,
		native_menu = false,
	},
})
