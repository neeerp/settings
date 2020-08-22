syntax on

set tabstop=4 softtabstop=4
set shiftwidth=4
set expandtab
set smartindent
set nowrap
set scrolloff=4
set sidescrolloff=4

set splitbelow

set noswapfile
set nobackup
set undodir=~/.vim/undodir
set undofile
set shortmess+=c

" Incremental, contextually case sensitive search
set incsearch
set smartcase
set ignorecase

set mouse=a
set noerrorbells

" Snappier pop ups on hover
set updatetime=300

set cmdheight=1
set hidden

" Hybrid Absolute/Relative line numbers
set number
set relativenumber

" 80 character marker
set colorcolumn=80
highlight ColorColumn ctermbg=0 guibg=lightgrey

" Show signcolumn always - This is where the errors/warnings appear
if has("patch-8.1.1564")
  " Recently vim can merge signcolumn and number column into one
  set signcolumn=number
else
  set signcolumn=yes
endif

" Set leader key to space
let mapleader = " "


call plug#begin('~/.vim/plugged')

" Themes
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

Plug 'ryanoasis/vim-devicons'

" FS Explorer
Plug 'preservim/nerdtree'

" Search
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'jremmen/vim-ripgrep'

" Autocomplete, Language servers, and much much more
Plug 'neoclide/coc.nvim', { 'branch': 'master', 'do': 'yarn install --frozen-lockfile' }

" Git in vim
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'

" Undo tree git style
Plug 'mbbill/undotree'

" Comment out lines, Selectors for objects, '.' compatibility with plugins
Plug 'tpope/vim-surround'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-repeat'

" Toggleable indentation guides
Plug 'Yggdroot/indentLine'

"LaTeX preview
Plug 'lervag/vimtex'
Plug 'xuhdev/vim-latex-live-preview', { 'for': 'tex' }

" Markdown Preview
Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app & yarn install'  }

" Utility
Plug 'kassio/neoterm'
Plug 'vim-utils/vim-man'

call plug#end()

" Themes and Colors
set termguicolors
set t_Co=256

let g:airline_powerline_fonts = 1

" Gruvbox theme
colorscheme gruvbox
set background=dark

if executable('rg')
    let g:rg_derive_root='true'
endif

" Undo tree
nnoremap <leader>u :UndotreeShow<CR>

" Project viewer and search hotkeys
nnoremap <leader>pv :wincmd v<bar> :NERDTree <bar> :vertical resize 20<CR>
nnoremap <leader>ps :Rg<SPACE>
let NERDTreeMinimalUI=1

let NERDTreeIgnore=['\.aux$', '\.fdb_latexmk$', '\.fls$', '\.out$', '\.synctex.gz$', '\.*.xdv$', 'target']

" Window resize
nnoremap <silent> <leader>= :vertical resize +5<CR>
nnoremap <silent> <leader>- :vertical resize -5<CR>
nnoremap <silent> <leader>+ :resize +5<CR>
nnoremap <silent> <leader>_ :resize -5<CR>

" fugitive (Status, Select right, Select left)
nmap <leader>gs :G<CR>
nmap <leader>gj :diffget //3<CR>
nmap <leader>gf :diffget //2<CR>

" fzf
nnoremap <leader>pf :Files<CR>
nnoremap <C-p> :GFiles<CR>
let g:fzf_layout = { 'window': { 'width': 0.8, 'height': 0.8 } }
let $FZF_DEFAULT_OPTS='--reverse'

" Indent Guides
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
let g:coc_start_at_startup = 1

" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" GoTo Diagnostics (Errors/Warnings)
nmap <silent> <c-y> <Plug>(coc-diagnostic-next)
nmap <silent> <c-Y> <Plug>(coc-diagnostic-prev)

" Popup doc on cursor
nnoremap <silent> <C-e> :call <SID>show_documentation()<CR>

" Rename symbol
nmap <leader>rn <Plug>(coc-rename)

" Navigate autocomplete menus more intuitively
inoremap <expr> <C-j> pumvisible() ? "\<C-N>" : "<C-j>"
inoremap <expr> <C-k> pumvisible() ? "\<C-P>" : "<C-k>"

" Use tab for trigger completion with characters ahead and navigate.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

" Use <cr> to confirm completion, `<C-g>u` means break undo chain at current
" position. Coc only does snippet and additional edit on confirm.
" <cr> could be remapped by other vim plugin, try `:verbose imap <CR>`.
if exists('*complete_info')
  inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"
else
  inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
endif

" Applying codeAction to the selected region.
" Example: `<leader>aap` for current paragraph
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

nmap <silent> <leader>ff :call CocAction('format')<Cr>

" Remap keys for applying codeAction to the current buffer.
nmap <leader>ac  <Plug>(coc-codeaction)
" Apply AutoFix to problem on the current line.
nmap <leader>qf  <Plug>(coc-fix-current) 

" Add `:Fold` command to fold current buffer.
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" Add `:OR` command for organize imports of the current buffer.
command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')

"" Helpers
function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" LaTeX

let g:tex_flavor = 'latex'
let g:Tex_DefaultTargetFormat='pdf'
let g:Tex_CompileRule_pdf='pdflatex'
if has('nvim')
  let g:vimtex_compiler_progname = 'nvr'
endif


"""""""""""""""""""""""""""""""""'
" Markdown

" nnoremap <leader>mp <Plug>MarkdownPreview
" nnoremap <leader>ms <Plug>MarkdownPreviewStop
nmap <leader>mp <Plug>MarkdownPreviewToggle
