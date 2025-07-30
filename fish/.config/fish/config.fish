if status is-interactive
    # Commands to run in interactive sessions can go here
end

set -gx POCKETBASE_URL https://pb.framers.top

# https://how.wtf/disable-welcome-message-in-fish-shell.html
set -g fish_greeting

set -gx VOLTA_HOME "$HOME/.volta"
set -gx PATH "$VOLTA_HOME/bin" $PATH

set -gx MINICONDA3_HOME "$HOME/miniconda3"
set -gx PATH "$MINICONDA3_HOME/bin" $PATH

set -gx PATH "$HOME/bin" $PATH

export STARSHIP_CONFIG=$HOME/.config/starship.toml

starship init fish | source
# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
if test -f /Users/masood/miniconda3/bin/conda
    eval /Users/masood/miniconda3/bin/conda "shell.fish" hook $argv | source
else
    if test -f "/Users/masood/miniconda3/etc/fish/conf.d/conda.fish"
        . "/Users/masood/miniconda3/etc/fish/conf.d/conda.fish"
    else
        set -x PATH /Users/masood/miniconda3/bin $PATH
    end
end
# <<< conda initialize <<<

source ~/.asdf/asdf.fish

set -gx PATH "$HOME/.asdf/installs/deno/$(asdf current deno | awk '{print $2}')/.deno/bin" $PATH

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
