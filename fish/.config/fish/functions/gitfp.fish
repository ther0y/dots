function gitfp --wraps='git fetch --all && git pull' --description 'alias gitfp=git fetch --all && git pull'
  git fetch --all && git pull $argv
        
end
