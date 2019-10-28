function start_staging --description "<application>"
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
    set commit_hash (cd $path; and git rev-parse HEAD)

    echo "Staging $branch_name:$commit_hash"

    cd ~/projects/infrastructure
    ansible-playbook -i hosts "apps/$ansible_app/start-staging-branch-flops.yml" --extra-vars "branch=$branch_name docker_tag=$commit_hash"
    cd $cwd
end
