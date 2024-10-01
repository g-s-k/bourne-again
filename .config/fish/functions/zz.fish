function zz
	set query ""
	if set args (string join " " $argv || true)
		set query "--query=$args"
	end

	set dir (z --list | fzf \
			--height 70% --tmux '90%,70%' \
			--nth 2.. --no-sort \
			$query \
			--bind 'enter:become:echo {2..}')

	if string length $dir >/dev/null
		cd $dir
	end
end
