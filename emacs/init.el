(require 'cl)
;; load alternate keybinds
(load-file "~/.emacs.d/keybinds.el")

;; loading move-text
(load-file "~/.emacs.d/move-text.el")
(move-text-default-bindings)

(package-initialize)

(add-to-list 'package-archives
             '("melpa" . "http://melpa.org/packages/"))
(add-to-list 'package-archives
             '("org" . "http://orgmode.org/elpa/"))

(defun packages-require (&rest packs)
  "Install and load a package. If the package is not available
  installs it automatically."
  (mapc (lambda (package)
	  (unless (package-installed-p package)
	          (package-install package)
		  ))
	packs
	))

(require 'helm)
(require 'helm-config)
(require 'paredit)
(require 'rainbow-delimiters)
(require 'company)

(load-file "~/.emacs.d/helm-init.el")
;;(server-start)
;;(require 'org-protocol)

;;(setq org-capture-templates `(
;;	("p" "Protocol" entry (file+headline ,(concat org-directory "notes.org") "Inbox")
;;        "* %^{Title}\nSource: %u, %c\n #+BEGIN_QUOTE\n%i\n#+END_QUOTE\n\n\n%?")
;;	("L" "Protocol Link" entry (file+headline ,(concat org-directory "notes.org") "Inbox")
;;        "* %? [[%:link][%:description]] \nCaptured On: %U")
;;)

;; install any packages in jpk-packages, if they are not installed already
(let ((refreshed nil))
  (when (not package-archive-contents)
    (package-refresh-contents)
	(package-install 'use-package)
    (setq refreshed t)))

(require 'use-package)
(setq use-package-always-ensure t)

;; Cask settings
(require 'cask "/home/cr0c0/cask/cask.el")
;; (cask-initialize)
;; 
(require 'pallet)
(pallet-mode t)

; then define packages you use
(use-package doom-themes)
(use-package neotree)
(use-package org-brain)
(use-package monokai-theme)
;; (package-refresh-contents)
;; 
;; (require 'package)
;; (add-to-list 'package-archives
;;              '("melpa" . "http://melpa.org/packages/"))
;; (when (< emacs-major-version 24)
;; ;; For important compatibility libraries like cl-lib
;; (add-to-list 'package-archives '("gnu" . "http://elpa.gnu.org/packages/")))
;; (package-initialize) 
;; ;; load font settings functionality if in GUI mode
;; (add-to-list 'load-path "~/.emacs.d")

;; loading cheatsheets
(require 'cheatsheet)
(load-file "~/.emacs.d/cheats.el")

;; theme settings
(add-to-list 'custom-theme-load-path "~/.emacs.d/themes/")
(load-theme `tron-legacy t)

;; font settings
(set-default-font "IBM 3270 Medium")
(load-file "~/.emacs.d/font-size.el")
(require 'font-size)
(font-size-init 14)
(define-key global-map (kbd "M-+") 'font-size-increase)
(define-key global-map (kbd "M--") 'font-size-decrease)
(define-key global-map (kbd "M-0") 'font-size-default)


(setq org-capture-templates
      '(("t" "Todo" entry (file+headline "~/org/gtd.org" "Tasks")
         "* TODO %?\n  %i\n  %a")
        ("j" "Journal" entry (file+datetree "~/org/journal.org")
         "* %?\nEntered on %U\n  %i\n  %a")))

;; set neotree key binding
(require 'neotree)
(global-set-key [f12] 'neotree-toggle)
;; 
;; ;; set gruvbox theme
;; ;; (load-theme 'gruvbox t)
;; 
;;(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 ;;'(custom-safe-themes
 ;;  (quote
 ;;   ("9d36e7cbea9ab075fa1920275cbde349f5b80c9b901500d296856142b32c7516" "1436d643b98844555d56c59c74004eb158dc85fc55d2e7205f8d9b8c860e177f" default)))
 ;; '(font-size--current-size size)
 ;; '(font-size--default-size default-size)
 ;; '(inhibit-startup-screen t)
 ;; '(package-selected-packages
 ;;   (quote
 ;;    (doom-themes use-package rainbow-delimiters slime geiser ac-etags ox-wk ## company-ghc ghc company-jedi haskell-mode auctex-latexmk ein latex-math-preview monokai-theme ascii-art-to-unicode helm gruvbox-theme org-brain org htmlize neotree))))

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(whitespace-tab ((t (:foreground "#636363")))))
;; 
(setq org-support-shift-select 'always)
;; 
;; ;; Customize doom-theme
;; (require 'doom-themes)
;; 
;; ;; Global settings (defaults)
;; (setq doom-themes-enable-bold t    ; if nil, bold is universally disabled
;;             doom-themes-enable-italic t) ; if nil, italics is universally disabled
;; 
;; ;; Load the theme (doom-one, doom-molokai, etc); keep in mind that each theme
;; ;; may have their own settings.
;; ;;(load-theme 'doom-one t)
;; 
;; ;; Load monokai theme
;; ;;(load-theme 'monokai t)
;; 
;; ;; Enable flashing mode-line on errors
;; (doom-themes-visual-bell-config)
;; 
;; ;; Enable custom neotree theme (all-the-icons must be installed!)
;; ;;(doom-themes-neotree-config)
;; ;; or for treemacs users
;; (doom-themes-treemacs-config)
;; 
;; ;; Corrects (and improves) org-mode's native fontification.
;; (doom-themes-org-config)

;; ascii-art-to-unicode settings
(defface aa2u-face '((t . nil))
  "Face for aa2u box drawing characters")
(advice-add #'aa2u-1c :filter-return
            (lambda (str) (propertize str 'face 'aa2u-face)))
(defun aa2u-org-brain-buffer ()
  (let ((inhibit-read-only t))
    (make-local-variable 'face-remapping-alist)
    (add-to-list 'face-remapping-alist
                 '(aa2u-face . org-brain-wires))
    (ignore-errors (aa2u (point-min) (point-max)))))
(with-eval-after-load 'org-brain
  (add-hook 'org-brain-after-visualize-hook #'aa2u-org-brain-buffer))
  
;; (if nil 
 ;;  (display-graphic-p)
  ;; (set-background-color "272728282222")

  ;; set transparency
  ;;(set-frame-parameter (selected-frame) 'alpha '(85 85))
  ;;(add-to-list 'default-frame-alist '(alpha 85 85))
  ;;)

 
(menu-bar-mode -1)
;; Language hooks
(add-hook 'after-init-hook 'global-company-mode)
;; init ghc autocomplete
(require 'package)
;; (add-to-list 'package-archives 
;;          '("melpa" . "http://melpa-stable.milkbox.net/packages/"))
;; (package-initialize)
(autoload 'ghc-init "ghc" nil t)
(autoload 'ghc-debug "ghc" nil t)
(add-hook 'haskell-mode-hook (lambda () (ghc-init)))

(add-hook 'c-mode-common-hook
	  (lambda ()
	    (when (derived-mode-p 'c-mode 'c++-mode 'java-mode 'asm-mode)
	      (ggtags-mode 1))))
(add-hook 'dired-mode-hook 'ggtags-mode)

;; paredit hooks
(autoload 'enable-paredit-mode "paredit" "Turn on pseudo-structural editing of Lisp code." t)

(add-hook 'emacs-lisp-mode-hook
	  (lambda ()
	    (paredit-mode t)
	    (rainbow-delimiters-mode t)
	    (show-paren-mode 1)
	    ))

(add-hook 'eval-expression-minibuffer-setup-hook #'enable-paredit-mode)
(add-hook 'ielm-mode-hook #'enable-paredit-mode)
(add-hook 'lisp-mode-hook #'enable-paredit-mode)
(add-hook 'lisp-interaction-mode-hook
	  (lambda ()
	    (paredit-mode t)
	    (rainbow-delimiters-mode t)
	    (show-paren-mode 1)
	    ))

(add-hook 'scheme-mode-hook #'enable-paredit-mode)

;; ruby inferior mode
(autoload 'inf-ruby-minor-mode "inf-ruby" "Run an inferior Ruby process" t)
(add-hook 'ruby-mode-hook 'inf-ruby-minor-mode)

;; No delay in showing suggestions.
(setq company-idle-delay 0)
; Show suggestions after entering one character.
(setq company-minimum-prefix-length 1)
; Use tab key to cycle through suggestions.
; ('tng' means 'tab and go')
(company-tng-configure-default)
; company-jedi
(defun my/python-mode-hook ()
  (add-to-list 'company-backends 'company-jedi))

(add-hook 'python-mode-hook 'my/python-mode-hook)

(add-to-list 'company-backends 'company-ghc)

;; Other window backwards
(defun other-window-backward ()
  "Select the previous window."
  (interactive)
  (other-window -1))
(global-set-key "\C-x\C-p" 'other-window-backward)

;; ansi color codes
(add-hook 'shell-mode-hook 'ansi-color-for-comint-mode-on)
(add-to-list 'comint-output-filter-functions 'ansi-color-process-output)
;; gdb: Cycle backwards through input history, saving input.
(eval-after-load "gud"
  '(progn 
     (define-key gud-mode-map (kbd "<up>") 'comint-previous-input)
     (define-key gud-mode-map (kbd "<down>") 'comint-next-input)))

;; Kill lines backward
(defun backward-kill-line (arg)
  "Kill ARG lines backward."
  (interactive "p")
  (kill-line (- 1 arg)))

(global-set-key "\C-c u" 'backward-kill-line)
;; 
;; ;; loading transpose-lines feature (bound to "C-M-up/down")
;; ;;(load-file "~/.emacs.d/vendor/transpose-lines.el")
;; 
;; mu4e settings
(add-to-list 'load-path "/usr/share/emacs/site-lisp/mu4e")
(load-file "/home/cr0c0/.emacs.d/mu4e-settings.el")

;; emojify (useful for telegram)
(add-hook 'after-init-hook #'global-emojify-mode)
;; 
;; (autoload 'multi-term "multi-term" nil t)
;; (autoload 'multi-term-next "multi-term" nil t)
;; 
;; ;; (setq multi-term-program "/bin/bash")   ;; use bash
;; (setq multi-term-program "/bin/zsh") ;; or use zsh...
;; 

;; only needed if you use autopair
(add-hook 'term-mode-hook
  #'(lambda () (setq autopair-dont-activate t)))
;; 
;; 
;; (global-set-key (kbd "C-c t") 'multi-term-next)
;; (global-set-key (kbd "C-c T") 'multi-term) ;; create a new one

;; Define function to toggle between horizontal and vertical split with two windows
(defun window-split-toggle ()
  "Toggle between horizontal and vertical split with two windows."
  (interactive)
  (if (> (length (window-list)) 2)
      (error "Can't toggle with more than 2 windows!")
    (let ((func (if (window-full-height-p)
		    #'split-window-vertically
		  #'split-window-horizontally)))
      (delete-other-windows)
      (funcall func)
      (save-selected-window
	(other-window 1)
	(switch-to-buffer (other-buffer))))))


(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(font-size--current-size size)
 '(font-size--default-size default-size)
 '(nyan-mode t)
 '(package-selected-packages
   (quote
    (merlin-eldoc iedit merlin ocp-indent elf-mode smart-tabs-mode imenu-list inf-ruby chruby seeing-is-believing ruby-electric helm-ag helm-projectile paredit ssh-tunnels helm-core helm-gtags ggtags nyan-mode use-package telega srcery-theme slime rainbow-delimiters pallet ox-wk org-brain nord-theme neotree monokai-theme latex-math-preview julia-mode json-mode helm geiser emojify ein doom-themes company-jedi company-irony company-ghc company-erlang cheatsheet auctex ascii-art-to-unicode all-the-icons-gnus ac-etags))))

;; Set file as ro / expose warning if file is symlink.
(defun read-only-if-symlink ()
  (if (file-symlink-p buffer-file-name)
      (progn
	(setq buffer-read-only t)
	(message "File is a symlink!"))))

(add-hook 'find-file-hooks 'read-only-if-symlink)

(global-set-key (kbd "C-x C-f") 'helm-find-files)

;; imenu-list kbd
(global-set-key (kbd "C-'") #'imenu-list-smart-toggle)

;; smartTabs langs
(smart-tabs-insinuate 'c 'c++ 'javascript 'java 'python 'ruby)

;;;;;;;;;;;;;;;;;;;;;;;;;;
;; insert date and/or time
;;;;;;;;;;;;;;;;;;;;;;;;;;
(defun date-time ()
  "Insert date and time"
  (interactive)
  (insert  (format-time-string "%d.%m.%Y %H:%M:%S")))

(defun date ()
  "Insert date"
  (interactive)
  (insert  (format-time-string "%d.%m.%Y")))

(defun time ()
  "Insert time"
  (interactive)
  (insert  (format-time-string "%H:%M:%S")))

;;;;;;;;;;;;;;;;;;;;;;;;;;
;; insert line below/above
;;;;;;;;;;;;;;;;;;;;;;;;;;
(defun my/insert-line-below (times)
  (interactive "p")
  (move-end-of-line 1)
  (newline times))
(global-set-key (kbd "M-n") #'my/insert-line-below)

(defun my/insert-line-above (times)
  (interactive "p")
  (newline times)
  (move-beginning-of-line (+ (* -1 times) 1) ))
(global-set-key (kbd "M-p") #'my/insert-line-below)

;; elf mode
(add-to-list 'auto-mode-alist '("\\.\\(?:a\\|so\\)\\'" . elf-mode))

;; Delete section mode
(delete-selection-mode 1)

; START TABS CONFIG
;; Create a variable for our preferred tab width
(setq custom-tab-width 2)

;; Two callable functions for enabling/disabling tabs in Emacs
(defun disable-tabs () (setq indent-tabs-mode nil))
(defun enable-tabs  ()
  (local-set-key (kbd "TAB") 'tab-to-tab-stop)
  (setq indent-tabs-mode t)
  (setq tab-width custom-tab-width))

;; Hooks to Enable Tabs
(add-hook 'prog-mode-hook 'enable-tabs)
;; Hooks to Disable Tabs
(add-hook 'lisp-mode-hook 'disable-tabs)
(add-hook 'emacs-lisp-mode-hook 'disable-tabs)

;; Language-Specific Tweaks
(setq-default python-indent-offset custom-tab-width) ;; Python
(setq-default js-indent-level custom-tab-width)      ;; Javascript

;; Making electric-indent behave sanely
(setq-default electric-indent-inhibit t)

;; Make the backspace properly erase the tab instead of
;; removing 1 space at a time.
(setq backward-delete-char-untabify-method 'hungry)

;; (OPTIONAL) Shift width for evil-mode users
;; For the vim-like motions of ">>" and "<<".
(setq-default evil-shift-width custom-tab-width)

;; WARNING: This will change your life
;; (OPTIONAL) Visualize tabs as a pipe character - "|"
;; This will also show trailing characters as they are useful to spot.
(setq whitespace-style '(face tabs tab-mark trailing))

(setq whitespace-display-mappings
  '((tab-mark 9 [124 9] [92 9]))) ; 124 is the ascii ID for '\|'
(global-whitespace-mode) ; Enable whitespace mode everywhere

(global-set-key (kbd "C->") 'indent-rigidly-right-to-tab-stop)
(global-set-key (kbd "C-<") 'indent-rigidly-left-to-tab-stop)

;END TABS CONFIG

; LINE NUMBERS CONFIG
(global-display-line-numbers-mode)
(set-face-background 'line-number "#000000")
; END LINE NUMBERS CONFIG

; IMENU RESCAN
(setq imenu-auto-rescan t)
; IMENU RESCAN END
