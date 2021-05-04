set tabstop=4
set shiftwidth=4

set hidden
set mouse=a
"set ttyfast
"set wildmenu
"set wildchar=<TAB>

let g:vimwiki_list = [{'path': 'C:/Users/Linzi/AppData/Local/nvim/.vimwiki/', 'path_html': 'C:/Users/Linzi/AppData/Local/nvim/.vimwiki/', 'syntax' : 'markdown', 'ext' : '.md'}]
let g:vimwiki_global_ext = 0
let g:vimwiki_ext2syntax = {'.md': 'markdown', '.markdown': 'markdown', '.mdown': 'markdown'}


command! Diary VimwikiDiaryIndex
augroup vimwikiDiary
	autocmd!
	" automatically update links on Diary open
	autocmd BufRead,BufNewFile diary.md VimwikiDiaryGenerateLinks
augroup end


set spelllang=en_au
set spellfile=~/.vim/spell/en.utf8.add

hi clear SpellBad
hi SpellBad cterm=underline ctermfg=red

hi clear SpellCap
hi SpellCap cterm=underline ctermfg=blue

hi clear SpellLocal
hi SpellCap cterm=underline ctermfg=green

augroup prose
	autocmd!
	autocmd FileType markdown,mkd,md
		\ set spell spelllang=en_au
		\| call litecorrect#init() 
		\| call pencil#init({'wrap': 'soft'})
	autocmd FileType vimwiki
		\ set spell spelllang=en_au
		\| call pencil#init({'wrap': 'soft'}) 
		\| call litecorrect#init()
	autocmd FileType pug
		\ call pencil#init({'wrap': 'soft'}) 
		\| call litecorrect#init()

augroup END

au BufNewFile C:/Users/Linzi/AppData/Local/nvim/.vimwiki/diary/*.md :silent 0r !python C:/Users/Linzi/AppData/Local/nvim/bin/generate-vimwiki-diary-template.py '%'


set t_Co=256
set background=dark
colorscheme PaperColor

source $VIMRUNTIME/mswin.vim

call plug#begin('C:/Users/Linzi/AppData/Local/nvim/plugged')
" below are some vim plugins for demonstration purpose.
" add the plugin you want to use here.
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'vimwiki/vimwiki'
Plug 'preservim/vim-pencil'
Plug 'preservim/vim-litecorrect'
call plug#end()

