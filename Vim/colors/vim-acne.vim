" This is a Vim color scheme named "vim-acne".
"
" It features no syntax highlighting and uses only the default
" terminal colors. Solarized Light, ACME or similar terminal color
" schemes are highly recommended.
"
" The name refers to ACME, the text editor famous for not supporting
" any syntax highlighting, and the similar named skin condition,
" representing another kind of unwanted highlighting.

hi clear
if exists('syntax on')
        syntax reset
endif
let g:colors_name = "vim-acne"


" Items to present WITHOUT highlighting.
let g:no_highlight_items = ['Comment', 'Constant', 'Special', 'Identifier', 'Statement', 'PreProc', 'Type', 'Underlined', 'Ignore', 'Error', 'Todo', 'NonText', 'Directory', 'ErrorMsg', 'IncSearch', 'Search', 'MoreMsg', 'ModeMsg', 'LineNr', 'CursorLine', 'Question', 'StatusLine', 'StatusLineNC', 'VertSplit', 'Title', 'Visual', 'VisualNOS', 'WarningMsg', 'WildMenu', 'Folded', 'FoldColumn', 'DiffAdd', 'DiffChange', 'DiffDelete', 'DiffText', 'SignColumn', 'Conceal', 'SpellBad', 'SpellLocal', 'SpellRare', 'SpellCap', 'Pmenu', 'PmenuSel', 'PmenuThumb', 'PmenuSbar', 'TabLine', 'TabLineSel', 'TabLineFill', 'CursorColumn', 'CursorLine', 'MatchParen', 'Operator', 'goTypeName', 'goFunction', 'goDecimalInt', 'goSignedInts', 'goUnsignedInts', 'goBoolean', 'goType', 'goString', 'goRawString', 'goFunction', 'goComment', 'TagbarVisibilityPrivate', 'TagbarVisibilityPublic', 'TagbarAccessPrivate', 'TagbarAccessPublic', 'TagbarType', 'TagbarScope', 'TagbarKind', 'TagbarSignature', 'TagbarFoldIcon', 'qfLineNr', 'qfFileName', 'markdownItalic']


" Items to present WITH some highlighting: invert.
let g:inverse_items = ['StatusLine', 'StatusLineNC', 'Visual', 'Search', 'IncSearch', 'WildMenu', 'Pmenu', 'PmenuSbar', 'PmenuThumb', 'MatchParen']


" Items to present WITH some highlighting: underline.
let g:underline_items = ['TagbarHighlight']


" Normalize item highlighting.
function! s:normalize(item)
  execute "highlight" a:item "term=NONE cterm=NONE ctermfg=NONE ctermbg=NONE"
endfunction


" Invert item.
function! s:invert(item)
  execute "highlight" a:item "cterm=inverse"
endfunction


" Underline item.
function! s:underline(item)
  execute "highlight" a:item "cterm=underline"
endfunction


" Hack the item, if it is being difficult.
function! s:postfix_hack()
    " This is a hack to avoid filling the status line on non-current
    " buffers (StatusNC) with the visual indicator "^^^^": add a
    " bold setting " that does nothing.
    execute "highlight StatusLineNC cterm=bold"
endfunction


"
" EXECUTE THEME SETTINGS
"
for i in g:no_highlight_items
    call s:normalize(i)
endfor

for i in g:inverse_items
    call s:invert(i)
endfor

for i in g:underline_items
    call s:underline(i)
endfor

call s:postfix_hack()
