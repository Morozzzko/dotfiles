-- Update after anything changes

vim.api.nvim_create_autocmd("BufWritePost", { pattern = "plugins.lua", command = "source <afile> | PackerSync" })

return require('packer').startup({
  function(use)
      use 'wbthomason/packer.nvim'

      use { 'catppuccin/nvim', as = "catppuccin" } -- colorscheme

      use {
        "nvim-neo-tree/neo-tree.nvim",
          branch = "v2.x",
          requires = {
            "nvim-lua/plenary.nvim",
            "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
            "MunifTanjim/nui.nvim",
          },
          config = function()
            require('neo-tree').setup({
              event_handlers = {
                {
                  event = "file_opened",
                  handler = function(file_path)
                    --auto close
                    require("neo-tree").close('buffers')
                  end
                },
              }
            })
          end
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
        config = function()
          local telescope = require('telescope')
          telescope.setup {
            pickers = {
              find_files = {
                follow = true
              },
              live_grep = {
                follow = true
              }
            },
            extensions = {
              fzf = {
                fuzzy = true, -- false will only do exact matching
                override_generic_sorter = true, -- override the generic sorter
                override_file_sorter = true, -- override the file sorter
                case_mode = 'smart_case' -- or "ignore_case" or "respect_case"
                -- the default case_mode is "smart_case"
              }
            }
          }

          telescope.load_extension("live_grep_args")
          telescope.load_extension('fzf')
        end,
        -- config = require('plugins.telescope-nvim')
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
        config = function()
          require 'nvim-treesitter.configs'.setup {
             ensure_installed = 'all',
             highlight = {
                enable = true, -- false will disable the whole extension
                indent = { enable = true },
                use_languagetree = true
            },
        }
        end
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
        config = function() require('nvim-ts-autotag').setup() end
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
              replace_all = "<leader><cr>",
            },
          }
        end
      }

      use { 'aymericbeaumet/vim-symlink', requires = { 'moll/vim-bbye' } }
  end,

  config = {
    enable = true,
    -- log = { level = 'debug' },
    display = {
      open_fn = require "packer.util".float
    }
  }
})
