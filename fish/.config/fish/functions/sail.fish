function sail --wraps='sh $([ -f sail ] && echo sail || echo vendor/bin/sail)' --description 'alias sail=sh $([ -f sail ] && echo sail || echo vendor/bin/sail)'
  sh $([ -f sail ] && echo sail || echo vendor/bin/sail) $argv
        
end
