{# wallust template: colors.vim #}

" Clear existing highlights
highlight clear
if exists("syntax_on")
  syntax reset
endif

let g:colors_name = "wallust"
set background=dark

" --- Wallust Palette ---
let s:bg     = "{{background}}"
let s:fg     = "{{foreground}}"
let s:crust  = "{{foreground}}" " Using your 'foreground' trick for contrast
let s:color0 = "{{color0}}"
let s:color1 = "{{color1}}"
let s:color2 = "{{color2}}"
let s:color3 = "{{color3}}"
let s:color4 = "{{color4}}"
let s:color5 = "{{color5}}"
let s:color6 = "{{color6}}"
let s:color7 = "{{color7}}"
let s:color8 = "{{color8}}"
let s:color9 = "{{color9}}"
let s:color10 = "{{color10}}"
let s:color11 = "{{color11}}"
let s:color12 = "{{color12}}"
let s:color13 = "{{color13}}"
let s:color14 = "{{color14}}"
let s:color15 = "{{color15}}"

" --- Helper Function ---
function! s:hi(group, fg, bg, attr)
  let l:cmd = "hi " . a:group
  if a:fg != "" | let l:cmd .= " guifg=" . a:fg | endif
  if a:bg != "" | let l:cmd .= " guibg=" . a:bg | endif
  if a:attr != "" | let l:cmd .= " gui=" . a:attr | endif
  execute l:cmd
endfun

" --- UI Components ---
call s:hi("Normal", s:fg, s:bg, "none")
call s:hi("LineNr", s:color8, "none", "none")
call s:hi("CursorLine", "none", s:color0, "none")
call s:hi("Visual", s:bg, s:color4, "none") " Inverted visual selection
call s:hi("Pmenu", s:fg, s:color0, "none")
call s:hi("StatusLine", s:bg, s:color2, "bold")
call s:hi("VertSplit", s:color8, "none", "none")

" --- Syntax Highlighting ---
call s:hi("Comment",    s:color8, "none", "italic")
call s:hi("Constant",   s:color3, "none", "none")
call s:hi("String",     s:color2, "none", "none")
call s:hi("Identifier", s:color1, "none", "none")
call s:hi("Function",   s:color4, "none", "none")
call s:hi("Statement",  s:color5, "none", "none")
call s:hi("PreProc",    s:color6, "none", "none")
call s:hi("Type",       s:color3, "none", "none")
call s:hi("Special",    s:color6, "none", "none")
call s:hi("Todo",       s:bg, s:color3, "bold")