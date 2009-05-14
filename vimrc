" vim:foldmethod=marker commentstring="%s

" General options {{{
" Miscellaneous {{{
set nocompatible

" indentation and plugins
filetype indent plugin on

" automatically flush to disk when using :make, etc.
set autowrite

" automatically read in external changes if we haven't modified the buffer
set autoread

" everything needs to be unicode. EVERYTHING
set encoding=utf8

" always join with just one space, even between sentences
set nojoinspaces

" vim has pretty nice mouse support, in terminals that support it
if has('mouse')
    set mouse=a
endif

" don't move the cursor to the start of the line when changing buffers
set nostartofline
"}}}
" Display {{{
" color!
syntax on

" lines, cols in status line
set ruler

" display more information in the ruler
set rulerformat=%40(%=%t%h%m%r%w%<\ (%n)\ %4.7l,%-7.(%c%V%)\ %P%)

" current mode in status line
set showmode

" display the number of (characters|lines) in visual mode, also cur command
set showcmd

" a - terse messages (like [+] instead of [Modified]
" o - don't show both reading and writing messages if both occur at once
" t - truncate file names
" T - truncate messages rather than prompting to press enter
" W - don't show [w] when writing
" I - no intro message when starting vim fileless
set shortmess=aotTWI

" no extra status lines
set laststatus=0

" display as much of the last line as possible if it's really long
" also display unprintable characters as hex
set display+=lastline,uhex

" give three lines of context when moving the cursor around
set scrolloff=3

" don't redraw the screen during macros etc (NetHack's runmode:teleport)
set lazyredraw

" highlight all matches, we'll see if this works with a different hilight
set hlsearch

" highlight matching parens for .2s
set showmatch
set matchtime=2

" threshold for reporting number of lines changed
set report=0

" I generally don't want to have to space through things.. :)
set nomore

" only show a menu for completion, never a preview window or things like that
set completeopt=menuone

" hide the mouse in the gui while typing
set mousehide
" Language specific features {{{
" Perl {{{
" highlight advanced perl vars inside strings
let perl_extended_vars=1

" POD!
let perl_include_pod=1

" perl needs lots of syncing...
let perl_sync_dist=1000
" }}}
" }}}
"}}}
" Improve power of commands {{{
" incremental search!
set incsearch

" make tilde (flip case) an operator
set tildeop

" backspace over autoindent, end of line (to join lines), and preexisting test
set backspace=indent,eol,start

" tab completion in ex mode
set wildmenu

" when doing tab completion, ignore files with any of the following extensions
set wildignore+=.log,.out,.o

" remember lotsa fun stuff
set viminfo=!,'1000,f1,/1000,:1000,<1000,@1000,h,n~/.viminfo

" add : as a file-name character (mostly for Perl's mod::ules)
set isfname+=:

" tab completion stuff for the command line
set wildmode=longest,list,full

" always make the help window cover the entire screen
set helpheight=9999

if exists("+undofile")
    set undofile
endif
"}}}
" Make vim less whiny {{{
" :bn with a change in the current buffer? no prob!
set hidden

" no bells whatsoever
set vb t_vb=

" if you :q with changes it asks you if you want to continue or not
set confirm

" 50 milliseconds for escape timeout instead of 1000
set ttimeoutlen=50

" send more data to the terminal in a way that makes the screen update faster
set ttyfast
"}}}
" Indentation {{{
" no-longer skinny tabs!
set tabstop=4

" set to the same as tabstop (see #4 in :help tabstop)
set shiftwidth=4

" if it looks like a tab, we can delete it like a tab
set softtabstop=4

" no tabs! spaces only..
set expandtab

" < and > will hit indentation levels instead of always -4/+4
set shiftround

" new line has indentation equal to previous line
set autoindent

" braces affect autoindentation
set smartindent
"}}}
" Folding {{{
" fold only when I ask for it damnit!
set foldmethod=marker

" close a fold when I leave it
set foldclose=all
"}}}
"}}}
" Colors {{{
" default colorscheme {{{
" I hate the bright colors that go with bg=dark, even though my bg is black
set bg=light
" }}}
" word completion menu {{{
highlight Pmenu      ctermfg=grey  ctermbg=darkblue
highlight PmenuSel   ctermfg=red   ctermbg=darkblue
highlight PmenuSbar  ctermbg=cyan
highlight PmenuThumb ctermfg=red

highlight WildMenu ctermfg=grey ctermbg=darkblue
"}}}
" folding {{{
highlight Folded     ctermbg=black ctermfg=darkgreen
"}}}
" hlsearch {{{
highlight Search NONE ctermfg=lightred
"}}}
" color end of line whitespace {{{
autocmd InsertEnter * syn clear EOLWS | syn match EOLWS excludenl /\s\+\%#\@!$/
autocmd InsertLeave * syn clear EOLWS | syn match EOLWS excludenl /\s\+$/
hi EOLWS ctermbg=red
" }}}
"}}}
" Autocommands {{{
" When editing a file, always jump to the last cursor position {{{
autocmd BufReadPost *
\  if line("'\"") > 0 && line("'\"") <= line("$") |
\    exe "normal g`\"" |
\  endif
"}}}
" Auto +x {{{
au BufWritePost *.{sh,pl} silent exe "!chmod +x %"
"}}}
" Perl :make does a syntax check {{{
autocmd FileType perl setlocal makeprg=$VIMRUNTIME/tools/efm_perl.pl\ -c\ %\ $*
autocmd FileType perl setlocal errorformat=%f:%l:%m
autocmd FileType perl setlocal keywordprg=perldoc\ -f
"}}}
" Syntax hilighting {{{
" Primarily for RT and Hiveminder
autocmd BufRead,BufNewFile share/html/* set syn=mason
" }}}
"}}}
" Insert-mode remappings/abbreviations {{{
" Hit <C-a> in insert mode after a bad paste (thanks absolon) {{{
inoremap <silent> <C-a> <ESC>u:set paste<CR>.:set nopaste<CR>gi
"}}}
" Words I misspell.. {{{
iabbrev lamdba lambda
iabbrev dvice device
"}}}
" }}}
" Normal-mode remappings {{{
" spacebar (in command mode) inserts a single character before the cursor
nmap <Space> i <Esc>r

" have Y behave analogously to D rather than to dd
nmap Y y$

" miscellaneous commands I use a lot, so deserve quick shortcuts
nnoremap \\ \
nmap \/ :nohl<CR>
nmap \n :set invnumber<CR>
nmap \c :make<CR>

" syntax coloring
nmap \ss :syntax sync fromstart<CR>
nmap \sm :set syn=mason<CR>:syntax sync fromstart<CR>
nmap \sp :set syn=perl<CR>:syntax sync fromstart<CR>

" make help easier to navigate
autocmd FileType help nnoremap <buffer> <CR> <C-]>
autocmd FileType help nnoremap <buffer> <BS> <C-T>

" darcs convenience mappings {{{
nmap <Leader>da  :execute 'w  <bar> !darcs add %'<CR>
nmap <Leader>dA  :execute 'wa <bar> !darcs amend-record'<CR>
nmap <Leader>dr  :execute 'wa <bar> !darcs record'<CR>
nmap <Leader>dR  :execute 'w  <bar> !darcs record %'<CR>
nmap <Leader>dn  :execute 'wa <bar> !darcs whatsnew   <bar> less'<CR>
nmap <Leader>dN  :execute 'w  <bar> !darcs whatsnew % <bar> less'<CR>
nmap <Leader>dd  :execute 'wa <bar> !darcs diff -u    <bar> less'<CR>
nmap <Leader>dD  :execute 'w  <bar> !darcs diff -u %  <bar> less'<CR>
nmap <Leader>dc  :execute '!darcs changes             <bar> less'<CR>
nmap <Leader>dqm :execute '!darcs query manifest      <bar> less'<CR>
nmap <Leader>dt  :execute '!darcs tag'<CR>
nmap <Leader>dp  :execute '!darcs push'<CR>
nmap <Leader>du  :execute '!darcs unrecord'<CR>
nmap <Leader>db  :execute "w <bar> :execute '!darcs revert %'   <bar> :silent execute 'e'"<CR>
nmap <Leader>dB  :execute "w <bar> :execute '!darcs unrevert %' <bar> :silent execute 'e'"<CR>
"}}}

" right and left switch buffers
nmap <Right> :bn<CR>
nmap <Left>  :bp<CR>

" up and down move by virtual line
nmap <Up>   gk
nmap <Down> gj

" damnit cbus, you've won me over (keep visual selection on in/out-dent)
vnoremap < <gv
vnoremap > >gv

" now search commands will re-center the screen
nmap n nzz
nmap N Nzz
nmap * *zz
nmap # #zz
nmap g* g*zz
nmap g# g#zz

" Nopaste \p {{{
function s:nopaste(visual)
    let nopaste_services = $NOPASTE_SERVICES
    if &filetype == 'tex'
        let $NOPASTE_SERVICES = "Mathbin ".$NOPASTE_SERVICES
    endif
 
    if a:visual
        silent exe "normal gv!nopaste\<CR>"
    else
        let pos = getpos('.')
        silent exe "normal gg!Gnopaste\<CR>"
    endif
    silent normal "+yy
    let @* = @+
    silent undo
    if a:visual
        normal gv
    else
        call setpos('.', pos)
    endif
    let $NOPASTE_SERVICES = nopaste_services
    echo @+
endfunction
nmap <silent> <Leader>p :call <SID>nopaste(0)<CR>
vmap <silent> <Leader>p :<C-U>call <SID>nopaste(1)<CR>
" }}}
"}}}
" Plugin settings {{{
" Rainbow {{{
let g:rainbow = 1
let g:rainbow_paren = 1
let g:rainbow_brace = 1
" just loading this directly from the plugin directory fails because language
" syntax files override the highlighting
" using BufWinEnter because that is run after modelines are run (so it catches
" modelines which update highlighting)
autocmd BufWinEnter * runtime plugin/rainbow_paren.vim
" }}}
" Textobj {{{
let g:Textobj_regex_enable = 1
let g:Textobj_fold_enable = 1
let g:Textobj_arg_enable = 1
" }}}
" Supertab {{{
let g:SuperTabMidWordCompletion = 0
let g:SuperTabDefaultCompletionType = 'context'
" }}}
" Enhanced Commentify {{{
let g:EnhCommentifyBindInInsert = 'No'
let g:EnhCommentifyRespectIndent = 'Yes'
" }}}
" }}}
