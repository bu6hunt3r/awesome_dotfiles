mkdir -p $vim_deps && cd $vim_deps

# fetch core editing deps
dotgrab bronson/vim-visual-star-search
dotgrab chaoren/vim-wordmotion
dotgrab ervandew/supertab
dotgrab junegunn/fzf.vim
dotgrab junegunn/vim-easy-align
dotgrab kana/vim-textobj-entire
dotgrab kana/vim-textobj-user
dotgrab ninrod/ninscratch-vim
dotgrab terryma/vim-multiple-cursors
dotgrab tommcdo/vim-exchange
dotgrab tpope/vim-commentary
dotgrab tpope/vim-pathogen
dotgrab tpope/vim-repeat
dotgrab tpope/vim-surround
dotgrab vim-scripts/ReplaceWithRegister
dotgrab wellle/targets.vim

# fetch cosmetic deps
dotgrab itchyny/lightline.vim
dotgrab morhetz/gruvbox
dotgrab junegunn/rainbow_parentheses.vim

# fetch buffer/file manipulation deps
dotgrab jlanzarotta/bufexplorer
dotgrab francoiscabrol/ranger.vim

# filetypes
dotgrab chr4/nginx.vim

dotgrab ayu-theme/ayu-vim
dotgrab tpope/vim-unimpaired
dotgrab briandoll/change-inside-surroundings.vim
dotgrab kien/ctrlp.vim
dotgrab vim-airline/vim-airline
dotgrab vim-airline/vim-airline-themes
dotgrab tomtom/quickfixsigns_vim
dotgrab sheerun/vim-polyglot
dotgrab tomtom/tcomment_vim
dotgrab editorconfig/editorconfig-vim
dotgrab scrooloose/nerdtree
dotgrab ryanoasis/vim-devicons

# pathogen installation
PATHOGEN_FILE=$vim_deps/tpope/vim-pathogen/autoload/pathogen.vim
AUTOLOAD_DIR=~/.vim/autoload
[[ ! -d  $AUTOLOAD_DIR ]] && mkdir -p $AUTOLOAD_DIR
cp $PATHOGEN_FILE ~/.vim/autoload

