function fuzzy-path
	set path $PWD(find -L . $fuzzy_exclude -type f -o -type d -printf '%P\n' | fzf --preview='p {}' --preview-label='Directory content' | cut -c '2-')
	printf $path | wl-copy
end
