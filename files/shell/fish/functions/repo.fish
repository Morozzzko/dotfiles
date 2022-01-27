function repo --description "<work/personal>"
    if test (count $argv) -eq 1
        set type $argv[1]
    else
      echo "Please specify if it's a work or a personal job"
      return 1
    end

    switch $type
        case work
            git config user.email i.morozov@bookmate.com
            git config user.signingkey 2324754CC85343C9
            git config commit.gpgsign true
        case personal
            git config user.email igor@morozov.is
            git config user.signingkey 177A8627388D6293
            git config commit.gpgsign true
    end

    ghi

    echo "Set email and sign key for $type use"
end
