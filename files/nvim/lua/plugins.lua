-- Update after anything changes
--

return require('lazy').setup({
      -- '~/projects/mine/git-browse-nvim'
    { "Morozzzko/git_browse.nvim" },

    { 'catppuccin/nvim', as = "catppuccin" } ,-- colorscheme
-- {'williamboman/mason.nvim'},
-- {'williamboman/mason-lspconfig.nvim'},

    {'williamboman/mason.nvim'},
    {'williamboman/mason-lspconfig.nvim'},
    {'VonHeikemen/lsp-zero.nvim', branch = 'v3.x', config = require('plugins.lsp-zero')},
    {'neovim/nvim-lspconfig'},
    {'hrsh7th/nvim-cmp'},
    {'hrsh7th/cmp-nvim-lsp'},
    {'hrsh7th/cmp-buffer'},
    {'hrsh7th/cmp-path'},
    {'hrsh7th/cmp-nvim-lua'},
    {'L3MON4D3/LuaSnip'},
    -- {
    --     'VonHeikemen/lsp-zero.nvim',
    --     dependencies =  {
    --       -- LSP Support
    --       {'neovim/nvim-lspconfig'},
    --       {'williamboman/mason.nvim'},
    --       {'williamboman/mason-lspconfig.nvim'},

    --       -- Autocompletion
    --       {'hrsh7th/nvim-cmp'},
    --       {'hrsh7th/cmp-buffer'},
    --       {'hrsh7th/cmp-path'},
    --       {'saadparwaiz1/cmp_luasnip'},
    --       {'hrsh7th/cmp-nvim-lsp'},
    --       {'hrsh7th/cmp-nvim-lua'},

    --       -- Snippets
    --       {'L3MON4D3/LuaSnip'},
    --       -- Snippet Collection (Optional)
    --       {'rafamadriz/friendly-snippets'},
    --     },
    --     config = require('plugins.lsp-zero')
    -- },

    {
      "zbirenbaum/copilot.lua",
      cmd = "Copilot",
      event = "InsertEnter",
      config = function()
        require("copilot").setup({
          -- suggestion = { enabled = false },
          -- panel = { enabled = false },
        })
      end,
    },
    {
      "zbirenbaum/copilot-cmp",
      config = function ()
        require("copilot_cmp").setup()
      end
    },

    {
      "nvim-neo-tree/neo-tree.nvim",
        branch = "v2.x",
        dependencies =  {
          "nvim-lua/plenary.nvim",
          "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
          "MunifTanjim/nui.nvim",
        },
        config = require('plugins.neo-tree')
    },
    { 'junegunn/fzf' } ,
    { 'junegunn/fzf.vim' } ,

    {
      'nvim-telescope/telescope.nvim',
      dependencies =  {
        'nvim-lua/popup.nvim',
        'nvim-lua/plenary.nvim',
        'BurntSushi/ripgrep',
        { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
        { 'nvim-telescope/telescope-live-grep-args.nvim' }
      },
      config = require('plugins.nvim-telescope')
    },

     {'tpope/vim-commentary' },-- Comment lines using gc

    {
        'nvim-lualine/lualine.nvim',
        dependencies =  { 'kyazdani42/nvim-web-devicons', opt = true }
      },

    {
      'akinsho/git-conflict.nvim',
      tag = "v1.2.2",
      config = function()
        require('git-conflict').setup()
      end
    },

    -- {
    --   'lukas-reineke/indent-blankline.nvim',
    --   tag = "v2.20.8",
    --   config = function()
    --     require("indent_blankline").setup {
    --         show_current_context = true,
    --         show_current_context_start = true,
    --     }
    --   end
    -- },


    {
      'nvim-treesitter/nvim-treesitter',
      run = ':TSUpdate',
      config = require('plugins.nvim-treesitter')
    },
    {
      'David-Kunz/treesitter-unit', 
      config = function()
        vim.api.nvim_set_keymap('x', 'iu', ':lua require"treesitter-unit".select()<CR>', {noremap=true})
        vim.api.nvim_set_keymap('x', 'au', ':lua require"treesitter-unit".select(true)<CR>', {noremap=true})
        vim.api.nvim_set_keymap('o', 'iu', ':<c-u>lua require"treesitter-unit".select()<CR>', {noremap=true})
        vim.api.nvim_set_keymap('o', 'au', ':<c-u>lua require"treesitter-unit".select(true)<CR>', {noremap=true})
      end
    },

    -- autoclose tag
    {
      'windwp/nvim-ts-autotag',
      dependencies =  { 'nvim-treesitter/nvim-treesitter' },
      config = function() 
        -- require('nvim-ts-autotag').setup() 
      end
    },
    
    
    {
      "cshuaimin/ssr.nvim",
      module = "ssr",
      -- Calling setup is optional.
      config = function()
        require("ssr").setup {
          min_width = 50,
          min_height = 5,
          keymaps = {
            close = "q",
            next_match = "n",
            prev_match = "N",
            replace_confirm = "<cr>",
            replace_all = "<leader><cr>",
          },
        }
      end
    },

    { 'aymericbeaumet/vim-symlink', dependencies =  { 'moll/vim-bbye' } },

    { "lukas-reineke/lsp-format.nvim" },

  -- config = {
  --   enable = true,
  --   -- log = { level = 'debug' },
  --   display = {
  --     open_fn = require "packer.util".float
  --   }
  -- }
})
