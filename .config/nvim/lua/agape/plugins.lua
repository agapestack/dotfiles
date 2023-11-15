----------  PACKER  ----------
local ensure_packer = function()
	local fn = vim.fn
	local install_path = fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'
	if fn.empty(fn.glob(install_path)) > 0 then
		fn.system({ 'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path })
		vim.cmd([[packadd packer.nvim]])
		return true
	end
	return false
end

local packer_bootstrap = ensure_packer()

return require('packer').startup(function(use)
	-- PACKER
	use('wbthomason/packer.nvim')
	-- THEME and basics utils (comments, auto-pairs...)
    use 'rebelot/kanagawa.nvim'
    use 'folke/tokyonight.nvim'
	use 'sainnhe/sonokai'
    use 'tanvirtin/monokai.nvim'
    use 'shaunsingh/nord.nvim'
	use 'bronson/vim-trailing-whitespace'
	use 'mhartington/formatter.nvim'
	use 'tpope/vim-commentary'
    -- use 'tpope/vim-surround'
    use 'machakann/vim-sandwich'
	use 'airblade/vim-gitgutter'
	use({ 'jiangmiao/auto-pairs' })

	-- TREESITTER
	use('nvim-treesitter/nvim-treesitter', { run = ':TSUpdate' })

	-- TELESCOPE
	use({
		'nvim-telescope/telescope.nvim',
		tag = '0.1.2',
		requires = { { 'nvim-lua/plenary.nvim' } },
	})

    -- FLOATTERM
    use 'voldikss/vim-floaterm'

	-- BARBAR
	use('nvim-tree/nvim-web-devicons') -- OPTIONAL: for file icons
	use('lewis6991/gitsigns.nvim') -- OPTIONAL: for git status
	use('romgrk/barbar.nvim')

    use {
        'nvim-tree/nvim-tree.lua',
        requires = {
            'nvim-tree/nvim-web-devicons', -- optional
        },
    }

    -- LSP
    use 'williamboman/mason.nvim'
    use 'williamboman/mason-lspconfig.nvim'
	use('neovim/nvim-lspconfig')
	use('simrat39/rust-tools.nvim')
	use('nvim-lua/plenary.nvim')
	use('mfussenegger/nvim-dap')
    -- Completion framework:
    use 'hrsh7th/nvim-cmp'
    -- LSP completion source:
    use 'hrsh7th/cmp-nvim-lsp'
    -- Useful completion sources:
    use 'hrsh7th/cmp-nvim-lua'
    use 'hrsh7th/cmp-nvim-lsp-signature-help'
    use 'hrsh7th/cmp-vsnip'
    use 'hrsh7th/cmp-path'
    use 'hrsh7th/cmp-buffer'
    use 'hrsh7th/vim-vsnip'
    use 'puremourning/vimspector'
    -- Neoterm
    use 'kassio/neoterm'

	-- HOP
	use({
		'phaazon/hop.nvim',
		branch = 'v2', -- optional but strongly recommended
		config = function()
			-- you can configure Hop the way you like here; see :h hop-config
			require('hop').setup({ keys = 'etovxqpdygfblzhckisuran' })
		end,
	})

	-- NVIM TMUX
	use({ 'alexghergh/nvim-tmux-navigation' })

    -- Markdown preview
    use({
        'iamcco/markdown-preview.nvim',
        run = function() vim.fn['mkdp#util#install']() end,
    })

    -- Automatically set up your configuration after cloning packer.nvim
	if packer_bootstrap then
		require('packer').sync()
	end
end)
