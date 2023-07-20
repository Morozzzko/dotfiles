source ~/.profile

abbr -a be bundle exec
abbr -a rspec bundle exec rspec
abbr -a rake bundle exec rake
abbr -a reek bundle exec reek
abbr -a rails rails
abbr -a jekyll bundle exec jekyll
abbr -a rubocop bundle exec rubocop
abbr -a gpf git push --force-with-lease
abbr -a grs git restore --source master
abbr -a gpo 'git push -u origin (git branch --show-current)'
abbr -a gpof 'git push -u origin (git branch --show-current) --force-with-lease'
abbr -a gbm git branch -m
abbr -a -g -- gst 'tig status'
abbr -a -U -- gst 'tig status'
abbr -a dcl docker container list 
abbr -a dl docker logs 

abbr gbda "git fetch -p && git for-each-ref --format '%(refname:short) %(upstream:track)' | awk '\$2 == \"[gone]\" {print \$1}' | xargs -r git branch -D"

abbr hubpr "hub pull-request --base=(git branch | cut -c 3- | grep -E '^master\$|^main\$')"

abbr gcom "git checkout (git branch | cut -c 3- | grep -E '^master\$|^main\$')"

source /usr/local/opt/asdf/libexec/asdf.fish
set -g fish_user_paths "/usr/local/opt/libpq/bin" $fish_user_paths

 function fish_right_prompt
  #intentionally left blank
 end
