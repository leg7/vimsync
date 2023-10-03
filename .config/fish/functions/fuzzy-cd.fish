function fuzzy-cd
	set dir (find -L . $fuzzy_exclude -type d -printf '%P\n' | fzf --preview='p {}' --preview-label='Directory content')/
	test -d "$dir" && c "$dir"
end

