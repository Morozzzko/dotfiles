source ~/.profile

abbr -a -g -- gst 'tig status'
abbr -a -U -- gst 'tig status'

abbr -a be bundle exec
abbr -a rails bundle exec rails
abbr -a rspec bundle exec rspec
abbr -a rake bundle exec rake
abbr -a reek bundle exec reek
abbr -a jekyll bundle exec jekyll
abbr -a rubocop bundle exec rubocop
abbr -a gpf git push --force-with-lease
abbr -a grs git restore --source master
abbr -a gpo git push -u origin (git branch --show-current)
abbr -a gbm git branch -m

abbr gbda 'git branch --no-color --merged | command grep -vE "^(\+|\*|\s*(master|develop|dev)\s*\$)" | command xargs -n 1 git branch -d'

source /usr/local/opt/asdf/asdf.fish
set -g fish_user_paths "/usr/local/opt/libpq/bin" $fish_user_paths
