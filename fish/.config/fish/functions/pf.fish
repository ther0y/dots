function pf --wraps='pnpm --filter' --description 'alias pf=pnpm --filter'
  pnpm --filter $argv
        
end
