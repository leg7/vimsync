if status is-login
	set -U fish_greeting

	set -gx LESS "Ri" # Less default options (inhibits git from calling less with -F and -R)
	set -gx BROWSER "firefox"
	set -gx EDITOR "nvim"

	set -gx ASAN_OPTIONS "halt_on_error=0"
	set -gx FZF_DEFAULT_OPTS "--ansi --layout reverse --color fg:-1,fg+:-1,bg:-1,bg+:-1,hl:-1,hl+:-1,query:-1,gutter:-1"

	set -gx LS_COLORS 'di=1;35:fi=0:ln=1;31:pi=5:so=5:bd=5:cd=5:or=4:ex=1;36'

	# XDG

	set -gx LOCAL_HOME "$HOME/.local"
	set -gx XDG_CACHE_HOME "$LOCAL_HOME/cache"
	set -gx XDG_CONFIG_HOME "$HOME/.config"
	set -gx XDG_DATA_HOME "$LOCAL_HOME/share"
	set -gx XDG_STATE_HOME "$LOCAL_HOME/state"
	set -gx BIN_HOME "$LOCAL_HOME/bin"
	set -gx PATH "$PATH:$BIN_HOME"
	if test -z "$XDG_RUNTIME_DIR"
		set -gx XDG_RUNTIME_DIR (mktemp -d "$XDG_STATE_HOME/$(id -u)-runtime-dir.XXX")
	end
	set -gx XDG_DESKTOP_DIR "$HOME"
	set -gx XDG_DOCUMENTS_DIR "$HOME/documents"
	set -gx XDG_DOWNLOAD_DIR "$HOME"
	set -gx XDG_MUSIC_DIR "$HOME/audio"
	set -gx XDG_PICTURES_DIR "$HOME/pics"
	set -gx XDG_PUBLICSHARE_DIR "$HOME/share"
	set -gx XDG_TEMPLATES_DIR "$HOME"
	set -gx XDG_VIDEOS_DIR "$HOME/vids"
	mkdir -p "$XDG_DESKTOP_DIR" \
		"$XDG_DOCUMENTS_DIR" \
		"$XDG_DOWNLOAD_DIR" \
		"$XDG_MUSIC_DIR" \
		"$XDG_PICTURES_DIR" \
		"$XDG_PUBLICSHARE_DIR" \
		"$XDG_TEMPLATES_DIR" \
		"$XDG_VIDEOS_DIR"

	set -gx WGETRC "$XDG_CONFIG_HOME/wgetrc"
	set -gx XCURSOR_PATH "$XCURSOR_PATH:$XDG_DATA_HOME/icons:/usr/share/icons"
	set -gx PASSWORD_STORE_DIR "$XDG_DATA_HOME/pass"
	set -gx MBSYNCRC "$XDG_CONFIG_HOME/isync/mbsyncrc"
	set -gx GNUPGHOME "$XDG_DATA_HOME/gnupg"
	set -gx NPM_CONFIG_USERCONFIG "$XDG_CONFIG_HOME/npm/npmrc"
	set -gx GHCUP_USE_XDG_DIRS "true"
	set -gx STARSHIP_CACHE "$XDG_CACHE_HOME/starship"
	set -gx CUDA_CACHE_PATH "$XDG_CACHE_HOME/nv"
	set -gx WINEPREFIX "$XDG_DATA_HOME/wine"
	set -gx CARGO_HOME "$XDG_DATA_HOME/cargo"
	set -gx CARGO_INSTALL_ROOT "$LOCAL_HOME"
	set -gx ANDROID_USER_HOME "$XDG_DATA_HOME/android"
	set -gx GRADLE_USER_HOME "$XDG_DATA_HOME/gradle"
	set -gx LEIN_HOME "$XDG_DATA_HOME/lein"
	set -gx _JAVA_OPTIONS "-Djava.util.prefs.userRoot=$XDG_CONFIG_HOME/java"
	set -gx GOPATH "$LOCAL_HOME"

	if test (tty) = "/dev/tty1"
		dbus-run-session river
	end
end

function fzf-cd
	cd (fd -t d | fzf)
end

function fzf-path
	readlink -f (fd | fzf) | tr -d '\n\r'
end

function fzf-copy-path
	fzf-path | wl-copy
end

function fzf-xdg-open
	setsid -f xdg-open (fzf-path)
end

function fzf-history
	history search | fzf | wl-copy
end

if status is-interactive
	for mode in default normal insert
		bind -M $mode \cg "setsid -f xdg-open ." # g for gui

		bind -M $mode 'ctrl-w' "fzf-cd; commandline -f repaint" # w for working dir
		bind -M $mode 'ctrl-h' "fzf-history; commandline -f repaint"
		bind -M $mode 'ctrl-p' "fzf-copy-path; commandline -f repaint"
		bind -M $mode 'ctrl-f' "fzf-xdg-open; commandline -f repaint"
		bind -M $mode 'alt-l' "ls -lahv --group-directories-first; fish_prompt"
		bind -M $mode 'alt-t' "tree -L 3; fish_prompt"
	end

	bind -M insert \ca "accept-autosuggestion" # a for accept
end
