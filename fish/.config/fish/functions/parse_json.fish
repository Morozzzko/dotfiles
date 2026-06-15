function parse_json
  # ruby -e "require 'json'; pp JSON.parse(STDIN.read)"
  ruby -e "require 'tty-tree'; require 'json'; content = STDIN.read; i = 0; while (content.include?('\"table\":')) do content.sub!('\"table\":', '\"table_' + (i+=1).to_s + '\":'); end;  parsed = JSON.parse(content); puts TTY::Tree.new(JSON.parse(content)).render"
end
