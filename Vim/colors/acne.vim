" This is a Vim color scheme named "acne".
"
" It features no syntax highlighting, and no colors of its own,
" but uses the default colors from the terminal.
" Using a Solarized Light or ACME color scheme in the terminal
" is highy recommended.
"
" This scheme tries to reset as many options as possible, but
" may miss ones, especially ones defined by plugins. The following
" specific plugins and languages are however handled,
"
"   - Tagbar
"   - Go (vim-go)
"   - Markdown
"
" Others may be added at a later time.
" The name is a portmanteau of the ACME editor, famous for not supporting
" any syntax highlighting and the skin condition acne, which is
" unwanted highlighting.

hi clear
syntax reset
let g:colors_name = "acne"


"
" RESET VALUES
"

hi!  Comment       term=NONE  cterm=NONE  ctermfg=NONE  ctermbg=NONE  gui=NONE  guifg=NONE  guibg=NONE
hi!  Constant      term=NONE  cterm=NONE  ctermfg=NONE  ctermbg=NONE  gui=NONE  guifg=NONE  guibg=NONE
hi!  Special       term=NONE  cterm=NONE  ctermfg=NONE  ctermbg=NONE  gui=NONE  guifg=NONE  guibg=NONE
hi!  Identifier    term=NONE  cterm=NONE  ctermfg=NONE  ctermbg=NONE  gui=NONE  guifg=NONE  guibg=NONE
hi!  Statement     term=NONE  cterm=NONE  ctermfg=NONE  ctermbg=NONE  gui=NONE  guifg=NONE  guibg=NONE
hi!  PreProc       term=NONE  cterm=NONE  ctermfg=NONE  ctermbg=NONE  gui=NONE  guifg=NONE  guibg=NONE
hi!  Type          term=NONE  cterm=NONE  ctermfg=NONE  ctermbg=NONE  gui=NONE  guifg=NONE  guibg=NONE
hi!  Underlined    term=NONE  cterm=NONE  ctermfg=NONE  ctermbg=NONE  gui=NONE  guifg=NONE  guibg=NONE
hi!  Ignore        term=NONE  cterm=NONE  ctermfg=NONE  ctermbg=NONE  gui=NONE  guifg=NONE  guibg=NONE
hi!  Error         term=NONE  cterm=NONE  ctermfg=NONE  ctermbg=NONE  gui=NONE  guifg=NONE  guibg=NONE
hi!  Todo          term=NONE  cterm=NONE  ctermfg=NONE  ctermbg=NONE  gui=NONE  guifg=NONE  guibg=NONE
hi!  NonText       term=NONE  cterm=NONE  ctermfg=NONE  ctermbg=NONE  gui=NONE  guifg=NONE  guibg=NONE
hi!  Directory     term=NONE  cterm=NONE  ctermfg=NONE  ctermbg=NONE  gui=NONE  guifg=NONE  guibg=NONE
hi!  ErrorMsg      term=NONE  cterm=NONE  ctermfg=NONE  ctermbg=NONE  gui=NONE  guifg=NONE  guibg=NONE
hi!  IncSearch     term=NONE  cterm=NONE  ctermfg=NONE  ctermbg=NONE  gui=NONE  guifg=NONE  guibg=NONE
hi!  Search        term=NONE  cterm=NONE  ctermfg=NONE  ctermbg=NONE  gui=NONE  guifg=NONE  guibg=NONE
hi!  MoreMsg       term=NONE  cterm=NONE  ctermfg=NONE  ctermbg=NONE  gui=NONE  guifg=NONE  guibg=NONE
hi!  ModeMsg       term=NONE  cterm=NONE  ctermfg=NONE  ctermbg=NONE  gui=NONE  guifg=NONE  guibg=NONE
hi!  LineNr        term=NONE  cterm=NONE  ctermfg=NONE  ctermbg=NONE  gui=NONE  guifg=NONE  guibg=NONE
hi!  CursorLineNr  term=NONE  cterm=NONE  ctermfg=NONE  ctermbg=NONE  gui=NONE  guifg=NONE  guibg=NONE
hi!  Question      term=NONE  cterm=NONE  ctermfg=NONE  ctermbg=NONE  gui=NONE  guifg=NONE  guibg=NONE
hi!  StatusLine    term=NONE  cterm=NONE  ctermfg=NONE  ctermbg=NONE  gui=NONE  guifg=NONE  guibg=NONE
hi!  StatusLineNC  term=NONE  cterm=NONE  ctermfg=NONE  ctermbg=NONE  gui=NONE  guifg=NONE  guibg=NONE
hi!  VertSplit     term=NONE  cterm=NONE  ctermfg=NONE  ctermbg=NONE  gui=NONE  guifg=NONE  guibg=NONE
hi!  Title         term=NONE  cterm=NONE  ctermfg=NONE  ctermbg=NONE  gui=NONE  guifg=NONE  guibg=NONE
hi!  Visual        term=NONE  cterm=NONE  ctermfg=NONE  ctermbg=NONE  gui=NONE  guifg=NONE  guibg=NONE
hi!  VisualNOS     term=NONE  cterm=NONE  ctermfg=NONE  ctermbg=NONE  gui=NONE  guifg=NONE  guibg=NONE
hi!  WarningMsg    term=NONE  cterm=NONE  ctermfg=NONE  ctermbg=NONE  gui=NONE  guifg=NONE  guibg=NONE
hi!  WildMenu      term=NONE  cterm=NONE  ctermfg=NONE  ctermbg=NONE  gui=NONE  guifg=NONE  guibg=NONE
hi!  Folded        term=NONE  cterm=NONE  ctermfg=NONE  ctermbg=NONE  gui=NONE  guifg=NONE  guibg=NONE
hi!  FoldColumn    term=NONE  cterm=NONE  ctermfg=NONE  ctermbg=NONE  gui=NONE  guifg=NONE  guibg=NONE
hi!  DiffAdd       term=NONE  cterm=NONE  ctermfg=NONE  ctermbg=NONE  gui=NONE  guifg=NONE  guibg=NONE
hi!  DiffChange    term=NONE  cterm=NONE  ctermfg=NONE  ctermbg=NONE  gui=NONE  guifg=NONE  guibg=NONE
hi!  DiffDelete    term=NONE  cterm=NONE  ctermfg=NONE  ctermbg=NONE  gui=NONE  guifg=NONE  guibg=NONE
hi!  DiffText      term=NONE  cterm=NONE  ctermfg=NONE  ctermbg=NONE  gui=NONE  guifg=NONE  guibg=NONE
hi!  SignColumn    term=NONE  cterm=NONE  ctermfg=NONE  ctermbg=NONE  gui=NONE  guifg=NONE  guibg=NONE
hi!  Conceal       term=NONE  cterm=NONE  ctermfg=NONE  ctermbg=NONE  gui=NONE  guifg=NONE  guibg=NONE
hi!  SpellBad      term=NONE  cterm=NONE  ctermfg=NONE  ctermbg=NONE  gui=NONE  guifg=NONE  guibg=NONE
hi!  SpellCap      term=NONE  cterm=NONE  ctermfg=NONE  ctermbg=NONE  gui=NONE  guifg=NONE  guibg=NONE
hi!  SpellRare     term=NONE  cterm=NONE  ctermfg=NONE  ctermbg=NONE  gui=NONE  guifg=NONE  guibg=NONE
hi!  SpellLocal    term=NONE  cterm=NONE  ctermfg=NONE  ctermbg=NONE  gui=NONE  guifg=NONE  guibg=NONE
hi!  Pmenu         term=NONE  cterm=NONE  ctermfg=NONE  ctermbg=NONE  gui=NONE  guifg=NONE  guibg=NONE
hi!  PmenuSel      term=NONE  cterm=NONE  ctermfg=NONE  ctermbg=NONE  gui=NONE  guifg=NONE  guibg=NONE
hi!  PmenuSbar     term=NONE  cterm=NONE  ctermfg=NONE  ctermbg=NONE  gui=NONE  guifg=NONE  guibg=NONE
hi!  PmenuThumb    term=NONE  cterm=NONE  ctermfg=NONE  ctermbg=NONE  gui=NONE  guifg=NONE  guibg=NONE
hi!  TabLine       term=NONE  cterm=NONE  ctermfg=NONE  ctermbg=NONE  gui=NONE  guifg=NONE  guibg=NONE
hi!  TabLineSel    term=NONE  cterm=NONE  ctermfg=NONE  ctermbg=NONE  gui=NONE  guifg=NONE  guibg=NONE
hi!  TabLineFill   term=NONE  cterm=NONE  ctermfg=NONE  ctermbg=NONE  gui=NONE  guifg=NONE  guibg=NONE
hi!  CursorColumn  term=NONE  cterm=NONE  ctermfg=NONE  ctermbg=NONE  gui=NONE  guifg=NONE  guibg=NONE
hi!  CursorLine    term=NONE  cterm=NONE  ctermfg=NONE  ctermbg=NONE  gui=NONE  guifg=NONE  guibg=NONE
hi!  ColorColumn   term=NONE  cterm=NONE  ctermfg=NONE  ctermbg=NONE  gui=NONE  guifg=NONE  guibg=NONE
hi!  MatchParen    term=NONE  cterm=NONE  ctermfg=NONE  ctermbg=NONE  gui=NONE  guifg=NONE  guibg=NONE

" Special case: Go (Golang)
hi clear goTypeName
hi clear goFunction

" Special case: Tagbar
hi clear TagbarVisibilityPrivate
hi clear TagbarVisibilityPublic
hi clear TagbarAccessPrivate
hi clear TagbarAccessPublic


"
" STYLE DECLARATIONS
"

hi Normal           ctermfg=NONE ctermbg=NONE cterm=NONE
hi LineNr          ctermbg=NONE ctermfg=NONE cterm=NONE
" hi StatusLine       ctermbg=NONE ctermfg=NONE cterm=bold,underline
hi StatusLine       ctermbg=gray ctermfg=NONE cterm=inverse
hi StatusLineNC     ctermbg=NONE ctermfg=NONE cterm=NONE
hi VertSplit        ctermbg=NONE ctermfg=NONE cterm=NONE
hi Visual           ctermbg=NONE ctermfg=NONE cterm=inverse
hi Search           ctermbg=NONE ctermfg=NONE cterm=inverse
hi IncSearch        ctermbg=NONE ctermfg=NONE cterm=inverse
hi WildMenu         ctermbg=NONE ctermfg=NONE cterm=inverse
hi Pmenu            ctermbg=NONE ctermfg=NONE cterm=inverse
hi PmenuSel         ctermbg=NONE ctermfg=NONE cterm=NONE
hi PmenuSbar        ctermbg=NONE ctermfg=NONE cterm=inverse
hi PmenuThumb       ctermbg=NONE ctermfg=NONE cterm=inverse
hi ErrorMsg         ctermbg=NONE ctermfg=NONE cterm=NONE
hi TagbarHighlight  ctermbg=NONE ctermfg=NONE cterm=underline
hi Comment          term=NONE  cterm=NONE  ctermfg=NONE  ctermbg=NONE gui=NONE  guifg=NONE  guibg=NONE


"
" LINK ITEMS
"

hi link Special     Normal
hi link Operator    Normal
hi link Identifier  Normal
hi link Statement   Normal
hi link Constant    Normal
hi link Preproc     Normal
hi link NonText     Normal

" Special case: Tagbar
hi link TagbarType  Normal
hi link TagbarScope Normal
hi link TagbarKind  Normal
hi link TagbarSignature         Normal
hi link TagbarFoldIcon          Normal
hi link TagbarVisibilityPrivate Normal
hi link TagbarVisibilityPublic  Normal
hi link TagbarAccessPrivate     Normal
hi link TagbarAccessPublic      Normal


" Special case: TBD
hi link qfLineNr    Normal
hi link qfFileName  Normal

" Special case: Go (Golang)
hi link goDecimalInt Normal
hi link goSignedInts Normal
hi link goUnsignedInts Normal
hi link goBoolean    Normal
hi link goType       Normal
hi link goTypeName   Normal
hi link goString     String
hi link goRawString  Normal
hi link goFunction   Normal
hi link goComment    Comment

" Special case: Markdown
hi link markdownItalic Normal

