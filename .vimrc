set nocompatible               " be iMproved
filetype off


if has('vim_starting')
  set runtimepath+=~/.vim/bundle/neobundle.vim
endif
call neobundle#begin(expand('~/.vim/bundle')) 
"" originalrepos on github
"NeoBundle 'Shougo/neobundle.vim'
"NeoBundle 'Shougo/vimproc'
"NeoBundle 'VimClojure'
"NeoBundle 'Shougo/vimshell'
"NeoBundle 'Shougo/unite.vim'
"NeoBundle 'Shougo/neocomplcache'
"NeoBundle 'Shougo/neosnippet'
"NeoBundle 'jpalardy/vim-slime'
"NeoBundle 'scrooloose/syntastic'
"""NeoBundle 'https://bitbucket.org/kovisoft/slimv'
""NeoBundle 'https://github.com/Shougo/neocomplcache.git'
""NeoBundle 'https://github.com/Shougo/neocomplcache-clang_complete.git'
"NeoBundle 'Shougo/neocomplcache-clang_complete.git'
NeoBundle 'Rip-Rip/clang_complete.git'
NeoBundle 'Shougo/neocomplete.git'
call neobundle#end() 

NeoBundleCheck

let g:clang_periodic_quickfix = 0
let g:clang_complete_copen = 1
let g:clang_use_library = 1

" this need to be updated on llvm update
let g:clang_library_path = '/usr/lib/llvm-3.5/lib'
" specify compiler options
let libstr = system('find $WORKING_DIR | grep h$ | sed -e "s/[_0-9a-zA-Z]\+\.h//g" | sort | uniq | sed -e "s/^/-I/g" | grep -v "\(sim\|git\)" | tr "\n" " "')
let g:clang_user_options = '-std=c++11 -stdlib=libc++ ' . libstr . ' 2>/dev/null'

"""" for ctags
let t = system('ctags -R $WORKING_DIR')
nnoremap <C-h> :vsp<CR> :exe("tjump ".expand('<cword>'))<CR>
nnoremap <C-k> :split<CR> :exe("tjump ".expand('<cword>'))<CR>
nnoremap <C-j> :exe("tjump ".expand('<cword>'))<CR>


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"let tmp = system('find $WORKING_DIR | grep h$ | sed -e "s/[_0-9a-zA-Z]\+\.h//g" | sort | uniq | grep -v "\(sim\|git\)" | tr "\n" ","')
let tmp = system('find ${WORKING_DIR} | grep \\.h$ | sed -e "s/[-_0-9a-zA-Z.]\+\.h//g" | sort | uniq | grep -v "\(sim\|git\)" | grep  "/$" | tr "\n" ","')

"Note: This option must be set in .vimrc(_vimrc).  NOT IN .gvimrc(_gvimrc)!
" Disable AutoComplPop.
let g:acp_enableAtStartup = 0
" Use neocomplete.
let g:neocomplete#enable_at_startup = 1
" Use smartcase.
let g:neocomplete#enable_smart_case = 1
" Set minimum syntax keyword length.
let g:neocomplete#sources#syntax#min_keyword_length = 3
let g:neocomplete#lock_buffer_name_pattern = '\*ku\*'

" Define dictionary.
let g:neocomplete#sources#dictionary#dictionaries = {
    \ 'default' : '',
    \ 'vimshell' : $HOME.'/.vimshell_hist',
    \ 'scheme' : $HOME.'/.gosh_completions'
        \ }

" Define keyword.
if !exists('g:neocomplete#keyword_patterns')
    let g:neocomplete#keyword_patterns = {}
endif
let g:neocomplete#keyword_patterns['default'] = '\h\w*'

" Plugin key-mappings.
inoremap <expr><C-g>     neocomplete#undo_completion()
inoremap <expr><C-l>     neocomplete#complete_common_string()

" Recommended key-mappings.
" <CR>: close popup and save indent.
inoremap <silent> <CR> <C-r>=<SID>my_cr_function()<CR>
function! s:my_cr_function()
  return (pumvisible() ? "\<C-y>" : "" ) . "\<CR>"
  " For no inserting <CR> key.
  "return pumvisible() ? "\<C-y>" : "\<CR>"
endfunction
" <TAB>: completion.
inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
" <C-h>, <BS>: close popup and delete backword char.
inoremap <expr><C-h> neocomplete#smart_close_popup()."\<C-h>"
inoremap <expr><BS> neocomplete#smart_close_popup()."\<C-h>"
" Close popup by <Space>.
"inoremap <expr><Space> pumvisible() ? "\<C-y>" : "\<Space>"

" AutoComplPop like behavior.
"let g:neocomplete#enable_auto_select = 1

" Shell like behavior(not recommended).
"set completeopt+=longest
"let g:neocomplete#enable_auto_select = 1
"let g:neocomplete#disable_auto_complete = 1
"inoremap <expr><TAB>  pumvisible() ? "\<Down>" : "\<C-x>\<C-u>"

" Enable omni completion.
autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags

" Enable heavy omni completion.
if !exists('g:neocomplete#sources#omni#input_patterns')
  let g:neocomplete#sources#omni#input_patterns = {}
endif
"let g:neocomplete#sources#omni#input_patterns.php = '[^. \t]->\h\w*\|\h\w*::'
"let g:neocomplete#sources#omni#input_patterns.c = '[^.[:digit:] *\t]\%(\.\|->\)'
"let g:neocomplete#sources#omni#input_patterns.cpp = '[^.[:digit:] *\t]\%(\.\|->\)\|\h\w*::'

" For perlomni.vim setting.
" https://github.com/c9s/perlomni.vim
let g:neocomplete#sources#omni#input_patterns.perl = '\h\w*->\h\w*\|\h\w*::'

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

set expandtab "タブ入力を複数の空白入力に置き換える
set tabstop=4 "画面上でタブ文字が占める幅
set shiftwidth=4 "自動インデントでずれる幅
"set softtabstop=2 "連続した空白に対してタブキーやバックスペースキーでカーソルが動く幅
set autoindent "改行時に前の行のインデントを継続する
set smartindent "改行時に入力された行の末尾に合わせて次の行のインデントを増減する

set list
set listchars=tab:>-

set backspace=start,eol,indent
filetype plugin indent on     " required!
filetype indent on
syntax on
set ruler



