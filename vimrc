" An example for a vimrc file.
"
" Maintainer:	Bram Moolenaar <Bram@vim.org>
" Last change:	2019 Dec 17
"
" To use it, copy it to
"	       for Unix:  ~/.vimrc
"	      for Amiga:  s:.vimrc
"	 for MS-Windows:  $VIM\_vimrc
"	      for Haiku:  ~/config/settings/vim/vimrc
"	    for OpenVMS:  sys$login:.vimrc

" When started as "evim", evim.vim will already have done these settings, bail
" out.
if v:progname =~? "evim"
  finish
endif

" Get the defaults that most users want.
source $VIMRUNTIME/defaults.vim

if has("vms")
  set nobackup		" do not keep a backup file, use versions instead
else
  set backup		" keep a backup file (restore to previous version)
  if has('persistent_undo')
    set undofile	" keep an undo file (undo changes after closing)
  endif
endif

if &t_Co > 2 || has("gui_running")
  " Switch on highlighting the last used search pattern.
  set hlsearch
endif

" Put these in an autocmd group, so that we can delete them easily.
augroup vimrcEx
  au!

  " For all text files set 'textwidth' to 78 characters.
  autocmd FileType text setlocal textwidth=78
augroup END

" Add optional packages.
"
" The matchit plugin makes the % command work better, but it is not backwards
" compatible.
" The ! means the package won't be loaded right away but when plugins are
" loaded during initialization.
if has('syntax') && has('eval')
  packadd! matchit
endif


set tabstop=4
set shiftwidth=4

set hidden
set mouse=a
"set ttyfast
"set wildmenu
"set wildchar=<TAB>

let g:vimwiki_list = [{'path': '~/.vimwiki/', 'path_html': '~/.vimwiki_html/'}]

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
		\ call litecorrect#init() 
		\| call pencil#init({'wrap': 'soft'})
	autocmd FileType vimwiki
		\ set spell spelllang=en_au
		\| call pencil#init({'wrap': 'soft'}) 
		\| call litecorrect#init()
augroup END

au BufNewFile ~/.vimwiki/diary/*.wiki :silent 0r !~/.vim/bin/generate-vimwiki-diary-template '%'
