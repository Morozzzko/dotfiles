function parse_json
  ruby -e "require 'json'; pp JSON.parse(STDIN.read)"
end
