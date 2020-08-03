syntax on

set noerrorbells
set tabstop=4 softtabstop=4
set shiftwidth=4
set expandtab
set smartindent
set nu
set nowrap
set smartcase
set noswapfile
set nobackup
set undodir=~/.vim/undodir
set undofile
set incsearch
set mouse=a
set splitbelow

set updatetime=300
set shortmess+=c
set cmdheight=1

" Relative line numbers good
set relativenumber
set colorcolumn=80

" Show signcolumn always
if has("patch-8.1.1564")
  " Recently vim can merge signcolumn and number column into one
  set signcolumn=number
else
  set signcolumn=yes
endif

" let g:float_preview#docked = 0

highlight ColorColumn ctermbg=0 guibg=lightgrey

call plug#begin('~/.vim/plugged')

Plug 'morhetz/gruvbox'
Plug 'edkolev/promptline.vim'
Plug 'drewtempelmeyer/palenight.vim'
Plug 'altercation/vim-colors-solarized'
Plug 'thinkpixellab/flatland'
Plug 'rakr/vim-one'
Plug 'sickill/vim-monokai'
Plug 'NLKNguyen/papercolor-theme'

Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'itchyny/lightline.vim'
Plug 'shinchu/lightline-gruvbox.vim'

" Plug 'ncm2/float-preview.nvim'

Plug 'preservim/nerdtree'

Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-repeat'
Plug 'jremmen/vim-ripgrep'
Plug 'vim-utils/vim-man'
Plug 'lyuts/vim-rtags'
" Plug 'ycm-core/YouCompleteMe'
Plug 'mbbill/undotree'

Plug 'neoclide/coc.nvim', { 'branch': 'master', 'do': 'yarn install --frozen-lockfile' }

" Plug 'nathanaelkane/vim-indent-guides'
Plug 'Yggdroot/indentLine'

" God bless easy commenting in/out
Plug 'tpope/vim-commentary'

" Terminal
Plug 'kassio/neoterm'

call plug#end()

" Themes and Colors
set termguicolors
set t_Co=256

let g:airline_powerline_fonts = 1
let g:lightline = {}

" colorscheme palenight

" Gruvbox theme
colorscheme gruvbox
set background=dark

let g:airline_theme='gruvbox'
let g:lightline.colorscheme = 'gruvbox'


" PaperColor theme
" colorscheme PaperColor
" set background=light

" let g:PaperColor_ThemeOptions = {
"   \   'theme': {
"   \     'default': {
"   \       'transparent_background': 1,
"   \       'allow_bold': 1,
"   \       'allow_italic': 1
"   \     }
"   \   }
"   \ }

" let g:airline_theme='papercolor'
" let g:lightline = {'colorscheme': 'PaperColor',}

if executable('rg')
    let g:rg_derive_root='true'
endif

let mapleader = " "

" let g:ctrlp_user_command = ['.git/', 'git --git-dir=%s/.git ls-files -oc --exclude-standard']
let g:netrw_browse_split = 2
let g:netrw_banner = 0
let g:netrw_winsize = 25

let g:ctrlp_use_caching = 0


" Undo tree
nnoremap <leader>u :UndotreeShow<CR>

" Project viewer
nnoremap <leader>pv :wincmd v<bar> :NERDTree <bar> :vertical resize 20<CR>

" Project search
nnoremap <leader>ps :Rg<SPACE>

" Window resize
nnoremap <silent> <leader>= :vertical resize +5<CR>
nnoremap <silent> <leader>- :vertical resize -5<CR>
nnoremap <silent> <leader>+ :resize +5<CR>
nnoremap <silent> <leader>_ :resize -5<CR>

" fugitive
nmap <leader>gs :G<CR>
nmap <leader>gj :diffget //3<CR>
nmap <leader>gf :diffget //2<CR>

" fzf
nnoremap <C-p> :GFiles<CR>
nnoremap <leader>pf :Files<CR>
let g:fzf_layout = { 'window': { 'width': 0.8, 'height': 0.8 } }
let $FZF_DEFAULT_OPTS='--reverse'

" highlight yanks!
augroup highlight_yank
    autocmd!
    autocmd TextYankPost * silent! lua require'vim.highlight'.on_yank()
augroup END

" NERDtree
let NERDTreeMinimalUI=1

" Indent Guides
" let g:indent_guides_enable_on_vim_startup = 1
let g:indentLine_char = '▏'
let g:indentLine_enabled = 0
let g:indentLine_setColors = 0
nnoremap <silent> <leader>gi :IndentLinesToggle<CR>

"""""""""""""""""""""""""""""""""'
" Switching windows quickly
nnoremap <leader>h :wincmd h<CR>
nnoremap <leader>j :wincmd j<CR>
nnoremap <leader>k :wincmd k<CR>
nnoremap <leader>l :wincmd l<CR>

tnoremap <C-space>h <C-\><C-N>:wincmd h<CR>
tnoremap <C-space>j <C-\><C-N>:wincmd j<CR>
tnoremap <C-space>k <C-\><C-N>:wincmd k<CR>
tnoremap <C-space>l <C-\><C-N>:wincmd l<CR>
tnoremap <C-space>p <C-\><C-N>:wincmd p<CR>
tnoremap <C-space><space> <C-\><C-N>

" Terminal at bottom of screen toggles
" nnoremap <leader>t :call CreateTerm("term-slider")<CR>
nnoremap <C-space>j :call CreateTerm("term-slider")<CR>
tnoremap <C-space>t <C-\><C-N>:call CreateTerm("term-slider")<CR>
 
function! CreateTerm(termname)
    let pane = bufwinnr(a:termname)
    let buf = bufexists(a:termname)
    if pane > 0
        " pane is visible
        if pane == winnr()
            :exe pane . "wincmd p"
        else
            :exe pane . "wincmd w" | :startinsert
        endif
    elseif buf > 0
        " buffer is not in pane
        :exe "botright split" | :resize 10 | :startinsert
        :exe "buffer " . a:termname
    else
        " buffer is not loaded, create
        :exe "botright split" | :resize 10
        :terminal
        :exe "f " a:termname
        :exe "startinsert"
    endif
endfunction
"""""""""""""""""""""""""""""""""'

"""""""""""""""""""""""""""""""""'
" COC

" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Popup Docs
nnoremap <silent> <C-e> :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

" Use tab for trigger completion with characters ahead and navigate.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <cr> to confirm completion, `<C-g>u` means break undo chain at current
" position. Coc only does snippet and additional edit on confirm.
" <cr> could be remapped by other vim plugin, try `:verbose imap <CR>`.
if exists('*complete_info')
  inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"
else
  inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
endif


let g:coc_start_at_startup = 1
set hidden

inoremap <expr> <C-j> pumvisible() ? "\<C-N>" : "<C-j>"
inoremap <expr> <C-k> pumvisible() ? "\<C-P>" : "<C-k>"

