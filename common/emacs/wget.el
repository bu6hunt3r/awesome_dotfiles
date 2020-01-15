;; defining a function, that let's you retrieve url's contents and
;; copy them into new buffer

;;;###autoload
(defun wget (&optional url)
  (interactive)
  (let ((url (or url (read-string "Enter URL: "))))
    (let ((download-buffer (url-retrieve-synchronously url)))
      (save-excursion
        (set-buffer download-buffer)
        ;; we may to trim http response
        (goto-char (point-min))
        (re-search-forward "^$" nil 'move)
        (forward-char)
        (delete-region (point-min) (point))
        (display-buffer download-buffer)
        ))))
