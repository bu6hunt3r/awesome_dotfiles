(add-to-list 'package-archives
             '("melpa" . "http://melpa.org/packages/"))

(setq org-capture-templates
      '(("t" "Todo" entry (file+headline "~/org/gtd.org" "Tasks")
         "* TODO %?\n  %i\n  %a")
        ("j" "Journal" entry (file+datetree "~/org/journal.org")
         "* %?\nEntered on %U\n  %i\n  %a")))

;; transparent background color
(set-background-color "ARGBBB000000")