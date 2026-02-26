if status is-interactive
    # Commands to run in interactive sessions can go here
    # echo -e "\e[1;32mROBCO INDUSTRIES UNIFIED OPERATING SYSTEM\e[0m"
    # echo -e "\e[1;32mCOPYRIGHT 2075-2077 ROBCO CORP\e[0m"
end

set -gx POCKETBASE_URL https://pb.framers.top

# https://how.wtf/disable-welcome-message-in-fish-shell.html
set -g fish_greeting

set -gx MINICONDA3_HOME "$HOME/miniconda3"

set -gx PATH "$MINICONDA3_HOME/bin" $PATH

set -gx PATH "$HOME/bin" $PATH

set -gx PATH "$HOME/.gem/bin" $PATH

set -gx PATH "$HOME/.bun/bin" $PATH

set -gx PATH "$HOME/development/flutter/bin" $PATH

set -gx PATH $PATH $HOME/.krew/bin

bind \co tmux-sessionizer
bind \cp anote
bind \cq qnote

# Added by OrbStack: command-line tools and integration
# This won't be added again if you remove it.
source ~/.orbstack/shell/init2.fish 2>/dev/null || :

# opencode
fish_add_path /Users/masood/.opencode/bin
~/.local/bin/mise activate fish | source

export STARSHIP_CONFIG=$HOME/.config/starship.toml

starship init fish | source

function setwall
    swww img $argv[1] --transition-type outer
    wallust run -s $argv[1]

    # Reload Waybar
    killall -SIGUSR2 waybar

    killall -SIGUSR2 ghostty

    if pgrep tmux >/dev/null
        tmux source-file ~/.config/tmux/tmux.conf
        tmux set-option -g status-style "bg=default,fg=default"
        tmux refresh-client -S
    end
end

if status is-interactive
    # Link Fish to the running gnome-keyring-daemon
    if test -n "$DESKTOP_SESSION"
        set -gx (gnome-keyring-daemon --start --components=secrets | string split -m1 '=')
    end
end
