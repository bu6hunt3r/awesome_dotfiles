(let ((gc-cons-threshold (* 25 1024 1024)))
    (require 'package)
    (setq package-enable-at-startup nil)
    (defun bu6hunt3r--rsyncfy (repo) (concat "~/.dotfiles/deps/emacs/ninrod/rsynced-melpa/" repo))
    (setq package-archives `(("melpa"   . ,(bu6hunt3r--rsyncfy "melpa/"))
                             ("org"     . ,(bu6hunt3r--rsyncfy "org/"))
                             ("gnu"     . ,(bu6hunt3r--rsyncfy "gnu/"))))
    (package-initialize)
    (unless (package-installed-p 'use-package))
        (package-refresh-contents)
        (package-install 'use-package)
    
    (use-package diminish :ensure t)

    ;;(use-package org
    ;;    :pin org
    ;;    :ensure org-plus-contrib
    ;;    :defer 7)  ;; fetch latest version of `org-mode'
    
    (setq vc-follow-symlinks "t")

(setq org-capture-templates
      '(("t" "Todo" entry (file+headline "~/org/gtd.org" "Tasks")
         "* TODO %?\n  %i\n  %a")
        ("j" "Journal" entry (file+datetree "~/org/journal.org")
         "* %?\nEntered on %U\n  %i\n  %a")))

;; transparent background color
(set-background-color "ARGBBB000000")