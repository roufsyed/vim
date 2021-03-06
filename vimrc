"-------------------------------------------------------------------------------------------------------------------------------------------------
"Basic setters
"-------------------------------------------------------------------------------------------------------------------------------------------------
set nu rnu 		 "set number and relative number
set wrap   		 "line wrapper
set linebreak    "Sends entire word to next line rather than a single letter(WordWrap)
set t_SH = "5" 	 "for setting cursor style in vim while :term is executed
set t_Co=256
"au BufAdd,BufNewFile,BufRead * nested tab sball     "opens all the new file/buffers in tabs by default

colorscheme jellybeans  "setting colorscheme

"STATUSLINE CONFIG
set laststatus=2  "To Show statusline (hidden by default)
set statusline=%<%f\ %h%m%r%=%-14.(%l,%c%V%)\ %P "To see the file name in the satus line (if removes, status line will show prettier)
" now set it to change the status line based on mode
if version >= 700
  au InsertEnter * hi StatusLine term=reverse ctermbg=8 ctermfg=0 
  au InsertLeave * hi StatusLine term=reverse ctermfg=0 ctermbg=2 
endif
" default the statusline to green when entering Vim
au vimenter * hi statusline ctermbg=2 ctermfg=0 

set nohlsearch	" Highlight all search results
set smartcase	" Enable smart-case search
set ignorecase	" Always case-insensitive
set incsearch	" Searches for strings incrementally

set tabstop=4 
set softtabstop=4 
set shiftwidth=4 
set textwidth=120 
set expandtab 
set smartindent
set autoindent 
set fileformat=unix 

let NERDTreeMinimalUI = 1
let NERDTreeDirArrows = 1

"The below code sets tab config to specific files mentioned only.
"Tab configurations for various languages
" au BufNewFile,BufRead *.py,*.java,*.cpp,*.c,*.rkt,*.h,.*.js,*.jsx,*.mjs,*.ts,*.tsx,*.css,*.less,*.scss,*.json,*.graphql,*.md,*.vue,*.yaml,*.html,*.php 
"     \ set tabstop=4 |
"     \ set softtabstop=4 |
"     \ set shiftwidth=4 |
"     \ set textwidth=120 |
"     \ set expandtab |
"     \ set autoindent |
"     \ set fileformat=unix |


"Cpp skeleton
":autocmd BufNewFile *.cpp 0r ~/.vim/templates/skeleton.cpp

"-------------------------------------------------------------------------------------------------------------------------------------------------
"Hotkey configurations
"-------------------------------------------------------------------------------------------------------------------------------------------------
"NerdTree stuff
"autocmd vimenter * NERDTree
map <F2> :NERDTreeToggle<CR>
let g:NERDTreeWinPos = "right" "sets nerd tree to right

"Code compilation mappings
autocmd filetype python map <F3> :!clear && python3 %<CR>
autocmd filetype cpp map <F3> :!clear && g++ -std=c++14 % && ./a.out<CR>
autocmd filetype java map <F3> :w <bar> !javac % && java %:r <CR>

"Specific to /home/cp.cpp for competitive programming. n"
let g:closetag_xhtml_filenames = '*.xhtml,*.jsx'

" filetypes like xml, html, xhtml, ...
" These are the file types where this plugin is enabled.
"
let g:closetag_filetypes = 'html,xhtml,phtml'

" filetypes like xml, xhtml, ...
" This will make the list of non-closing tags self-closing in the specified files.
"
"Note: does not work without a file type. tried $
function! CP()
	:w
	:bel vert term
	:vertical resize 60
endfunction 
autocmd filetype cpp map <F12> :call CP()<CR>clear && g++ -std=c++14 cp.cpp && ./a.out <input.txt<CR>
autocmd filetype cpp map <F10> :call CP()<CR>clear && g++ -std=c++14  asd.cpp && ./a.out<CR>

"Same shit optimized above.
"map <F12> :w<CR>:bel vert term<CR><C-w>:vertical resize 60<CR>clear && g++ -std=c++14 cp.cpp && ./a.out<CR>

"Shortcuts
"Vertical terminal
map <C-t> :bel vert term<CR><C-w>:vertical resize 60<CR>
map <C-c> "+y
map <C-p> "+p

"-------------------------------------------------------------------------------------------------------------------------------------------------
"Plugs
"-------------------------------------------------------------------------------------------------------------------------------------------------
call plug#begin()
Plug 'preservim/nerdtree'
Plug 'tpope/vim-commentary'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
call plug#end()


"-------------------------------------------------------------------------------------------------------------------------------------------------
" coc default config from the github repo
"-------------------------------------------------------------------------------------------------------------------------------------------------
" Set internal encoding of vim, not needed on neovim, since coc.nvim using some
" unicode characters in the file autoload/float.vim
set encoding=utf-8

" TextEdit might fail if hidden is not set.
set hidden

" Some servers have issues with backup files, see #649.
set nobackup
set nowritebackup

" Give more space for displaying messages.
"set cmdheight=2

" Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
" delays and poor user experience.
set updatetime=300

" Don't pass messages to |ins-completion-menu|.
set shortmess+=c

" Always show the signcolumn, otherwise it would shift the text each time
" diagnostics appear/become resolved.
if has("nvim-0.5.0") || has("patch-8.1.1564")
  " Recently vim can merge signcolumn and number column into one
  set signcolumn=number
else
  set signcolumn=yes
endif

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

" Use <c-space> to trigger completion.
if has('nvim')
  inoremap <silent><expr> <c-space> coc#refresh()
else
  inoremap <silent><expr> <c-@> coc#refresh()
endif

" Make <CR> auto-select the first completion item and notify coc.nvim to
" format on enter, <cr> could be remapped by other vim plugin
inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

" Use `[g` and `]g` to navigate diagnostics
" Use `:CocDiagnostics` to get all diagnostics of current buffer in location list.
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window.
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  elseif (coc#rpc#ready())
    call CocActionAsync('doHover')
  else
    execute '!' . &keywordprg . " " . expand('<cword>')
  endif
endfunction

" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')

" Symbol renaming.
nmap <leader>rn <Plug>(coc-rename)

" Formatting selected code.
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder.
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Applying codeAction to the selected region.
" Example: `<leader>aap` for current paragraph
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

" Remap keys for applying codeAction to the current buffer.
nmap <leader>ac  <Plug>(coc-codeaction)
" Apply AutoFix to problem on the current line.
nmap <leader>qf  <Plug>(coc-fix-current)

" Map function and class text objects
" NOTE: Requires 'textDocument.documentSymbol' support from the language server.
xmap if <Plug>(coc-funcobj-i)
omap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap af <Plug>(coc-funcobj-a)
xmap ic <Plug>(coc-classobj-i)
omap ic <Plug>(coc-classobj-i)
xmap ac <Plug>(coc-classobj-a)
omap ac <Plug>(coc-classobj-a)

" Remap <C-f> and <C-b> for scroll float windows/popups.
if has('nvim-0.4.0') || has('patch-8.2.0750')
  nnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
  nnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
  inoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(1)\<cr>" : "\<Right>"
  inoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(0)\<cr>" : "\<Left>"
  vnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
  vnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
endif

" Use CTRL-S for selections ranges.
" Requires 'textDocument/selectionRange' support of language server.
nmap <silent> <C-s> <Plug>(coc-range-select)
xmap <silent> <C-s> <Plug>(coc-range-select)

" Add `:Format` command to format current buffer.
command! -nargs=0 Format :call CocAction('format')

" Add `:Fold` command to fold current buffer.
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" Add `:OR` command for organize imports of the current buffer.
command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')

" Add (Neo)Vim's native statusline support.
" NOTE: Please see `:h coc-status` for integrations with external plugins that
" provide custom statusline: lightline.vim, vim-airline.
set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

" Mappings for CoCList
" Show all diagnostics.
nnoremap <silent><nowait> <space>a  :<C-u>CocList diagnostics<cr>
" Manage extensions.
nnoremap <silent><nowait> <space>e  :<C-u>CocList extensions<cr>
" Show commands.
nnoremap <silent><nowait> <space>c  :<C-u>CocList commands<cr>
" Find symbol of current document.
nnoremap <silent><nowait> <space>o  :<C-u>CocList outline<cr>
" Search workspace symbols.
nnoremap <silent><nowait> <space>s  :<C-u>CocList -I symbols<cr>
" Do default action for next item.
nnoremap <silent><nowait> <space>j  :<C-u>CocNext<CR>
" Do default action for previous item.
nnoremap <silent><nowait> <space>k  :<C-u>CocPrev<CR>
" Resume latest coc list.
nnoremap <silent><nowait> <space>p  :<C-u>CocListResume<CR>
