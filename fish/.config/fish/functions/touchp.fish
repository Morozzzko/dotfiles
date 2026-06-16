function touchp --description "<path to touch & mkdir -p>"
    set path $argv[1]
    set dir (dirname $path)
    mkdir -p $dir
    touch $path
end
