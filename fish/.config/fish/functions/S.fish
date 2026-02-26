function S --wraps='pacman -Ss' --description 'alias S=pacman -Ss'
    pacman -Ss $argv
end
