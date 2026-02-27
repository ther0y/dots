# fzf RobCo aesthetic (Fish Version) - High Contrast & Bordered
set -gx FZF_DEFAULT_OPTS "--color=fg:#{{foreground|strip}},bg:#{{background|strip}},hl:#{{color2|strip}} \
--color=fg+:#{{background|strip}},bg+:#{{color5|strip}},hl+:#{{color2|strip}} \
--color=info:#{{color3|strip}},prompt:#{{color5|strip}},pointer:#{{color5|strip}} \
--color=marker:#{{color1|strip}},spinner:#{{color5|strip}},header:#{{color6|strip}} \
--color=border:#{{color8|strip}} \
--prompt='Robco > ' --marker='>' --pointer='→' --height=100% --reverse --border=rounded"