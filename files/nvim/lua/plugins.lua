-- Update after anything changes

vim.api.nvim_create_autocmd("BufWritePost", { pattern = "plugins.lua", command = "source <afile> | PackerSync" })

return require('packer').startup({
  function(use)
      -- use '~/projects/mine/git-browse-nvim'
      use { "Morozzzko/git_browse.nvim" }
      use 'wbthomason/packer.nvim'

      use { 'catppuccin/nvim', as = "catppuccin" } -- colorscheme

      use {
          'VonHeikemen/lsp-zero.nvim',
          requires = {
            -- LSP Support
            {'neovim/nvim-lspconfig'},
            {'williamboman/mason.nvim'},
            {'williamboman/mason-lspconfig.nvim'},

            -- Autocompletion
            {'hrsh7th/nvim-cmp'},
            {'hrsh7th/cmp-buffer'},
            {'hrsh7th/cmp-path'},
            {'saadparwaiz1/cmp_luasnip'},
            {'hrsh7th/cmp-nvim-lsp'},
            {'hrsh7th/cmp-nvim-lua'},

            -- Snippets
            {'L3MON4D3/LuaSnip'},
            -- Snippet Collection (Optional)
            {'rafamadriz/friendly-snippets'},
          },
          config = require('plugins.lsp-zero')
      }

      use {
        "zbirenbaum/copilot.lua",
        cmd = "Copilot",
        event = "InsertEnter",
        config = function()
          require("copilot").setup({
            -- suggestion = { enabled = false },
            -- panel = { enabled = false },
          })
        end,
      }
      use {
        "zbirenbaum/copilot-cmp",
        after = { "copilot.lua" },
        config = function ()
          require("copilot_cmp").setup()
        end
      }

      use {
        "nvim-neo-tree/neo-tree.nvim",
          branch = "v2.x",
          requires = {
            "nvim-lua/plenary.nvim",
            "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
            "MunifTanjim/nui.nvim",
          },
          config = require('plugins.neo-tree')
        }
      use 'junegunn/fzf.vim'

      use {
        'nvim-telescope/telescope.nvim',
        requires = {
          'nvim-lua/popup.nvim',
          'nvim-lua/plenary.nvim',
          'BurntSushi/ripgrep',
          { 'nvim-telescope/telescope-fzf-native.nvim', run = 'make' },
          { 'nvim-telescope/telescope-live-grep-args.nvim' }
        },
        config = require('plugins.nvim-telescope')
      }

      use 'tpope/vim-commentary' -- Comment lines using gc

      use {
          'nvim-lualine/lualine.nvim',
          requires = { 'kyazdani42/nvim-web-devicons', opt = true }
        }

      use {
        'akinsho/git-conflict.nvim',
        tag = "*",
        config = function()
          require('git-conflict').setup()
        end
      }

      use {
        'lukas-reineke/indent-blankline.nvim',
        config = function()
          require("indent_blankline").setup {
              show_current_context = true,
              show_current_context_start = true,
          }
        end
      }


      use {
        'nvim-treesitter/nvim-treesitter',
        run = ':TSUpdate',
        config = require('plugins.nvim-treesitter')
      }
      use {
        'David-Kunz/treesitter-unit', 
        config = function()
          vim.api.nvim_set_keymap('x', 'iu', ':lua require"treesitter-unit".select()<CR>', {noremap=true})
          vim.api.nvim_set_keymap('x', 'au', ':lua require"treesitter-unit".select(true)<CR>', {noremap=true})
          vim.api.nvim_set_keymap('o', 'iu', ':<c-u>lua require"treesitter-unit".select()<CR>', {noremap=true})
          vim.api.nvim_set_keymap('o', 'au', ':<c-u>lua require"treesitter-unit".select(true)<CR>', {noremap=true})
        end
      }

      -- autoclose tag
      use {
        'windwp/nvim-ts-autotag',
        requires = { 'nvim-treesitter/nvim-treesitter' },
        config = function() 
          -- require('nvim-ts-autotag').setup() 
        end
      }
      
      use 'tpope/vim-fugitive' -- GBrowse
      use 'tpope/vim-rhubarb' -- enables GBrowse
      
      use {
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
      }

      use { 'aymericbeaumet/vim-symlink', requires = { 'moll/vim-bbye' } }

      use "lukas-reineke/lsp-format.nvim"
  end,

  config = {
    enable = true,
    -- log = { level = 'debug' },
    display = {
      open_fn = require "packer.util".float
    }
  }
})
