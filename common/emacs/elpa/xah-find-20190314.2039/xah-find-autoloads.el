;;; xah-find-autoloads.el --- automatically extracted autoloads
;;
;;; Code:

(add-to-list 'load-path (directory-file-name
                         (or (file-name-directory #$) (car load-path))))


;;;### (autoloads nil "xah-find" "xah-find.el" (0 0 0 0))
;;; Generated autoloads from xah-find.el

(autoload 'xah-find-count "xah-find" "\
Report how many occurrences of a string, of a given dir.
Similar to `rgrep', but written in pure elisp.
Result is shown in buffer *xah-find output*.
Case sensitivity is determined by `case-fold-search'. Call `toggle-case-fold-search' to change.
\\{xah-find-output-mode-map}

\(fn @SEARCH-STR @COUNT-EXPR @COUNT-NUMBER @INPUT-DIR @PATH-REGEX)" t nil)

(autoload 'xah-find-text "xah-find" "\
Report files that contain string.
By default, not case sensitive, and print surrounding text.
If `universal-argument' is called first, prompt to ask.
Result is shown in buffer *xah-find output*.
\\{xah-find-output-mode-map}

\(fn @SEARCH-STR1 @INPUT-DIR @PATH-REGEX @FIXED-CASE-SEARCH-P @PRINTCONTEXT-P)" t nil)

(autoload 'xah-find-replace-text "xah-find" "\
Find/Replace string in all files of a directory.
Search string can span multiple lines.
No regex.

Backup, if requested, backup filenames has suffix with timestamp, like this: ~xf20150531T233826~

Result is shown in buffer *xah-find output*.
\\{xah-find-output-mode-map}

\(fn @SEARCH-STR @REPLACE-STR @INPUT-DIR @PATH-REGEX @WRITE-TO-FILE-P @FIXED-CASE-SEARCH-P @FIXED-CASE-REPLACE-P &optional @BACKUP-P)" t nil)

(autoload 'xah-find-text-regex "xah-find" "\
Report files that contain a string pattern, similar to `rgrep'.
Result is shown in buffer *xah-find output*.
\\{xah-find-output-mode-map}
Version 2016-12-21

\(fn @SEARCH-REGEX @INPUT-DIR @PATH-REGEX @FIXED-CASE-SEARCH-P @PRINT-CONTEXT-LEVEL)" t nil)

(autoload 'xah-find-replace-text-regex "xah-find" "\
Find/Replace by regex in all files of a directory.

Backup, if requested, backup filenames has suffix with timestamp, like this: ~xf20150531T233826~

When called in lisp code:
@REGEX is a regex pattern.
@REPLACE-STR is replacement string.
@INPUT-DIR is input directory to search (includes all nested subdirectories).
@PATH-REGEX is a regex to filter file paths.
@WRITE-TO-FILE-P, when true, write to file, else, print a report of changes only.
@FIXED-CASE-SEARCH-P sets `case-fold-search' for this operation.
@FIXED-CASE-REPLACE-P if true, then the letter-case in replacement is literal. (this is relevant only if @FIXED-CASE-SEARCH-P is true.)
Result is shown in buffer *xah-find output*.
\\{xah-find-output-mode-map}

Version 2018-08-20

\(fn @REGEX @REPLACE-STR @INPUT-DIR @PATH-REGEX @WRITE-TO-FILE-P @FIXED-CASE-SEARCH-P @FIXED-CASE-REPLACE-P @SHOW-CONTEX-P @BACKUP-P)" t nil)

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "xah-find" '("xah-find-")))

;;;***

;; Local Variables:
;; version-control: never
;; no-byte-compile: t
;; no-update-autoloads: t
;; coding: utf-8
;; End:
;;; xah-find-autoloads.el ends here
