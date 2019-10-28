function stop_staging --description "<application>"
    if not count $argv > /dev/null
        echo "Please provide an app"
        return 1
    end

    set application $argv[1]

    switch $application
        case qlean
            set path ~/projects/qlean
            set ansible_app qlean
        case leps
            set path ~/projects/leps
            set ansible_app leps
        case messenger
            set path ~/projects/messenger
            set ansible_app qlean.messenger
        case '*'
            set path ~/projects/$application
            set ansible_app $application
    end

    set cwd $PWD

    set branch_name (cd $path; and git rev-parse --abbrev-ref HEAD)

    echo "Removing staging $application @@ $branch_name"

    cd ~/projects/infrastructure
    ./deploy-image.sh staging-stop $ansible_app -- --extra-vars "branch=$branch_name"
    cd $cwd
end
