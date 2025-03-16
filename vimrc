"======================"
" GENERAL VIM SETTINGS "
"======================"

set nocompatible                                "use vim settings only (no vi)
set tabstop=4 shiftwidth=4 expandtab            "tab behavior
set encoding=utf-8                              "file encoding
syntax on                                       "standard syntax highlighting
set background=dark                             "default background color
colorscheme gruvbox                             "default color scheme
set autoindent                                  "indent on newline
set backspace=2                                 "backspace in insert mode
set history=50                                  "number of events to keep
set ignorecase                                  "ignore case while searching
set smartcase                                   "smart matching when using case in search
set incsearch                                   "incremental matches while searching
set number                                      "show line numbers
set relativenumber                              "relative line numbers to cursor
set cursorline                                  "highlight cursor line
set ruler                                       "cursor position in bottom corner
set viminfo='20,\"50                            "registers
set formatoptions=croq                          "comment format options (see help)
set textwidth=0                                 "no forced wrapping
set showcmd                                     "show length of selection
set complete=.,w,b,u                            "faster autocompletion: removed t and i option
set splitright                                  "vertical splits right
set splitbelow                                  "horizontal splits below
set scrolloff=15                                "lines to keep cursor distance from the edge
set mouse=a                                     "mouse mode
set breakindent                                 "wrapped lines continue visual indentation
set signcolumn=yes                              "display the signs in the gutter
set list                                        "list blank characters

"cursor line highlighting
hi CursorLine guibg=Grey30

"=======| Keybindings |========
"removes highlighting in normal mode
nmap <ESC> :nohlsearch<CR>

"require the lua config for neovim
"NOTE: leave this at the bottom of the file
if has('nvim')
    lua require("init")
endif

