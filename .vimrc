set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'gmarik/Vundle.vim'
" Plugin 'Valloric/YouCompleteMe'
Plugin 'bling/vim-airline'
Plugin 'mhinz/vim-startify'
Plugin 'altercation/vim-colors-solarized'
Plugin 'embear/vim-localvimrc'
Plugin 'tomtom/tcomment_vim'
Plugin 'hynek/vim-python-pep8-indent'

" Syntastic
"Plugin 'scrooloose/syntastic'

" Python Plugins
Plugin 'hdima/python-syntax'
" Plugin 'klen/python-mode'
Plugin 'davidhalter/jedi-vim'
Plugin 'nvie/vim-flake8'

" Git Plugins
Plugin 'tpope/vim-fugitive'

" Javascript Plugins
Plugin 'pangloss/vim-javascript'
Plugin 'othree/javascript-libraries-syntax.vim'
Plugin 'burnettk/vim-angular'

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required
" To ignore plugin indent changes, instead use:
"filetype plugin on
"
" Brief help
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal
"
" see :h vundle for more details or wiki for FAQ
" Put your non-Plugin stuff after this line
set incsearch
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

syntax on
" let python_highlight_all = 1
set hlsearch

autocmd FileType html setlocal shiftwidth=2 tabstop=2

" vim-localvimrc options
let g:localvimrc_persistent = 2

" vim-flake8 options
autocmd BufWritePost *.py call Flake8()
" let g:flake8_show_in_file = 1

" automatically close the quickfix window if it's the only window present
aug QFClose
    au!
    au WinEnter * if winnr('$') == 1 && getbufvar(winbufnr(winnr()), "&buftype") == "quickfix"|q|endif
aug END

" Don't ignore any linting errors or warnings with pymode
" let g:pymode_lint_ignore = ''
" let g:pymode_rope_completion = 0
" let g:pymode_trim_whitespaces = 1
" let g:pymode_folding = 0
" let g:pymode_python = 'python3'

" syntastic options
" let g:syntastic_always_populate_loc_list=1
" let g:syntastic_auto_loc_list = 1
" let g:syntastic_check_on_open = 1
" let g:syntastic_check_on_wq = 1
" let g:syntastic_mode_map = {'mode': 'active',
"                            \'passive_filetypes': ['python']}

" let g:syntastic_python_python_exec='/usr/bin/python3'

set relativenumber

" Show the status line always
set laststatus=2

" populate g:airline_symbols dictionary with the powerline symbols
let g:airline_powerline_fonts = 1
let g:airline#extensions#syntastic#enabled = 1

" hilight the cursor line in insert mode
autocmd InsertEnter,InsertLeave * set cul!

" remove trailing whitespaces
func! DeleteTrailingWS()
  exe "normal mz"
  %s/\s\+$//ge
  exe "normal `z"
endfunc
autocmd BufWrite *.py :call DeleteTrailingWS()

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" set pep8 text widths for python comments and docstrings
function! GetPythonTextWidth()
    if !exists('g:python_normal_text_width')
        let normal_text_width = 79
    else
        let normal_text_width = g:python_normal_text_width
    endif

    if !exists('g:python_comment_text_width')
        let comment_text_width = 72
    else
        let comment_text_width = g:python_comment_text_width
    endif

    let cur_syntax = synIDattr(synIDtrans(synID(line("."), col("."), 0)), "name")
    if cur_syntax == "Comment"
        return comment_text_width
    elseif cur_syntax == "String"
        " Check to see if we're in a docstring
        let lnum = line(".")
        while lnum >= 1 && (synIDattr(synIDtrans(synID(lnum, col([lnum, "$"]) - 1, 0)), "name") == "String" || match(getline(lnum), '\v^\s*$') > -1)
            if match(getline(lnum), "\\('''\\|\"\"\"\\)") > -1
                " Assume that any longstring is a docstring
                return comment_text_width
            endif
            let lnum -= 1
        endwhile
    endif

    return normal_text_width
endfunction

augroup pep8
    au!
    autocmd CursorMoved,CursorMovedI * :if &ft == 'python' | :exe 'setlocal textwidth='.GetPythonTextWidth() | :endif
augroup END
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
