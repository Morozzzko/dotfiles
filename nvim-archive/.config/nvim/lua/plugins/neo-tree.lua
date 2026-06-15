return function()
  require('neo-tree').setup({
    filesystem = {
      filtered_items = {
        hide_dotfiles = false
      }
    },
    event_handlers = {
      {
        event = "file_opened",
        handler = function(file_path)
          require("neo-tree").close('buffers')
        end
      },
    }
  })
end
