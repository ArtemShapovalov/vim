"let $MYVIMRC = '~/.vimrc'

" Автоматически перечитывать конфигурацию VIM после сохранения
autocmd! bufwritepost $MYVIMRC source $MYVIMRC

" Сочитание для Leader
let mapleader = ","

set confirm " использовать диалоги вместо сообщений об ошибках

"Не выгружать буфер, когда переключаемся на другой файл
set hidden

" Отключить оповещение об ошибка
set novb
 
" И нет детей Уганды
set shortmess+=I

" Открытие конфига по ,v
map <silent><leader>v :tabf ~/.vimrc<cr>

if v:lang =~ "utf8$" || v:lang =~ "UTF-8$"
   set fileencodings=utf-8,latin1
endif

set fileencodings=utf8,cp1251   " список предполагаемых кодировок, в порядке предпочтения

set nocompatible                " Use Vim defaults (much better!)
"set backup                     " keep a backup file
set viminfo='20,\"50            " read/write a .viminfo file, don't store more
                                " than 50 lines of registers
set history=128                 " Хранить больше истории команд ...
set undolevels=2048             " ... и правок
set undofile                    " Сохранение undo после закрытия файла
set undodir=~/.vim/undo/

set ruler                       " Всегда показывать положение курсора
set nu

" Only do this part when compiled with support for autocommands
if has("autocmd")
  augroup redhat
    " When editing a file, always jump to the last cursor position
    autocmd BufReadPost *
    \ if line("'\"") > 0 && line ("'\"") <= line("$") |
    \   exe "normal! g'\"" |
    \ endif
  augroup END
endif


if has("cscope") && filereadable("/usr/bin/cscope")
   set csprg=/usr/bin/cscope
   set csto=0
   set cst
   set nocsverb
   " add any database in current directory
   if filereadable("cscope.out")
      cs add cscope.out
   " else add database pointed to by environment
   elseif $CSCOPE_DB != ""
      cs add $CSCOPE_DB
   endif
   set csverb
endif

" Отслеживать изменения файлов
set autoread


set nowrap              " Отключение переноса длинных строк

set foldenable          " Фолдинг сворачивание кода
"set foldmethod=indent
"set foldmethod=marker
set foldmarker={,}

" Сохранение и восстановление фолдинга
au BufWinLeave * silent! mkview
au BufWinEnter * silent! loadview

" Switch syntax highlighting on, when the terminal has colors
" Also switch on highlighting the last used search pattern.
if &t_Co > 2 || has("gui_running")
  syntax on
  set hlsearch
endif

filetype on
filetype plugin indent on " определять подсветку на основе кода файла
augroup filetype
    autocmd BufNewFile,BufRead <Directory Path>/*.html set filetype=php
augroup END

" Set extra options when running in GUI mode
if has("gui_running")
    " Отключаем панель инструментов
    set guioptions-=T
    " Отключаем левый скролл
    set guioptions-=L
    " Отключаем меню
    set guioptions-=m
    " Отключение копирования при выделении
    set guioptions-=a

    "Антиалиасинг для шрифтов
    set antialias

    " Опции сессии
    set sessionoptions=curdir,buffers,tabpages ",resize,winpos,winsize

    " Сохранение сессии
    autocmd VimLeavePre * silent mksession! $HOME/.vim/session.vim

    set guitablabel=%M\ %t
endif

" set 256 colors
set t_Co=256

" Использование цветов для темного фона
set background=dark

" установка цвктовой схемы
colorscheme vitamins

" Подсветка спец символов
autocmd VimEnter,Colorscheme * :hi SpecialKey ctermfg=8

" Подсветка длины строки в 81 символ
set colorcolumn=81
" изменение цвета строки
highlight ColorColumn guibg=#2d2d2d ctermbg=246

" подсветка символов начиная с 120 позиции
highlight OverLength ctermbg=red ctermfg=white guibg=#592929
    match OverLength /\%120v.\+/

set ignorecase              " Игнорирование регистра при поиске

" блок меню
set wildmenu
set wcm=<Tab>

    " Меню Encoding -->
        " Выбор кодировки, в которой читать файл -->
            set wildmenu
            set wcm=<Tab>
            menu Encoding.Read.utf-8<Tab><F7> :e ++enc=utf8 <CR>
            menu Encoding.Read.windows-1251<Tab><F7> :e ++enc=cp1251<CR>
            menu Encoding.Read.koi8-r<Tab><F7> :e ++enc=koi8-r<CR>
            menu Encoding.Read.cp866<Tab><F7> :e ++enc=cp866<CR>
            map <F9> :emenu Encoding.Read.<TAB>
        " Выбор кодировки, в которой читать файл <--

        " Выбор кодировки, в которой сохранять файл -->
            set wildmenu
            set wcm=<Tab>
            menu Encoding.Write.utf-8<Tab><S-F7> :set fenc=utf8 <CR>
            menu Encoding.Write.windows-1251<Tab><S-F7> :set fenc=cp1251<CR>
            menu Encoding.Write.koi8-r<Tab><S-F7> :set fenc=koi8-r<CR>
            menu Encoding.Write.cp866<Tab><S-F7> :set fenc=cp866<CR>
            map <S-F9> :emenu Encoding.Write.<TAB>
        " Выбор кодировки, в которой сохранять файл <--

        " Выбор формата концов строк (dos - <CR><NL>, unix - <NL>, mac - <CR>) -->
            set wildmenu
            set wcm=<Tab>
            menu Encoding.End_line_format.unix<Tab><C-F7> :set fileformat=unix<CR>
            menu Encoding.End_line_format.dos<Tab><C-F7> :set fileformat=dos<CR>
            menu Encoding.End_line_format.mac<Tab><C-F7> :set fileformat=mac<CR>
            map <C-F9> :emenu Encoding.End_line_format.<TAB>
        " Выбор формата концов строк (dos - <CR><NL>, unix - <NL>, mac - <CR>) <--
    " Меню Encoding <--

map <F12> :emenu Encoding.<Tab>
" блок меню

"=====================================
"              Язык
"=====================================
" Языковые установ" Языковые
set keymap=russian-jcukenwin
" По умолчанию латинская раскладка
set iminsert=0
" По умолчанию латинская раскладка при поиске
set imsearch=0
" Работа с русскими словами (чтобы w, b, * понимали русские слова)
set iskeyword=@,48-57,_,192-255
" Проверка орфографии
set spelllang=ru_yo,en_us
" помощь на русском
" set helplang=ru

function! MyKeyMapHighlight()
   if &iminsert == 0 " при английской раскладке статусная строка текущего окна будет серого цвета
      hi StatusLine ctermfg=White guifg=White
   else " а при русской - зеленого.
      hi StatusLine ctermfg=DarkRed guifg=DarkRed
   endif
endfunction

call MyKeyMapHighlight() " при старте Vim устанавливать цвет статусной строки
autocmd WinEnter * :call MyKeyMapHighlight() " при смене окна обновлять информацию о раскладках
" использовать Ctrl+F для переключения раскладок
cmap <silent> <C-F> <C-^>
imap <silent> <C-F> <C-^>X<Esc>:call MyKeyMapHighlight()<CR>a<C-H>
nmap <silent> <C-F> a<C-^><Esc>:call MyKeyMapHighlight()<CR>
vmap <silent> <C-F> <Esc>a<C-^><Esc>:call MyKeyMapHighlight()<CR>gv

" Кодировка терминала
set termencoding=utf-8

" Всегда отображать командную строку
set laststatus=2

" Включаем отображение выполняемой в данный момент команды в правом нижнем углу экрана.
" К примеру, если вы наберете 2d, то в правом нижнем углу экрана Vim отобразит строку 2d.
set showcmd

" Включаем отображение дополнительной информации в статусной строке
"set statusline=%<%f%h%m%r%=format=%{&fileformat}\ file=%{&fileencoding}\ enc=%{&encoding}\ %b\ 0x%B\ %l,%c%V\ %P

nmap <F2> :w<CR>
vmap <F2> <esc>:w<cr>i
imap <F2> <esc>:w<cr>i


" C-\  комментировать/раскомментировать (при помощи NERD_Comment)
nmap <c-\> ,ci
vmap <c-\> ,cigv
imap <c-\> <esc>,cii

" вернуть отменённое назад
noremap <c-y> <C-R>
inoremap <c-y> <C-O><C-R>

set noautochdir
let NERDTreeChDirMode=2
let NERDTreeDirArrows=1
map  <F3> :NERDTreeToggle<CR>

if has("gui_running")
    set cursorline                          " Подсвечивать текущую строку в GUI режиме
    au VimEnter * NERDTree /home/artem/site       " Автоматическое открытие NERDTree
    let NERDTreeHighlightCursorline=1       " Подсветка файла под курсором
else
    set nocursorline                        " Не подсвечивать текущую строку в консоли
    let NERDTreeHighlightCursorline=0       " Отключение подсветки файла под курсором
endif


" Так как мы включили autoindent, то вставка текста с отступами (из буфера обмена X Window или screen) 
" будет «глючить» — отсупы будут «съезжать». К счастью, это легко исправить — нажав Ctrl+U сразу после вставки.
inoremap <silent> <C-u> <ESC>u:set paste<CR>.:set nopaste<CR>gi

" При редактировании файлов с длинными строками курсор часто «скачет» и передвигается не туда, куда хотелось бы. Сделаем, чтобы поведение курсора было похоже на обычные текстовые редакторы
nnoremap j gj
nnoremap k gk
vnoremap j gj
vnoremap k gk
nnoremap <Down> gj
nnoremap <Up> gk
vnoremap <Down> gj
vnoremap <Up> gk
inoremap <Down> <C-o>gj
inoremap <Up> <C-o>gk

" Zencoding 
imap <leader>z <c-y><leader>
map <leader>z <c-y><leader>
vmap <leader>z <c-y><leader>

" Перемещение между окнами по Ctrl+Стрелки
if has('gui_macvim')
    map <a-down> <c-w><down>
    imap <a-down> <esc><c-w><c-down>
    map <a-up> <c-w><up>
    imap <a-up> <esc><c-w><c-up>
    map <a-left> <c-w><left>
    imap <a-left> <esc><c-w><c-left>
    map <a-right> <c-w><right>
    imap <a-right> <esc><c-w><c-right>
else
    map <c-down> <c-w><down>
    imap <c-down> <esc><c-w><c-down>
    map <c-up> <c-w><up>
    imap <c-up> <esc><c-w><c-up>
    map <c-left> <c-w><left>
    imap <c-left> <esc><c-w><c-left>
    map <c-right> <c-w><right>
    imap <c-right> <esc><c-w><c-right>
endif

" Более привычные Page Up/Down, когда курсор остаётся в той же строке,
" а не переносится вверх/вниз экрана, как при стандартном PgUp/PgDown.
" Поскольку по умолчанию прокрутка по C-U/D происходит на полэкрана,
" привязка делается к двойному нажатию этих комбинаций.
nmap <PageUp> <C-U><C-U>
imap <PageUp> <C-O><C-U><C-O><C-U>
nmap <PageDown> <C-D><C-D>
imap <PageDown> <C-O><C-D><C-O><C-D>

" Новая вкладка
nmap <silent> <leader>tn :tabnew<cr>

" Закрыть вкладку
nmap <silent> <leader>tc :tabclose<cr>

" Предыдущая вкладка
map <c-s-left> :tabp<cr>
nmap <c-s-left> :tabp<cr>
imap <c-s-left> <esc>:tabp<cr>i

" Следующая вкладка
map <c-s-right> :tabn<cr>
nmap <c-s-right> :tabn<cr>
imap <c-s-right> <esc>:tabn<cr>i

" Переназначение Home http://vim.wikia.com/wiki/Smart_home
noremap <expr> <silent> <Home> col('.') == match(getline('.'),'\S')+1 ? '0' :'^'
imap <silent> <Home> <C-O><Home>

" Автодополнение слова

" SuperTab option for context aware completion
let g:SuperTabDefaultCompletionType = "context"
"let g:SuperTabMappingTabLiteral = '<c-space>'
"let g:SuperTabMappingForward = '<c-space>'
"let g:SuperTabMappingBackward = '<s-c-space>'

" Включение автодополнения
au FileType python set omnifunc=pythoncomplete#Complete
au FileType php set omnifunc=phpcomplete#CompletePHP
au FileType html set omnifunc=htmlcomplete#CompleteTag
au FileType xml set omnifunc=xmlcomplete#CompleteTag
au FileType javascript set omnifunc=javascriptcomplete#CompleteJ
au FileType css set omnifunc=csscomplete#CompleteC


"Не.отображать переменные в PHP-файлах, достаточно в .vimrc прописать строчку:
    let tlist_php_settings = 'php;c:class;f:function;d:constant'
" close all folds except for current file
    let Tlist_File_Fold_Auto_Close = 1
" make tlist pane active when opened
    let Tlist_GainFocus_On_ToggleOpen = 1
" width of window
    let Tlist_WinWidth = 30
" Automatically highlight the current tag in the taglist.
    let Tlist_Auto_Highlight_Tag = 1
" Open the taglist window when Vim starts.
    "let Tlist_Auto_Open = 1
" Automatically update the taglist to include newly edited files
    let Tlist_Auto_Update = 1
" Компактный вариант
    let Tlist_Compact_Format = 1
" Окно справа
    let Tlist_Use_Right_Window = 1
" Закрывать если одно окно Tlist
    let Tlist_Exit_OnlyWindow = 1
" Запуск/сокрытие плагина Tag List
    map <F4> :TlistToggle<CR>
    imap <F4> <Esc>:TlistToggle<CR>
    vmap <F4> <Esc>:TlistToggle<CR>


set nolist                " Отображение спецсимволов
"set listchars=tab:│┈,trail:·,nbsp:~

" Настройки табуляции табуляция равна 4 пробелам
set tabstop=4
" Двигать блоки в визуальном режиме на 4 пробела с помощью клавиш < и >
set shiftwidth=4
set softtabstop=4
set smarttab
set shiftround
"set noexpandtab | retab! "конверт пробелов в табы
set expandtab | retab "конверт табов в пробелы

" Автоотступы для новых строк
set autoindent
set nosmartindent

" При отступах не снимать выделение
vnoremap < <gv
vnoremap > >gv

"============CSS block================

    " Сортировка css свойств
    noremap <silent><leader>ss <esc>vi{:!sort<cr>:echo "Свойства css отсортированы!"<cr>
    " Форматирование css
    noremap <silent><leader>ct <esc>:%!/usr/share/vim/cssformatter.py<cr>:echo "Свойства css отформатированы!"<cr>

"============END CSS block================

" Заставляем BackSpace работать как x, т.е. удалять предыдущий символ
set backspace=indent,eol,start whichwrap+=<,>,[,]

set nobackup            " Запретить создание бэкапов
set noswapfile          " Запретить создание swap файлов

" Изменить цвет курсора в консоли при изменении режима ввода
"============CSS block================

if &term =~ "xterm" || &term =~ "xterm-256color" 
    let &t_SI = "\<Esc>]12;red\x7"
    let &t_EI = "\<Esc>]12;blue\x7"
endif

" Настройки подсветки отступов
let g:indent_guides_enable_on_vim_startup = 0
let g:indent_guides_auto_colors = 0
let g:indent_guides_color_change_percent = 5
let g:indent_guides_guide_size = 1

autocmd VimEnter,Colorscheme * :hi IndentGuidesOdd  guibg=grey18 ctermbg=4
autocmd VimEnter,Colorscheme * :hi IndentGuidesEven guibg=grey18 ctermbg=4


" ======= МЫШЬ========
" Включение поддержки мыши
set mouse=a
set mousemodel=popup

" Прятать курсор при наборе текста
set mousehide

" Разрешить визуальное выделение мышью
"set mouse=nvir
" ======= МЫШЬ=======



" Yii {{{
    " поиск по ключевым словам (что позволяет нажмите <Sk> на любое ключевое
    " слово)
    autocmd BufNewFile,Bufread *.php set keywordprg="help"



" Включаем фолдинг для блоков классов/функций
let php_folding = 1
    map <F5> <Esc>:EnableFastPHPFolds<Cr>
    map <F6> <Esc>:EnablePHPFolds<Cr>
    map <F7> <Esc>:DisablePHPFolds<Cr>


" PHP Documentor
inoremap <C-P> <ESC>:call PhpDocSingle()<CR>i
nnoremap <C-P> :call PhpDocSingle()<CR>
vnoremap <C-P> :call PhpDocRange()<CR>

let g:pdv_cfg_Type = 'mixed'
let g:pdv_cfg_Package = ''
let g:pdv_cfg_Version = '$id$'
let g:pdv_cfg_Author = 'Artem Shapovalov <artem@shapovalov.biz>'
let g:pdv_cfg_Copyright = 'Artem Shapovalov'
let g:pdv_cfg_License = 'PHP Version 5.3 {@link http://www.php.net/license/}'

" Обновление сниппетов
map <silent><leader>sm :call ReloadAllSnippets()<cr>:echo "Сниппеты перезагружены"<cr>

au Filetype php,html,xml,xsl source ~/.vim/scripts/closetag.vim


 
function! VarDebug()
    let  a=getline('.')
    let co=col('.')-1
    let starts=strridx(a," ",co)
    let ends = stridx(a," ",co)
    if ends==-1
        let ends=strlen(a)
    endif
    let res = strpart(a,starts+1,ends-starts)
    "[^(][$a-zA-Z0-9->:]*\((.*)\)*[^)]
    let res = matchstr(res, '\$*\<.*\>\(()\)*')
    "let res = expand('<cword>')
    "echo res
    if (strpart(res,0,1)!='$')
        let pref = '$'
    else
        let pref = ''
    endif
    let res =  'var_dump('.pref.res.');'
    let l:cursor = getpos(".") 
    call append (l:cursor[1], res)
endfunction

nmap <F8> :call VarDebug()<cr>
