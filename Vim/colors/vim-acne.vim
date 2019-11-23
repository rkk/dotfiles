" This is a Vim color scheme named "vim-acne".
"
" It features no syntax highlighting, and no colors of its own,
" but uses the default colors from the terminal.
" Using a Solarized Light or ACME color scheme in the terminal
" is highy recommended.
" Instead of syntax highlighting, this scheme provides structural
" highlighting, where few, key structural elements are highlighted.
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


" Normalize item on all terminal and GUI options.
function! s:normalize(item)
  execute "hi clear" a:item
  execute "highlight" a:item "term=NONE cterm=NONE ctermfg=NONE ctermbg=NONE gui=NONE guifg=NONE guibg=NONE"
  execute "hi link" a:item "Normal"
endfunction


" Invert item, terminal options only.
function! s:invert(item)
  execute "highlight" a:item "cterm=inverse"
endfunction


" Underline item, terminal options only.
function! s:underline(item)
  execute "highlight" a:item "cterm=underline"
endfunction


" Provide hacks for difficult items.
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
