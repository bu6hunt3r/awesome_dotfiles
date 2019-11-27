(defun increment-once ()
  (interactive)
  (beginning-of-line)
  (save-excursion
    ;;(while (re-search-forward "\\[\\([0-9]+\\)\\]" nil t)
    (while (re-search-forward "\\([0-9]+\\)" nil t)
      (replace-match (number-to-string
		              (1+ (string-to-number (match-string 1))))
		             nil nil nil 1))))

(defun decrement-once ()
  (interactive)
  (beginning-of-line)
  (while (re-search-forward "\\[\\([0-9]+\\)\\]" nil t)
    (replace-match (number-to-string
		     (1- (string-to-number (match-string 1))))
		   nil nil nil 1)))
