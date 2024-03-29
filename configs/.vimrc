"++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++"
"                                                                              "
"                       __   _ _ _ __ ___  _ __ ___                            "
"                       \ \ / / | '_ ` _ \| '__/ __|                           "
"                        \ V /| | | | | | | | | (__                            "
"                         \_/ |_|_| |_| |_|_|  \___|                           "
"                                                                              "
"                                                                              "
"++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++"

" be iMproved
set nocompatible

" Set leader
let mapleader= ","

" Use GUI colors in truecolor terminals
let &t_8f="\<Esc>[38;2;%lu;%lu;%lum"
let &t_8b="\<Esc>[48;2;%lu;%lu;%lum"
" set termguicolors

" Attempt to fix cursor shape
let &t_EI = "\<Esc>[1 q"
let &t_SR = "\<Esc>[3 q"
let &t_SI = "\<Esc>[5 q"
autocmd BufEnter * execute 'silent !echo -ne "' . &t_EI . '"'


"=====================================================
"" vim-plug settings
"=====================================================

" Autoinstaller if vim-plug not installed
if empty(glob('~/.vim/autoload/plug.vim'))
    silent !curl -sfLo ~/.vim/autoload/plug.vim --create-dirs
        \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    autocmd VimEnter * PlugInstall | source ~/.vimrc
endif

call plug#begin('~/.vim/plugged')

    "-------------------=== Code/Project navigation ===-------------
    Plug 'preservim/nerdtree'                                          "  File navigation
    Plug 'tpope/vim-fugitive'                                          "  Git wrapper
    Plug 'tpope/vim-rhubarb'                                           "  Github wrapper
    Plug 'tpope/vim-projectionist'                                     "  Project navigation
    Plug 'tpope/vim-dispatch'                                          "  Flexible compiling
    Plug 'mhinz/vim-signify'                                           "  Show git file changes in gutter
    Plug 'tpope/vim-unimpaired'                                        "  Useful [] mappings

    "-------------------=== Other ===-------------------------------
    Plug 'dracula/vim', { 'as': 'dracula' }                            "  Add dracula theme
    Plug 'junegunn/limelight.vim'                                      "  Limelight
    Plug 'vim-airline/vim-airline'                                     "  Status bar plugin
    Plug 'vim-airline/vim-airline-themes'                              "  Status bar plugin themes
    Plug 'ryanoasis/vim-devicons'                                      "  Adds icons to vim plugins
    Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
    Plug 'junegunn/fzf.vim'                                            "  Fuzzy finder plugins
    Plug 'vim-test/vim-test'                                           "  Running tests on different granularities

    "-------------------=== Languages support ===-------------------
    Plug 'neoclide/coc.nvim', {'branch': 'release'}                    "  Autocompletion, and additional text editing support
    Plug 'tpope/vim-abolish'                                           "  Search, substitute, abbreviate word variations
    Plug 'tpope/vim-repeat'                                            "  Repeat plugin-enabled actions
    Plug 'tpope/vim-commentary'                                        "  Comment stuff out
    Plug 'junegunn/rainbow_parentheses.vim'                            "  Rainbow parentheses
    Plug 'plasticboy/vim-markdown'                                     "  Markdown support
    Plug 'JamshedVesuna/vim-markdown-preview'                          "  Markdown preview
    Plug 'SirVer/ultisnips'                                            "  Ultisnips engine
    Plug 'honza/vim-snippets'                                          "  Snippet files for various programming languages
    Plug 'lervag/vimtex'                                               "  LaTeX support
    Plug 'KeitaNakamura/tex-conceal.vim'                               "  LaTeX concealment

    "-------------------=== Code linting/syntax ===-------------------
    Plug 'tpope/vim-sleuth'                                            "  Auto adjust 'shiftwidth' and 'expandtab' 
    Plug 'dense-analysis/ale'                                          "  General purpose linter and fixer framework
    Plug 'sheerun/vim-polyglot'                                        "  General purpose language syntax highlighter
    Plug 'tpope/vim-surround'                                          "  Parentheses, brackets, quotes, XML tags, and more
    Plug 'godlygeek/tabular'                                           "  Tool for visual alignment

    "-------------------=== Tmux/terminal interaction ===-------------
    Plug 'jpalardy/vim-slime'                                          "  Turn vim + tmux into REPL
    Plug 'hanschen/vim-ipython-cell', { 'for': 'python' }              "  Slime wrapper for iPython dev
    Plug 'tpope/vim-tbone'                                             "  Basic vim + tmux support

call plug#end()


"=====================================================
"" CoC settings
"=====================================================

set completeopt=longest,menuone

" Make <CR> to accept selected completion item or notify coc.nvim to format
" <C-g>u breaks current undo
inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

" GoTo code navigation
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window.
nnoremap <silent> K :call <SID>show_documentation()<CR>

" Highlight the symbol and its references when holding the cursor
autocmd CursorHold * silent call CocActionAsync('highlight')

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  elseif (coc#rpc#ready())
    call CocActionAsync('doHover')
  else
    execute '!' . &keywordprg . " " . expand('<cword>')
  endif
endfunction

" Install plugins
let g:coc_global_extensions = ['coc-snippets', 'coc-clangd', 'coc-jedi', 'coc-prettier', 'coc-sqlfluff', 'coc-json', 'coc-yaml']

"" coc-snippets

" Use <C-l> for trigger snippet expand.
imap <C-l> <Plug>(coc-snippets-expand)

" Use <C-j> for select text for visual placeholder of snippet.
vmap <C-j> <Plug>(coc-snippets-select)

" Use <C-j> for jump to next placeholder, it's default of coc.nvim
let g:coc_snippet_next = '<c-j>'

" Use <C-k> for jump to previous placeholder, it's default of coc.nvim
let g:coc_snippet_prev = '<c-k>'

" Use <C-j> for both expand and jump (make expand higher priority.)
imap <C-j> <Plug>(coc-snippets-expand-jump)

" Use <leader>x for convert visual selected code to snippet
xmap <leader>x  <Plug>(coc-convert-snippet)

"=====================================================
"" ALE settings
"=====================================================

" Need to implement ~/.vim/plugged/ale/ale_linters/sql/sqlfluff.vim
" No linting will take place until that .vim file is implemented
" Since it calls the executable and parses its output

" Set linters
let g:ale_linters = {
\   'c': ['cc'],
\   'python': ['flake8', 'pylint'],
\   'markdown': ['markdownlint'],
\   'javascript': ['eslint'],
\   'json': ['jq'],
\   'sh': ['shellcheck'],
\   'yaml': ['yamllint'],
\   'haskell': ['hlint']
\}

" Set fixers
let g:ale_fixers = {
\   '*': ['remove_trailing_lines', 'trim_whitespace'],
\   'c': ['uncrustify'],
\   'python': ['black', 'isort'],
\   'markdown': ['prettier'],
\   'javascript': ['prettier'],
\   'json': ['jq'],
\   'yaml': ['prettier'],
\   'haskell': ['stylish-haskell']
\}

" Play nice with CoC
let g:ale_disable_lsp = 1

" Set lint and fix occasions
let g:ale_linters_explicit = 1
let g:ale_lint_on_save = 1
let g:ale_fix_on_save = 0

" Customize linter feedback visuals
let g:ale_echo_msg_format = '[%linter%] %s [%severity%]'
let g:ale_sign_error = '❌'
let g:ale_sign_warning = '⚠️ '
highlight clear ALEErrorSign
highlight clear ALEWarningSign
let g:ale_set_highlights = 0

" Move to next warning/error (overwrites vim-unimpaired argslist)
nmap ]a :ALENextWrap<CR>
nmap [a :ALEPreviousWrap<CR>
nmap ]A :ALELast<CR>
nmap [A :ALEFirst<CR>

"" Language/env-specific settings

" Python
let g:ale_python_auto_pipenv = 1

" Markdown
let g:ale_markdown_markdownlint_options = '-c $HOME/.markdownlintrc'


"=====================================================
"" Airline settings
"=====================================================

let g:airline_theme = 'dracula'
let g:get_airline_powerline_fonts = 1
let g:airline_right_alt_sep = ''
let g:airline_right_sep = ''
let g:airline_left_alt_sep= ''
let g:airline_left_sep = ''
let g:airline#extensions#branch#format = 2
let g:airline#extensions#branch#enabled = 1

" Enable ALE extensions in Airline
let g:airline#extensions#ale#enabled = 1


"=====================================================
"" Fugitive / Rhubarb settings
"=====================================================

" Make going up a level easier for buffers with tree or blob
autocmd User fugitive
  \ if fugitive#buffer().type() =~# '^\%(tree\|blob\)$' |
  \   nnoremap <buffer> .. :edit %:h<CR> |
  \ endif

" Autoclean buffer when traversing git repo
autocmd BufReadPost fugitive://* set bufhidden=delete

" Diff remaps
nmap <leader>gh diffget //2<CR>
nmap <leader>gl diffget //3<CR>

"=====================================================
"" fzf-checkout settings
"=====================================================

" Define a diff of two branches with Fugitive
let g:fzf_branch_actions = {
      \ 'diff': {
      \   'prompt': 'Diff> ',
      \   'execute': 'Git diff {branch}',
      \   'multiple': v:false,
      \   'keymap': 'ctrl-f',
      \   'required': ['branch'],
      \   'confirm': v:false,
      \ },
      \}


"=====================================================
"" fzf settings
"=====================================================

" Enabling fzf (installed using Homebrew)
set rtp+=/usr/local/opt/fzf

" Add namespace for fzf.vim exported commands
let g:fzf_command_prefix = 'Fzf'

" Use preview when FzfFiles runs in fullscreen
command! -nargs=? -bang -complete=dir Files
  \ call fzf#vim#files(<q-args>,
  \   <bang>0 ? fzf#vim#with_preview('up:60%')
  \           : fzf#vim#with_preview('right:50%:hidden', '?'),
  \   <bang>0)

" Make Ripgrep ONLY search file contents
command! -bang -nargs=* Rg
  \ call fzf#vim#grep(
  \   'rg --column --line-number --hidden --ignore-case --no-heading --color=always '.shellescape(<q-args>), 1,
  \   <bang>0 ? fzf#vim#with_preview({'options': '--delimiter : --nth 4..'}, 'up:60%')
  \           : fzf#vim#with_preview({'options': '--delimiter : --nth 4..'}, 'right:50%:hidden', '?'),
  \   <bang>0)

" Mappings
nnoremap <silent> <leader>o :FzfFiles<CR>
nnoremap <silent> <leader>O :FzfFiles!<CR>
nnoremap <silent> <leader>b  :FzfBuffers<CR>
nnoremap <silent> <leader>rg  :FzfRg<CR>
nnoremap <silent> <leader>RG  :FzfRg!<CR>
nnoremap <silent> <leader>bl :FzfBLines<CR>
nnoremap <silent> <leader>S :FzfSnippets<CR>
nnoremap <silent> <leader>`  :FzfMarks<CR>
nnoremap <silent> <leader>p :FzfCommands<CR>
" nnoremap <silent> <leader>t :FzfFiletypes<CR>
nnoremap <silent> <F1> :FzfHelptags<CR>
inoremap <silent> <F1> <ESC>:FzfHelptags<CR>
cnoremap <silent> <expr> <C-p> getcmdtype() == ":" ? "<C-u>:FzfHistory:\<CR>" : "\<ESC>:FzfHistory/\<CR>"
cnoremap <silent> <C-_> <C-u>:FzfCommands<CR>


"=====================================================
"" vim-markdown, vim-markdown-preview settings
"=====================================================

let vim_markdown_preview_hotkey='<C-M>'
let vim_markdown_preview_github=1
let vim_markdown_preview_browser='Google Chrome'
let vim_markdown_preview_pandoc=1

let g:vim_markdown_folding_disabled = 1
let g:vim_markdown_auto_insert_bullets = 0
let g:vim_markdown_new_list_item_indent = 0

" Avoid overwriting ]c map (vim-unimpaired)
map <Plug> <Plug>Markdown_MoveToCurHeader


"=====================================================
"" vimtex, settings
"====================================================d

let g:tex_flavor= 'latex'
let g:vimtex_view_method = 'skim'
let g:vimtex_view_general_options = '-r @line @pdf @tex'
let g:vimtex_quickfix_mode = 0
let g:vimtex_fold_enabled = 1


"=====================================================
"" Tex-conceal settings
"=====================================================

set conceallevel=1
let g:tex_conceal='abdmg'
hi Conceal ctermbg=none


"=====================================================
"" UltiSnips settings
"=====================================================

let g:UltiSnipsEnableSnipMate = 0
let g:UltiSnipsExpandTrigger = '<tab>'
let g:UltiSnipsJumpForwardTrigger = '<tab>'
let g:UltiSnipsJumpBackwardTrigger = '<s-tab>'
let g:UltiSnipsSnippetDirectories = [$HOME.'/.vim/plugged/vim-snippets/UltiSnips', $HOME.'/.vim/UltiSnips']


"=====================================================
"" NERDTree settings
"=====================================================

" Open NERDTree
map <leader>nt :NERDTreeToggle<cr>
map <leader>ntb :NERDTreeFromBookmark<Space>
map <leader>ntf :NERDTreeFind<cr>

" Automatically close NERDTree on opening file
let NERDTreeQuitOnOpen = 1

" Automatically delete file buffer of deleted file in NERDTree
let NERDTreeAutoDeleteBuffer = 1

" NERDTree shows dotfiles by default
let NERDTreeShowHidden = 1

" Autoclose VIM if NERDTree is only window open
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif


"=====================================================
"" Limelight settings
"=====================================================

let g:limelight_conceal_ctermfg = 238
let g:limelight_paragraph_span = 1


"=====================================================
"" tabular settings
"=====================================================

let g:haskell_tabular = 1

vmap t= :Tabularize /=<CR>
vmap t; :Tabularize /::<CR>
vmap t- :Tabularize /-><CR>


"=====================================================
"" vim-slime settings
"=====================================================

let g:slime_target = "tmux"
let g:slime_default_config = {"socket_name": "default", "target_pane": "{last}"}
let g:slime_python_ipython = 1


"=====================================================
"" vim-test settings
"=====================================================

" Control keymappings
nmap <silent> t<C-n> :TestNearest<CR>
nmap <silent> t<C-f> :TestFile<CR>
nmap <silent> t<C-s> :TestSuite<CR>
nmap <silent> t<C-l> :TestLast<CR>
nmap <silent> t<C-v> :TestVisit<CR>

" Choose strategy to run tests
let test#strategy = "basic"


"=====================================================
"" File-specific settings
"=====================================================

" Automatically reread file if changed outside of vim
set autoread
autocmd FocusGained,BufEnter,CursorHold,CursorHoldI *
  \ if mode() !~ '\v(c|r.?|!|t)' && getcmdwintype() == '' | checktime | endif
autocmd FileChangedShellPost *
  \ echohl WarningMsg | echo "File changed on disk. Buffer reloaded." | echohl None

" C settings
augroup C autocmd!
    au BufNewFile,BufRead *.{c,cpp,h}
      \ set tabstop=4 shiftwidth=4 expandtab textwidth=80
      \ autoindent smartindent noshowmatch
augroup END

" Python settings
augroup Python autocmd!
    au BufNewFile,BufRead *.py
      \ set tabstop=4 shiftwidth=4 expandtab textwidth=80
      \ autoindent smartindent
augroup END

" Javascript settings
augroup Javascript autocmd!
    au BufNewFile,BufRead *.js
      \ set tabstop=4 softtabstop=4 shiftwidth=4 expandtab textwidth=80
      \ autoindent smartindent noshowmatch
augroup END

" SQL settings
augroup SQL autocmd!
    au BufNewFile,BufRead *.sql
      \ set tabstop=2 shiftwidth=2 expandtab textwidth=120 autoindent
      \ commentstring=--\ %s
augroup END

" Haskell settings
augroup SQL autocmd!
    au BufNewFile,BufRead *.{hs,lhs}
      \ set tabstop=2 softtabstop=2 shiftwidth=2 expandtab textwidth=120 autoindent
      \ commentstring=--\ %s
augroup END

" Textfile settings
augroup Textfiles autocmd!
    au BufNewFile,BufRead *.{md,markdown,mdown,mkd,mdtxt,Rmd,mkdn,tex,latex}
      \ set spell conceallevel=2 linebreak spelllang=en_us

    " Proper syntax highlighting for math mode
    au FileType latex,tex,md,markdown syn region match start=/\\$\\$/ end=/\\$\\$/
    au FileType latex,tex,md,markdown syn match math '\\$[^$].\{-}\$'

    " Fix spelling mistakes on fly
    au FileType latex,tex,md,markdown inoremap <C-l> <c-g>u<Esc>[s1z=`]a<c-g>u

    " Change SpellBad format (ALE uses SpellBad for lint highlighting)
    au FileType latex,tex,md,markdown highlight SpellBad ctermbg=None cterm=underline,bold ctermfg=9
augroup END

" YAML settings
augroup YAML autocmd!
    au BufNewFile,BufRead *.{yaml,yml}
      \ set filetype=yaml sts=2 sw=2 expandtab
augroup END

" JSON settings
augroup JSON autocmd! 
  au FileType json syntax match Comment +\/\/.\+$+
augroup END


"=====================================================
"" General settings
"=====================================================

" Use ripgrep as default grep
set grepprg=rg\ --vimgrep

" Set no wrapping
set nowrap

" Set allow modified buffers to be hidden
set hidden

" Lower updatetime
set updatetime=500

" Syntax highlighting
syntax on

augroup dracula_customization
  au!
  autocmd ColorScheme dracula highlight! link SpecialKey DraculaSubtle
  autocmd ColorScheme dracula hi CursorLine cterm=underline term=underline ctermbg=NONE
augroup END

" Set color schemes
let g:dracula_colorterm = 0
colorscheme dracula
set cursorline

" Make gutter blend in with line numbers
highlight clear SignColumn

" Clean up vertical window separator
set fillchars+=vert:│

" Show invisible characters; toggle with F5
set list listchars=tab:▷⋅,trail:⋅,nbsp:⋅
noremap <F5> :set list!<CR>
inoremap <F5> <C-o>:set list!<CR>
cnoremap <F5> <C-c>:set list!<CR>

" Set line numbers
set number
set relativenumber

" 80 character ruler
set ruler
set colorcolumn=89

" Show [], (), {} matched pair
set showmatch

" Enable enhanced tab autocompletion for menu (e.g., :e)
set wildmenu
set wildmode=longest:full,full
set wildignore+=**/.git/**

" Search down into subfolders
set path+=**

" Copy filename to clipboard
noremap <silent> <F4> :let @+=expand("%:p")<CR>

" Easier split navigation
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

" Vertical split opens on right
" Horizontal split opens on bottom
set splitbelow
set splitright

" Search settings
set shortmess-=S
set incsearch
augroup vimrc-incsearch-highlight
                  autocmd!
                  autocmd CmdlineEnter /,\? :set hlsearch
                  autocmd CmdlineLeave /,\? :set nohlsearch
                augroup END
set ignorecase
set smartcase

" Shortcut for search and replace a word
nnoremap <leader>srw :%s/\<<C-r><C-w>\>//g<Left><Left>

" Set UTF-8 by default
set enc=utf-8
set encoding=utf-8
set fileencoding=utf-8
set fileencodings=utf-8
set ttyfast

" Scroll let for 5 lines
set scrolloff=5

" ESC mappings
inoremap jk <Esc>
inoremap JK <Esc>
xnoremap jk <Esc>
cnoremap jk <C-c>
noremap <C-C> <ESC>
xnoremap <C-C> <ESC>

" Write/Quit mappings
cnoreabbrev W! w!
cnoreabbrev Q! q!
cnoreabbrev Qall! qall!
cnoreabbrev Wq wq
cnoreabbrev Wa wa
cnoreabbrev wQ wq
cnoreabbrev WQ wq
cnoreabbrev W w
cnoreabbrev Q q
cnoreabbrev Qall qall

" Italicize comments
highlight Comment cterm=italic gui=italic

" Set working directory
nnoremap <leader>. :lcd %:p:h<CR>

" Opens an edit command with path of the currently edited file filled in
noremap <leader>e :e <C-R>=expand("%:p:h") . "/" <CR>

" Opens a tab edit command with path of the currently edited file filled in
noremap <leader>te :tabe <C-R>=expand("%:p:h") . "/" <CR>

" Search mappings: These will make it so that going to the next one in a
" search will center on the line it's found in.
nnoremap n nzzzv
nnoremap N Nzzzv

"" Move visual block
vnoremap J :m '>+1<CR>gv=gv
vnoremap K :m '<-2<CR>gv=gv

" Mouse scroll behavior
set mouse=a

" Set tags file location
set tags=tags


"=====================================================
"" Miscellaneous settings
"=====================================================

" Write daily note on exit
autocmd BufWritePost *dailynote-*.md silent! execute "!bash buildnote.sh %:p" | redraw!

" Temporary netrw fix to open links with gx
if has('macunix')
  function! OpenURLUnderCursor()
    let s:uri = matchstr(getline('.'), '[a-z]*:\/\/[^ >,;()]*')
    let s:uri = shellescape(s:uri, 1)
    if s:uri != ''
      silent exec "!open '".s:uri."'"
      :redraw!
    endif
  endfunction
  nnoremap gx :call OpenURLUnderCursor()<CR>
endif
