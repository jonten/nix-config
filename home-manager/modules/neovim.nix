{ config, pkgs, ... }:
{
  #nixpkgs.overlays = [
  #  (import (builtins.fetchTarball {
  #    #url = https://github.com/nix-community/neovim-nightly-overlay/archive/master.tar.gz;
  #    # To use a pinned version and not having to build Neovim everytime you run 'home-manager switch' do:
  #    # Get the revision by choosing a commit from https://github.com/nix-community/neovim-nightly-overlay/commits/master
  #    url = "https://github.com/nix-community/neovim-nightly-overlay/archive/7ab23810d3844251fef656d7acc4bfbb2c4584bd.tar.gz";
  #    # Get the hash by running `nix-prefetch-url --unpack <url>` on the above url
  #    sha256 = "0vrjk4bs02dsmzc5r7b4qp9byavlz1bqm0b4f1hbgcf1miq4x19g";
  #  }))
  #];
  programs.neovim.enable = true;
  programs.neovim.plugins = with pkgs.vimPlugins; [
    ale
    i3config-vim
    lightline-ale
    lightline-bufferline
    lightline-vim
    fugitive
    nerdtree
    nvim-autopairs
    nvim-surround
    python-mode
    rainbow
    tabline-nvim
    vim-commentary
    vim-devicons
    vim-gitgutter
    vim-gruvbox8
    vim-go
    vim-graphql
    vim-hcl
    vim-helm
    vim-jinja
    vim-json
    vim-nix
    vim-scala
    vim-sensible
    vim-yaml
  ];
  programs.neovim.extraConfig = ''
    " Disable compatibility with vi which can cause unexpected issues.
    set nocompatible

    " Enable type file detection. Vim will be able to try to detect the type of file is use.
    filetype on

    " Enable plugins and load plugin for the detected file type.
    filetype plugin on

    " Load an indent file for the detected file type.
    filetype indent on

    " Turn syntax highlighting on.
    syntax on

    " Set the background tone.
    set background=dark

    " Set the color scheme.
    colorscheme gruvbox8_soft

    " Add numbers to the file.
    set number

    " Highlight cursor line underneath the cursor horizontally.
    set cursorline

    " Highlight cursor line underneath the cursor vertically.
    set cursorcolumn

    " Set shift width to 4 spaces.
    set shiftwidth=4

    " Set tab width to 4 columns.
    set tabstop=4

    " Use space characters instead of tabs.
    set expandtab

    " Do not save backup files.
    set nobackup

    " Do not let cursor scroll below or above N number of lines when scrolling.
    set scrolloff=10

    " Do not wrap lines. Allow long lines to extend as far as the line goes.
    set nowrap

    " While searching though a file incrementally highlight matching characters as you type.
    set incsearch

    " Ignore capital letters during search.
    set ignorecase

    " Override the ignorecase option if searching for capital letters.
    " This will allow you to search specifically for capital letters.
    set smartcase

    " Show partial command you type in the last line of the screen.
    set showcmd

    " Show the mode you are on the last line.
    set showmode

    " Show matching words during a search.
    set showmatch

    " Use highlighting when doing a search.
    set hlsearch

    " Set the commands to save in history default number is 20.
    set history=1000

    " Enable auto completion menu after pressing TAB.
    set wildmenu

    " Make wildmenu behave like similar to Bash completion.
    set wildmode=list:longest

    " There are certain files that we would never want to edit with Vim.
    " Wildmenu will ignore files with these extensions.
    set wildignore=*.docx,*.jpg,*.png,*.gif,*.pdf,*.pyc,*.exe,*.flv,*.img,*.xlsx

    " MAPPINGS ---------------------------------------------------------------

    " Set hidden and map buffer navigation
    set hidden
    nnoremap <silent> <C-n> :bnext<CR>
    nnoremap <silent> <C-p> :bprev<CR>

    " Set the backslash as the leader key.
    let mapleader = ","

    " Press \\ to jump back to the last cursor position.
    nnoremap <leader>, `` 

    " Press \p to print the current file to the default printer from a Linux operating system.
    " View available printers:   lpstat -v
    " Set default printer:       lpoptions -d <printer_name>
    " <silent> means do not display output.
    " nnoremap <silent> <leader>p :%w !lp<CR>

    " Type jj to exit insert mode quickly.
    inoremap jj <Esc>

    " Press the space bar to type the : character in command mode.
    nnoremap <space> :

    " Pressing the letter o will open a new line below the current one.
    " Exit insert mode after creating a new line above or below the current line.
    " nnoremap o o<esc>
    " nnoremap O O<esc>

    " Center the cursor vertically when moving to the next word during a search.
    nnoremap n nzz
    nnoremap N Nzz

    " Yank from cursor to the end of line.
    nnoremap Y y$

    " Map the F5 key to run a Python script inside Vim.
    " We map F5 to a chain of commands here.
    " :w saves the file.
    " <CR> (carriage return) is like pressing the enter key.
    " !clear runs the external clear screen command.
    " !python3 % executes the current file with Python.
    nnoremap <f5> :w <CR>:!clear <CR>:!python3 % <CR>

    " Map <wf> to write read only file with sudo
    nnoremap wf :w !sudo tee %<CR>

    " Pressing return clears highlighted search
    nnoremap <CR> :nohlsearch<CR>/<BS>

    " You can split the window in Vim by typing :split or :vsplit.
    " Navigate the split view easier by pressing CTRL+j, CTRL+k, CTRL+h, or CTRL+l.
    nnoremap <c-j> <c-w>j
    nnoremap <c-k> <c-w>k
    nnoremap <c-h> <c-w>h
    nnoremap <c-l> <c-w>l

    " Resize split windows using arrow keys by pressing:
    " CTRL+UP, CTRL+DOWN, CTRL+LEFT, or CTRL+RIGHT.
    noremap <c-up> <c-w>+
    noremap <c-down> <c-w>-
    noremap <c-left> <c-w>>
    noremap <c-right> <c-w><

    " NERDTree specific mappings.
    " Map the F3 key to toggle NERDTree open and close.
    nnoremap <F3> :NERDTreeToggle<cr>

    " Have nerdtree ignore certain files and directories.
    let NERDTreeIgnore=['\.git$', '\.jpg$', '\.mp4$', '\.ogg$', '\.iso$', '\.pdf$', '\.pyc$', '\.odt$', '\.png$', '\.gif$', '\.db$']

    " VIMSCRIPT --------------------------------------------------------------

    " If the current file type is HTML, set indentation to 2 spaces.
    autocmd Filetype html setlocal tabstop=2 shiftwidth=2 expandtab

    " If the current file type is YAML, set indentation to 2 spaces.
    autocmd Filetype yaml setlocal tabstop=2 shiftwidth=2 expandtab

    " If Vim version is equal to or greater than 7.3 enable undofile.
    " This allows you to undo changes to a file even after saving it.
    if version >= 703
        set undodir=~/.nvim/backup
        set undofile
        set undoreload=10000
    endif

    " You can split a window into sections by typing `:split` or `:vsplit`.
    " Display cursorline and cursorcolumn ONLY in active window.
    augroup cursor_off
        autocmd!
        autocmd WinLeave * set nocursorline nocursorcolumn
        autocmd WinEnter * set cursorline cursorcolumn
    augroup END

    " If GUI version of Vim is running set these options.
    if has('gui_running')

        " Set the background tone.
        set background=dark

        " Set the color scheme.
        colorscheme gruvbox8_soft

        " Set a custom font you have installed on your computer.
        " Syntax: <font_name>\ <weight>\ <size>
        set guifont=Monospace\ Regular\ 12

        " Display more of the file by default.
        " Hide the toolbar.
        set guioptions-=T

        " Hide the the left-side scroll bar.
        set guioptions-=L

        " Hide the the left-side scroll bar.
        set guioptions-=r

        " Hide the the menu bar.
        set guioptions-=m

        " Hide the the bottom scroll bar.
        set guioptions-=b

        " Map the F4 key to toggle the menu, toolbar, and scroll bar.
        " <Bar> is the pipe character.
        " <CR> is the enter key.
        nnoremap <F4> :if &guioptions=~#'mTr'<Bar>
            \set guioptions-=mTr<Bar>
            \else<Bar>
            \set guioptions+=mTr<Bar>
            \endif<CR>
    endif

    " PLUGINS ------------------------------------------------------------
    " RAINBOW PARENTHESIS ------------------------------------------------------------
    let g:rainbow_active = 1
    
    " LIGHTLINE STATUS LINE ------------------------------------------------------------
    let g:lightline#bufferline#show_number  = 2
    let g:lightline#bufferline#min_buffer_count = 2
    let g:lightline#bufferline#auto_hide = 3000
    let g:lightline#bufferline#enable_devicons = 1
    let g:lightline#bufferline#icon_position = 'left'

    let g:lightline                  = {}
    let g:lightline.tabline          = {'left': [['buffers']], 'right': [['close']]}
    let g:lightline.component_expand = {'buffers': 'lightline#bufferline#buffers'}
    let g:lightline.component_type   = {'buffers': 'tabsel'}

    nmap <Leader>1 <Plug>lightline#bufferline#go(1)
    nmap <Leader>2 <Plug>lightline#bufferline#go(2)
    nmap <Leader>3 <Plug>lightline#bufferline#go(3)
    nmap <Leader>4 <Plug>lightline#bufferline#go(4)
    nmap <Leader>5 <Plug>lightline#bufferline#go(5)
    nmap <Leader>6 <Plug>lightline#bufferline#go(6)
    nmap <Leader>7 <Plug>lightline#bufferline#go(7)
    nmap <Leader>8 <Plug>lightline#bufferline#go(8)
    nmap <Leader>9 <Plug>lightline#bufferline#go(9)
    nmap <Leader>0 <Plug>lightline#bufferline#go(10)

    nmap <Leader>c1 <Plug>lightline#bufferline#delete(1)
    nmap <Leader>c2 <Plug>lightline#bufferline#delete(2)
    nmap <Leader>c3 <Plug>lightline#bufferline#delete(3)
    nmap <Leader>c4 <Plug>lightline#bufferline#delete(4)
    nmap <Leader>c5 <Plug>lightline#bufferline#delete(5)
    nmap <Leader>c6 <Plug>lightline#bufferline#delete(6)
    nmap <Leader>c7 <Plug>lightline#bufferline#delete(7)
    nmap <Leader>c8 <Plug>lightline#bufferline#delete(8)
    nmap <Leader>c9 <Plug>lightline#bufferline#delete(9)
    nmap <Leader>c0 <Plug>lightline#bufferline#delete(10)
    '';
  
}
