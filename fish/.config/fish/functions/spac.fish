function spac --wraps='sudo pacman -Ss' --description 'alias spac=sudo pacman -Ss'
  sudo pacman -Ss $argv
        
end
