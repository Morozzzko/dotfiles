source ~/.profile

abbr -a be bundle exec
abbr -a rspec bin/rspec
abbr -a rake bin/rake
abbr -a reek bin/reek
abbr -a rfix bin/rubocop -A
abbr -a rua bin/rubocop -A
abbr -a rails bin/rails
abbr -a jekyll bin/jekyll
abbr -a rubocop bin/rubocop
abbr -a bridgetown bin/bridgetown
abbr -a gpf git push --force-with-lease
abbr -a grs git restore --source main
abbr -a gpo 'git push -u origin (git branch --show-current)'
abbr -a gpof 'git push -u origin (git branch --show-current) --force-with-lease'
abbr -a gbm git branch -m
abbr -a -g -- gst 'lazygit status'
abbr -a dcl docker container list 
abbr -a dl docker logs 
abbr -a ldk lazydocker
abbr -a lzd lazydocker
abbr -a dc devcontainer exec --workspace-folder .

abbr gbda "git fetch -p && git for-each-ref --format '%(refname:short) %(upstream:track)' | awk '\$2 == \"[gone]\" {print \$1}' | xargs -r git branch -D"

abbr hubpr "hub pull-request --base=(git branch | cut -c 3- | grep -E '^master\$|^main\$')"

abbr gcom "git checkout (git branch | cut -c 3- | grep -E '^master\$|^main\$')"

mise activate fish | source

fish_add_path /opt/homebrew/opt/libpq/bin
fish_add_path ~/.sitedog/bin

function fish_right_prompt
  # intentionally left blank
end
