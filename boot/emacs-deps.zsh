mkdir -p $emacs_deps && cd $emacs_deps

# my packages
dotgrab ninrod/gruvbox-theme
dotgrab ninrod/rsynced-melpa
dotgrab ninrod/evil-replace-with-char
dotgrab ninrod/evil-string-inflection

# 3rd party
dotgrab noctuid/rect-ext.el
dotgrab emacs-evil/evil