;;; doom-laserwave-theme.el --- inspired by VS Code laserwave
(require 'doom-themes)

;;
(defgroup doom-laserwave-theme nil
  "Options for doom-themes"
  :group 'doom-themes)

(defcustom doom-laserwave-padded-modeline doom-themes-padded-modeline
  "If non-nil, adds a 4px padding to the mode-line. Can be an integer to
determine the exact padding."
  :group 'doom-laserwave-theme
  :type '(choice integer boolean))

;;
(def-doom-theme doom-laserwave
  "An clean 80's synthwave / outrun theme inspired by VS Code laserwave."

  ;; name        default   256       16
  ((bg         '("#27212E" nil       nil            ))
   (bg-alt     '("#1B1720" nil       nil            ))
   (base0      '("#222228" "black"   "black"        ))
   (base1      '("#24262D" "#222222" "brightblack"  ))
   (base2      '("#282b33" "#222233" "brightblack"  ))
   (base3      '("#3E3549" "#333344" "brightblack"  ))
   (base4      '("#4E415C" "#444455" "brightblack"  ))
   (base5      '("#544863" "#554466" "brightblack"  ))
   (base6      '("#716385" "#776688" "brightblack"  ))
   (base7      '("#91889B" "#998899" "brightblack"  ))
   (base8      '("#ECEFF4" "#EEEEFF" "white"        ))
   (fg-alt     '("#EEEEEE" "#EEEEEE" "brightwhite"  ))
   (fg         '("#FFFFFF" "#FFFFFF" "white"        ))

   (grey       base4)
   (red        '("#964C7B" "#964477" "red"          ))
   (orange     '("#FFB85B" "#FFBB55" "brightred"    ))
   (green      '("#74DFC4" "#77DDCC" "green"        ))
   (teal       '("#4D8079" "#448877" "brightgreen"  ))
   (yellow     '("#FFE261" "#FFEE66" "yellow"       ))
   (blue       '("#40B4C4" "#44BBCC" "brightblue"   ))
   (dark-blue  '("#336A79" "#336677" "blue"         ))
   (magenta    '("#EB64B9" "#EE66BB" "brightmagenta"))
   (violet     '("#B381C5" "#BB88CC" "magenta"      ))
   (cyan       '("#B4DCE7" "#BBDDEE" "brightcyan"   ))
   (dark-cyan  '("#6D7E8A" "#667788" "cyan"         ))

   ;; face categories -- required for all themes
   (highlight      blue)
   (vertical-bar   (doom-darken base1 0.2))
   (selection      dark-blue)
   (builtin        magenta)
   (comments       base7)
   (doc-comments   (doom-lighten dark-cyan 0.25))
   (constants      violet)
   (functions      magenta)
   (keywords       blue)
   (methods        cyan)
   (operators      blue)
   (type           yellow)
   (strings        cyan)
   (variables      fg)
   (numbers        orange)
   (region         `(,(doom-blend (car bg) (car magenta) 0.8) ,@(doom-lighten (cdr base1) 0.35)))
   (error          red)
   (warning        yellow)
   (success        green)
   (vc-modified    orange)
   (vc-added       green)
   (vc-deleted     red)

   ;; custom categories
   (hidden     `(,(car bg) "black" "black"))
   (-modeline-pad
    (when doom-laserwave-padded-modeline
      (if (integerp doom-laserwave-padded-modeline) doom-laserwave-padded-modeline 4)))

   (modeline-fg     nil)
   (modeline-fg-alt base5)

   (modeline-bg
    `(,(car bg-alt) ,@(cdr base0)))
   (modeline-bg-l
    `(,(doom-darken (car bg) 0.1) ,@(cdr base0)))
   (modeline-bg-inactive   (doom-darken bg 0.1))
   (modeline-bg-inactive-l `(,(car bg) ,@(cdr base1))))


  ;; --- extra faces ------------------------
  ((elscreen-tab-other-screen-face :background "#353a42" :foreground "#1e2022")

   ((line-number &override) :foreground base4)
   ((line-number-current-line &override) :foreground fg)

   (font-lock-comment-face
    :foreground comments)
   (font-lock-doc-face
    :inherit 'font-lock-comment-face
    :foreground doc-comments)

   (doom-modeline-bar :background highlight)

   (mode-line
    :background modeline-bg :foreground modeline-fg
    :box (if -modeline-pad `(:line-width ,-modeline-pad :color ,modeline-bg)))
   (mode-line-inactive
    :background modeline-bg-inactive :foreground modeline-fg-alt
    :box (if -modeline-pad `(:line-width ,-modeline-pad :color ,modeline-bg-inactive)))
   (mode-line-emphasis
    :foreground highlight)

   ;; Doom modeline
   (doom-modeline-buffer-file :inherit 'mode-line-buffer-id :weight 'bold)
   (doom-modeline-buffer-path :foreground fg :inherit 'mode-line-emphasis)
   (doom-modeline-buffer-project-root :foreground fg :inherit 'mode-line-emphasis)

   ;; --- major-mode faces -------------------
   ;; css-mode / scss-mode
   (css-proprietary-property :foreground orange)
   (css-property             :foreground green)
   (css-selector             :foreground blue)

   ;; markdown-mode
   (markdown-header-delimiter-face :foreground base7)
   (markdown-metadata-key-face     :foreground base7)
   (markdown-list-face             :foreground base7)
   (markdown-link-face             :foreground cyan)
   (markdown-url-face              :inherit 'link :foreground fg :weight 'normal)
   (markdown-italic-face           :inherit 'italic :foreground magenta)
   (markdown-bold-face             :inherit 'bold :foreground magenta)
   (markdown-markup-face           :foreground base7)
   (markdown-gfm-checkbox-face :foreground cyan)

   ;; outline (affects org-mode)
   ((outline-1 &override) :foreground blue :background bg)
   ((outline-2 &override) :foreground green)
   ((outline-3 &override) :foreground teal)
   ((outline-4 &override) :foreground (doom-darken blue 0.2))
   ((outline-5 &override) :foreground (doom-darken green 0.2))
   ((outline-6 &override) :foreground (doom-darken teal 0.2))
   ((outline-7 &override) :foreground (doom-darken blue 0.4))
   ((outline-8 &override) :foreground (doom-darken green 0.4))

   ;; org-mode
   (org-hide :foreground hidden)
   (org-block :background base2)
   (org-block-begin-line :background base2 :foreground comments)
   (solaire-org-hide-face :foreground hidden)

   ;; --- extra variables ---------------------
   (paren-face-match  :foreground yellow   :background (doom-darken bg 0.2) :weight 'ultra-bold)
   (ivy-current-match :background base7 :distant-foreground nil)
   (tooltip           :background bg-alt :foreground fg)
   (company-box-background :foreground fg :background bg-alt))

  )

;;; doom-laserwave-theme.el ends here
