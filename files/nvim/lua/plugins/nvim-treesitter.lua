return function()
  require 'nvim-treesitter.configs'.setup {
     ensure_installed = 'all',
     ignore_install = { "embedded_template" },
     highlight = {
      enable = true, -- false will disable the whole extension
      indent = { enable = true },
      disable = { "embedded_template" },
      use_languagetree = true
    },
  }

    local ft_to_parser = require"nvim-treesitter.parsers".filetype_to_parsername
    ft_to_parser.erb = "html"
end

