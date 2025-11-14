" --- VIMRC --- "

" --- Autor: Danilo Marto de Carvalho <carvalho.dm@proton.me>
" --- Descrição: Customizei o VIM-Bootstrap para meu uso
" --- Font: https://vim-bootstrap.com/

" --- Vim-Plug Core --- "
let vimplug_exists=expand('~/.vim/autoload/plug.vim')
let curl_exists=expand('curl')

if !executable(curl_exists)
  echoerr "Você precisa ter o curl instalado para instalar o vim-plug!"
  execute "q!"
endif

if !filereadable(vimplug_exists)
  echo "Instalando o Vim-Plug..."
  echo ""
  silent exec "!"curl_exists" -fLo " . shellescape(vimplug_exists) . " --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim"
  let g:not_finish_vimplug = "yes"

  autocmd VimEnter * PlugInstall
endif

" --- Lista de plugins instalados
call plug#begin(expand('~/.vim/plugged'))
Plug 'itchyny/lightline.vim'
Plug 'preservim/nerdtree'
Plug 'preservim/tagbar'
Plug 'tpope/vim-commentary'
Plug 'raimondi/delimitmate'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'editorconfig/editorconfig-vim'
Plug 'jelera/vim-javascript-syntax'
Plug 'vim-scripts/c.vim', {'for': ['c', 'cpp']}
Plug 'ludwig/split-manpage.vim'
Plug 'fatih/vim-go', {'do': ':GoInstallBinaries'}
Plug 'racer-rust/vim-racer'
Plug 'rust-lang/rust.vim'
Plug 'mattn/emmet-vim'
Plug 'jelera/vim-javascript-syntax'
Plug 'mattn/emmet-vim'
Plug 'tpope/vim-endwise'
Plug 'prabirshrestha/async.vim'
Plug 'prabirshrestha/vim-lsp'
Plug 'prabirshrestha/asyncomplete.vim'
Plug 'prabirshrestha/asyncomplete-lsp.vim'
Plug 'dense-analysis/ale'
call plug#end()

" --- Geral

" Ativa o suporte a plugins, indentação e tipos de arquivo
filetype plugin indent on

" Configurações gerais de edição
set nobackup
set noswapfile
set history=256
set encoding=utf-8
set fileencoding=utf-8
set fileencodings=utf-8
set ttyfast
set hidden
set autoread
set wildmenu

" --- Aparência

" Ativa a sintaxe e define o esquema de cores
syntax on
colorscheme default

" Configurações da interface
set cmdheight=2
set showcmd
set ruler
set number
set scrolloff=3
set laststatus=2

" Configurações de divisão de janelas
set splitright
set splitbelow

" Configurações de títulos
set title
set titleold="Terminal"
set titlestring=%F

" Configurações de modeline
set modeline
set modelines=10

" Evita atualizações desnecessárias na tela durante a execução de macros
set lazyredraw

" --- Editor --- "

" Configurações de backspace
set backspace=indent,eol,start

" Configurações de tabulação e indentação
set tabstop=4
set softtabstop=0
set shiftwidth=4
set expandtab
set autoindent
set smartindent

" Configurações de busca
set hlsearch
set incsearch
set ignorecase
set smartcase

" Outras opções gerais
set nowrap

" Configurações do ALE (Asynchronous Lint Engine)
let g:ale_fix_on_save = 1
let g:ale_fixers = {
  \ '*': [
    \ 'remove_trailing_lines',
    \ 'trim_whitespace'
  \]
\}

" --- Comandos --- "

" Comando para remover espaços em branco ao final de cada linha
command! FixWhitespace :%s/\s\+$//e

" Configuração para a quebra de linhas automática, evitando redefinições desnecessárias
if !exists('*s:setupWrapping')
    function! s:setupWrapping()
      set wrap
      set wm=2
      set textwidth=79
    endfunction
endif

" --- Auto Comandos --- "

" Sincronização de sintaxe para arquivos grandes, limitando o número de linhas processadas
augroup vimrc-sync-fromstart
    autocmd!
    autocmd BufEnter * :syntax sync maxlines=200
augroup END

" Lembra a posição do cursor ao reabrir arquivos
augroup vimrc-remember-cursor-position
    autocmd!
    autocmd BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g`\"" | endif
augroup END

" Configuração de quebra de linha automática para arquivos de texto (.txt)
augroup vimrc-wrapping
    autocmd!
    autocmd BufRead,BufNewFile *.txt call s:setupWrapping()
augroup END

" --- Mapeamento --- "

" Define o líder do mapeamento
let mapleader=','

" Abreviações de comandos na linha de comando
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

" Configurações do NERDTree
let g:NERDTreeChDirMode=2
let g:NERDTreeIgnore=['node_modules', '\.rbc$', '\~$', '\.pyc$', '\.db$', '\.sqlite$', '__pycache__']
let g:NERDTreeSortOrder=['^__\.py$', '\/$', '*', '\.swp$', '\.bak$', '\~$']
let g:NERDTreeShowBookmarks=1
let g:nerdtree_tabs_focus_on_files=1
let g:NERDTreeMapOpenInTabSilent = '<RightMouse>'
let g:NERDTreeWinSize = 50

" Ignora arquivos e diretórios específicos durante a busca
set wildignore+=*/tmp/*,*.so,*.swp,*.zip,*.pyc,*.db,*.sqlite,*node_modules/
set wildignore+=*.o,*.obj,.git,*.rbc,*.pyc,__pycache__

" Mapeamentos para NERDTree e Tagbar
nnoremap <silent> <F2> :NERDTreeFind<CR>
nnoremap <silent> <F3> :NERDTreeToggle<CR>
nnoremap <F4> :TagbarToggle<CR>

" Comando FZF para busca
let $FZF_DEFAULT_COMMAND = "find * -path '*/\.*' -prune -o -path 'node_modules/**' -prune -o -path 'target/**' -prune -o -path 'dist/**' -prune -o -type f -print -o -type l -print 2> /dev/null"

" Configura o FZF para usar 'ag' (The Silver Searcher) caso esteja disponível
if executable('ag')
  let $FZF_DEFAULT_COMMAND = 'ag --hidden --ignore .git -g ""'
  set grepprg=ag\ --nogroup\ --nocolor  " Define 'ag' como ferramenta de grep
endif

" Configura o FZF para usar 'rg' (ripgrep) se estiver disponível, preferindo 'rg' a 'ag'
if executable('rg')
  let $FZF_DEFAULT_COMMAND = 'rg --files --hidden --follow --glob "!.git/*"'
  set grepprg=rg\ --vimgrep  " Define 'rg' como ferramenta de grep

  " Comando personalizado 'Find' para procurar arquivos e conteúdo
  command! -bang -nargs=* Find call fzf#vim#grep(
  \ 'rg --column --line-number --no-heading --fixed-strings --ignore-case --hidden --follow --glob "!.git/*" --color "always" '.
  \ shellescape(<q-args>). '| tr -d "\017"',
  \ 1, <bang>0)
endif

" Mapeamentos para divisão de janelas
noremap <Leader>h :<C-u>split<CR>
noremap <Leader>v :<C-u>vsplit<CR>

" Navegação entre guias
nnoremap <Tab> gt
nnoremap <S-Tab> gT
nnoremap <leader><Tab> :tabnew<CR>

" Navegação entre buffers
noremap <leader>q :bp<CR>
noremap <leader>w :bn<CR>
noremap <leader>c :bd<CR>

" Limpa a pesquisa visualmente
nnoremap <silent> <leader><space> :noh<cr>

" Navegação entre janelas
noremap <C-j> <C-w>j
noremap <C-k> <C-w>k
noremap <C-l> <C-w>l
noremap <C-h> <C-w>h

" Manter seleção ao recuar ou avançar no modo visual
vmap < <gv
vmap > >gv
