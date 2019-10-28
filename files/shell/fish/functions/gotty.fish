function gotty --description "<application> <branch / production>"
    if test (count $argv) -eq 1
        set application (current_project)
        set branch (cd ~/projects/$application; and git rev-parse --abbrev-ref HEAD)
        echo $branch
    else if test (count $argv) -lt 2
        echo "Please provide an app and a branch. Or say 'gotty here'"
        return 1
    else
        set application $argv[1]
        set branch $argv[2]
    end

    switch $branch
      case production
        gotty-client "$application-gotty.service.dc3.consul"
      case '*'
        gotty-client "$application-$branch-gotty.service.consul"
    end
end
