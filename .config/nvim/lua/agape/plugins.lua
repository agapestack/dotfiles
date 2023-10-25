----------  PACKER  ----------
local ensure_packer = function()
	local fn = vim.fn
	local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
	if fn.empty(fn.glob(install_path)) > 0 then
		fn.system({ "git", "clone", "--depth", "1", "https://github.com/wbthomason/packer.nvim", install_path })
		vim.cmd([[packadd packer.nvim]])
		return true
	end
	return false
end

local packer_bootstrap = ensure_packer()

return require("packer").startup(function(use)
	-- PACKER
	use("wbthomason/packer.nvim")
	-- THEME sonokai
	use("sainnhe/sonokai")
	use("bronson/vim-trailing-whitespace")
	use("mhartington/formatter.nvim")
	use("tpope/vim-commentary")
	use("airblade/vim-gitgutter")
	use({ "jiangmiao/auto-pairs" })

	-- TREESITTER
	use("nvim-treesitter/nvim-treesitter", { run = ":TSUpdate" })
	-- TELESCOPE
	use({
		"nvim-telescope/telescope.nvim",
		tag = "0.1.2",
		requires = { { "nvim-lua/plenary.nvim" } },
	})

	-- BARBAR
	use("nvim-tree/nvim-web-devicons") -- OPTIONAL: for file icons
	use("lewis6991/gitsigns.nvim") -- OPTIONAL: for git status
	use("romgrk/barbar.nvim")

	-- Rust LSP configuration
	use("neovim/nvim-lspconfig")
	use("simrat39/rust-tools.nvim")
	use("nvim-lua/plenary.nvim")
	use("mfussenegger/nvim-dap")

	-- HOP
	use({
		"phaazon/hop.nvim",
		branch = "v2", -- optional but strongly recommended
		config = function()
			-- you can configure Hop the way you like here; see :h hop-config
			require("hop").setup({ keys = "etovxqpdygfblzhckisuran" })
		end,
	})

	-- NVIM TMUX
	use({ "alexghergh/nvim-tmux-navigation" })

	-- Automatically set up your configuration after cloning packer.nvim
	if packer_bootstrap then
		require("packer").sync()
	end
end)
