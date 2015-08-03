set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'gmarik/Vundle.vim'

Plugin 'tpope/vim-sensible'

" Plugin 'Valloric/YouCompleteMe'
"
"
Plugin 'bling/vim-airline'
" populate g:airline_symbols dictionary with the powerline symbols
let g:airline_powerline_fonts = 1
let g:airline#extensions#syntastic#enabled = 1

Plugin 'mhinz/vim-startify'

Plugin 'wincent/command-t'

Plugin 'altercation/vim-colors-solarized'

Plugin 'embear/vim-localvimrc'
let g:localvimrc_persistent = 2

" This doesn't work for me
" Plugin 'myusuf3/numbers.vim'

Plugin 'tomtom/tcomment_vim'

Plugin 'ervandew/supertab'

Plugin 'tpope/vim-surround'

Plugin 'jiangmiao/auto-pairs'

" Syntastic
" Plugin 'scrooloose/syntastic'
" let g:syntastic_always_populate_loc_list=1
" let g:syntastic_auto_loc_list = 1
" let g:syntastic_check_on_open = 1
" let g:syntastic_check_on_wq = 1
" let g:syntastic_mode_map = {'mode': 'active',
"                            \'passive_filetypes': ['python']}
" let g:syntastic_python_python_exec='/usr/bin/python3'



"""" Python Plugins

Plugin 'hdima/python-syntax'

Plugin 'hynek/vim-python-pep8-indent'

Plugin 'davidhalter/jedi-vim'

Plugin 'nvie/vim-flake8'
autocmd BufWritePost *.py call Flake8()
" let g:flake8_show_in_file = 1

" Rope doesn't work with python3
" Plugin 'python-rope/ropevim'
" map <leader>j :RopeGotoDefinition<CR>
" map <leader>r :RopeRename<CR>

" Plugin 'klen/python-mode'
" Don't ignore any linting errors or warnings with pymode
" let g:pymode_lint_ignore = ''
" let g:pymode_rope_completion = 0
" let g:pymode_trim_whitespaces = 1
" let g:pymode_folding = 0
" let g:pymode_python = 'python3'



"""" Git Plugins

Plugin 'tpope/vim-fugitive'



"""" Javascript Plugins

Plugin 'pangloss/vim-javascript'

Plugin 'othree/javascript-libraries-syntax.vim'

Plugin 'burnettk/vim-angular'

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required

""" vim options

" Set <Leader> to space bar
let mapleader=' '
" <Leader>P pastes at end of line
:map <Leader>P $p
" <Leader> <space> goes to the end of the line
:map <Leader><space> $
" <Leader> O or o inserts a blank line and returns to NORMAL
:map <Leader>O O<Esc>
:map <Leader>o o<Esc>
" <Leader> 8 goes to the 80th column
:map <Leader>8 80\|


" set t_Co=256
set t_Co=16
set background=dark
" colorscheme distinguished
colorscheme solarized

set tabstop=4
set expandtab
set softtabstop=4
set shiftwidth=4
set backspace=2
set smarttab

" Enable syntax highlighting
syntax on
" Highlight searches
set hlsearch
" Highlight dynamically as pattern is typed
set incsearch
" Ignore case of searches
set ignorecase
" Don't reset cursor to start of line when moving around
set nostartofline
" Show the filename in the window titlebar
set title
" Show the (partial) command as it's being typed
set showcmd
" Show the status line always
set laststatus=2
" Start scrolling three lines before the horizondal window border
set scrolloff=3
" Start scrolling three chars before the vertical window border
set sidescrolloff=3
" Use relative linenumbers
set relativenumber
" Use advance command line completion
set wildmenu
" Delete comment character when joining commented lines
set formatoptions+=j
" Timeout key combinations after .1 seconds
set ttimeout
set ttimeoutlen=100
" Use vertical diffs
set diffopt+=vertical


""" Filetype-specific settings """

" Shorten the tabstop for html files
autocmd FileType html setlocal shiftwidth=2 tabstop=2
" Treat .json files as .js
autocmd BufNewFile,BufRead *.json setfiletype json syntax=javascript
" Treat .md files as Markdown
autocmd BufNewFile,BufRead *.md setlocal filetype=markdown
" Highlight the 80 character column in python
autocmd FileType python setlocal colorcolumn=80

""" Functions """

" Automatically close the quickfix window if it's the only window present
aug QFClose
    au!
    au WinEnter * if winnr('$') == 1 && getbufvar(winbufnr(winnr()), "&buftype") == "quickfix"|q|endif
aug END

" hilight the cursor line in insert mode
autocmd InsertEnter,InsertLeave * set cul!

" remove trailing whitespaces on every save
func! DeleteTrailingWS()
  exe "normal mz"
  %s/\s\+$//ge
  exe "normal `z"
endfunc
autocmd BufWrite *.py :call DeleteTrailingWS()

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Find Nearest
" Source: http://vim.1045645.n5.nabble.com/find-closest-occurrence-in-both-directions-td1183340.html
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

function! FindNearest(pattern)
  let @/=a:pattern
  let b:prev = search(a:pattern, 'bncW')
  if b:prev
    let b:next = search(a:pattern, 'ncW')
    if b:next
      let b:cur = line('.')
      if b:cur - b:prev == b:next - b:cur
        " on a match
      elseif b:cur - b:prev < b:next - b:cur
        ?
      else
        /
      endif
    else
      ?
    endif
  else
    /
  endif
endfunction

command! -nargs=1 FN call FindNearest(<q-args>)
nmap \ :FN<space>

""" Select between conflict blocks
" select ours
nmap <leader>so \<<<<<<<<CR>dd/=======<CR>V/>>>>>>><CR>d
" select theirs
nmap <leader>st \<<<<<<<<CR>V/=======<CR>dk/>>>>>>><CR>dd
" find next conflict
nmap <leader>fc /<<<<<<<<CR>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" set pep8 text widths for python comments and docstrings
" function! GetPythonTextWidth()
"     if !exists('g:python_normal_text_width')
"         let normal_text_width = 79
"     else
"         let normal_text_width = g:python_normal_text_width
"     endif
"
"     if !exists('g:python_comment_text_width')
"         let comment_text_width = 72
"     else
"         let comment_text_width = g:python_comment_text_width
"     endif
"
"     let cur_syntax = synIDattr(synIDtrans(synID(line("."), col("."), 0)), "name")
"     if cur_syntax == "Comment"
"         return comment_text_width
"     elseif cur_syntax == "String"
"         " Check to see if we're in a docstring
"         let lnum = line(".")
"         while lnum >= 1 && (synIDattr(synIDtrans(synID(lnum, col([lnum, "$"]) - 1, 0)), "name") == "String" || match(getline(lnum), '\v^\s*$') > -1)
"             if match(getline(lnum), "\\('''\\|\"\"\"\\)") > -1
"                 " Assume that any longstring is a docstring
"                 return comment_text_width
"             endif
"             let lnum -= 1
"         endwhile
"     endif
"
"     return normal_text_width
" endfunction
"
" augroup pep8
"     au!
"     autocmd CursorMoved,CursorMovedI * :if &ft == 'python' | :exe 'setlocal textwidth='.GetPythonTextWidth() | :endif
" augroup END
" """"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
