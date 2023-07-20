function far --description "pattern replacement path"
  set pattern $argv[1]
  set replacement $argv[2]
  set path $argv[3..-1]

  ag $pattern $path -l | xargs gsed -i "s|$pattern|$replacement|g"
end
