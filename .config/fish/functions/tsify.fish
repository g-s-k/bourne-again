#!/usr/bin/env fish

function tsify --argument-names directory
    set -l files (fzf --preview='bat --color=always {}' --select-1 --multi --query=".js $directory")

    for f in (string match "*.js" $files)
        if test (basename $f) = "messages.js"
            continue
        end

        git mv -v $f (string replace --regex '.js$' ".ts" $f)
    end

    for f in (string match "*.jsx" $files)
        git mv -v $f (string replace --regex '.jsx$' ".tsx" $f)
    end
end
