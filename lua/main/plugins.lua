-- [[ Lazy.mvim ---> https://github.com/folke/lazy.nvim ]]

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable", -- latest stable release
        lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)

-- List of plugin strings
local plugins = {
    "nvim-treesitter/nvim-treesitter",
    {
        "nvim-telescope/telescope.nvim",
        dependencies = { { "nvim-lua/plenary.nvim" } }
    },

    -- Theme
    {
        "EdenEast/nightfox.nvim",
        -- Set the colorscheme on booting
        config = function() vim.cmd('colorscheme Carbonfox') end,
    },
    -- Markdown preview in browser
    {
        -- plugin to allow preview in browser when editing a markdown. -> :MarkdownPreview
        "iamcco/markdown-preview.nvim",
        build = function() vim.fn["mkdp#util#install"]() end,

    },
    -- LSP Zero plugin -> includes Mason
    {
        'VonHeikemen/lsp-zero.nvim',
        branch = 'v2.x',
        dependencies = {
            -- LSP Support
            { 'neovim/nvim-lspconfig' }, -- Required

            {                            -- Optional
                'williamboman/mason.nvim',
                build = function()
                    pcall(vim.cmd, 'MasonUpdate')
                end,
            },
            { 'williamboman/mason-lspconfig.nvim' }, -- Optional

            -- Autocompletion
            { 'hrsh7th/nvim-cmp' },     -- Required
            { 'hrsh7th/cmp-nvim-lsp' }, -- Required
            { 'L3MON4D3/LuaSnip' },     -- Required
        }
    },
    -- Undo tree plugin to have a small history of changes
    'mbbill/undotree',
    -- Git visualiser
    'tpope/vim-fugitive',
}
-- options
local opts = {

}
-- setup lazy, passing pluggin list and options
require("lazy").setup(plugins, opts)

-- Telescope configuration
require('after.plugins_config.telescope')
require('after.plugins_config.treesitter')
require('after.plugins_config.lspzero')
require('after.plugins_config.undotree')
require('after.plugins_config.fugitive')
