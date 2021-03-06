;;; telega-core.el --- Core functionality for telega  -*- lexical-binding:t -*-

;; Copyright (C) 2018-2019 by Zajcev Evgeny.

;; Author: Zajcev Evgeny <zevlg@yandex.ru>
;; Created: Mon Apr 23 18:09:01 2018
;; Keywords:

;; telega is free software: you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation, either version 3 of the License, or
;; (at your option) any later version.

;; telega is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with telega.  If not, see <http://www.gnu.org/licenses/>.

;;; Commentary:

;; Variables, macroses, defsubst and runtime goodies for telega

;;; Code:
(require 'cl-lib)
(require 'subr-x)
(require 'ring)
(require 'cursor-sensor)

(require 'telega-customize)

(declare-function telega-chat--info "telega-chat" (chat))
(declare-function telega-emoji-create-svg "telega-util" (emoji &optional c-height))

(defvar telega--lib-directory nil
  "The directory from where this library was first loaded.")

(defconst telega-chat-types
  '(private secret basicgroup supergroup bot channel)
  "All types of chats supported by telega.")

;;; Runtime variables
(defvar telega--chat nil
  "Telega chat for the current buffer.
Used in help buffers to refer chat.")
(make-variable-buffer-local 'telega--chat)

(defvar telega--me-id nil "User id of myself.")
(defvar telega--gifbot-id nil "Bot used to search for animations.")
(defvar telega--imgbot-id nil "Bot used to search for photos.")
(defvar telega--options nil "Options updated from telega-server.")
(defvar telega--auth-state nil
  "Current Authorization state.")
(defvar telega--conn-state nil
  "Current connection state.")
(defvar telega--status "Not Started" "Status of the connection to telegram.")
(defvar telega--status-aux
  "Aux status used for long requests, such as fetching chats/searching/etc")
(defvar telega--chats nil "Hash table (id -> chat) for all chats.")
(defvar telega--actions nil "Hash table (chat-id -> alist-of-user-actions).")
(defvar telega--ordered-chats nil "Ordered list of all chats.")
(defvar telega--filtered-chats nil
  "Chats filtered by currently active filters.
Used to calculate numbers displayed in custom filter buttons.")
(defvar telega--filters nil "List of active filters.")
(defvar telega--undo-filters nil "List of undo entries.")

(defvar telega--info nil "Alist of (TYPE . INFO-TABLE).")
(defvar telega--full-info nil "Alist of (TYPE . FULL-INFO-TABLE).")

(defvar telega--top-chats nil
  "Alist of (CATEGORY LAST-UPDATE-TIME ..)
CATEGORY is one of `Users', `Bots', `Groups', `Channels',
`InlineBots', `Calls'")
(defvar telega--last-buffer nil
  "Used to track buffers switching.
So we can run the code when switching from chat buffer.")
(defvar telega--stickersets nil
  "Alist of seen sticker sets.
ID -> sticker set.
Take into account that ID is the string.")
(defvar telega--stickersets-installed-ids nil
  "List of installed sticker sets.")
(defvar telega--stickersets-trending nil
  "List of trending sticker sets info.")
(defvar telega--stickers-favorite nil
  "List of favorite stickers.")
(defvar telega--stickers-recent nil
  "List of recently used stickers.")
(defvar telega--stickers-recent-attached nil
  "List of recently attached stickers.")
(defvar telega--animations-saved nil
  "List of saved animations.")

;; Searching
(defvar telega-search-query nil
  "Last search query done by `telega-search'.
Used to continue searching messages.")
(defvar telega-search-history nil
  "List of recent search queries.")

(defvar telega--search-chats nil
  "Result of last `telega--searchChats' or `telega--searchChatsOnServer'.")
(defvar telega--search-contacts nil
  "Result of last `telega--searchContacts'.")
(defvar telega--search-global-loading nil
  "Non-nil if globally searching public chats asynchronously.
Actualy value is `:@extra' of the call.")
(defvar telega--search-messages-loading nil
  "Non-nil if searching messages asynchronously.
Actualy value is `:@extra' of the call.")

(defvar telega--unread-message-count nil
  "Plist with counts for unread/unmuted messages.
Props are `:unread_count' and `:unread_unmuted_count'")
(defvar telega--unread-chat-count nil
  "Plist with counts for unread/unmuted chats.
Props are `:unread_count', `:unread_unmuted_count', `:marked_as_unread_count'
and `:marked_as_unread_unmuted_count'")

(defvar telega--chat-buffers nil "List of all chat buffers.")
(defvar telega--files nil
  "Files hash FILE-ID -> (list FILE UPDATE-CALBACKS..).")
(defvar telega--files-updates nil
  "Hash of FILE-ID -> (list-of (UPDATE-CB CB-ARGS))
UPDATE-CB is callback to call when file updates.
UPDATE-CB is called with FILE and CB-ARGS as arguments.
UPDATE-CB should return non-nil to be removed after its being called.")
(defvar telega--proxy-pings nil
  "Alist for the proxy pings.
In form (PROXY-ID . TIMESTAMP SECONDS)")
(defvar telega-voip--alist nil
  "Alist of all calls currently in processing.
In form (ID . CALL)")
(defvar telega-voip--active-call nil
  "Currently active call.
Active call is either outgoing call or accepted incoming call.
Only one call can be currently active.")
(defvar telega--scope-notification-alist (cons nil nil)
  "Default notification settings for chats.
alist where key is one of `private', `group' or `channel'.")

;; Minibuffer stuff used by chatbuf and stickers
(defvar telega-minibuffer--choices nil
  "Bind to list of choices.")
(defvar telega-minibuffer--chat nil
  "Bind to chat currently active.")
(defvar telega-minibuffer--string nil
  "Bind to Saved string entered to minibuffer.")

(defvar telega--ignored-messages-ring (make-ring 0)
  "Ring of ignored messages.
Use \\[execute-extended-command] telega-ignored-messages RET to
display the list.")


;;; Shared chat buffer local variables
(defvar telega-chatbuf--chat nil
  "Telega chat for the current chat buffer.")
(make-variable-buffer-local 'telega-chatbuf--chat)

(defvar telega-chatbuf--messages nil
  "Local cache for the messages.")
(make-variable-buffer-local 'telega-chatbuf--messages)

(defvar telega-chatbuf--inline-query nil
  "Non-nil if some inline bot has been requested.
Actual value is `:@extra` value of the call to inline bot.")
(make-variable-buffer-local 'telega-chatbuf--inline-query)

(defvar telega-chatbuf--input-marker nil)
(make-variable-buffer-local 'telega-chatbuf--input-marker)


(defun telega--init-vars ()
  "Initialize runtime variables.
Done when telega server is ready to receive queries."
  (setq telega--auth-state nil)
  (setq telega--conn-state nil)
  (setq telega--status "Disconnected")
  (setq telega--status-aux "")
  (setq telega--me-id -1)
  (setq telega--gifbot-id nil)
  (setq telega--imgbot-id nil)
  (setq telega--options
        ;; default limits
        (list :message_caption_length_max 1024
              :message_text_length_max 4096))
  (setq telega--chats (make-hash-table :test 'eq))
  (setq telega--top-chats nil)

  (setq telega-search-query nil)
  (setq telega--search-chats nil)
  (setq telega--search-contacts nil)
  (setq telega--search-global-loading nil)
  (setq telega--search-messages-loading nil)

  (setq telega--ordered-chats nil)
  (setq telega--filtered-chats nil)
  (setq telega--actions (make-hash-table :test 'eq))
  (setq telega--filters nil)
  (setq telega--undo-filters nil)
  (setq telega--info
        (list (cons 'user (make-hash-table :test 'eq))
              (cons 'secretChat (make-hash-table :test 'eq))
              (cons 'basicGroup (make-hash-table :test 'eq))
              (cons 'supergroup (make-hash-table :test 'eq))))
  (setq telega--full-info
        (list (cons 'user (make-hash-table :test 'eq))
              (cons 'basicGroup (make-hash-table :test 'eq))
              (cons 'supergroup (make-hash-table :test 'eq))))

  (setq telega--ignored-messages-ring
        (make-ring telega-ignored-messages-ring-size))
  (setq telega--unread-message-count nil)
  (setq telega--unread-chat-count nil)

  (setq telega--files (make-hash-table :test 'eq))
  (setq telega--files-updates (make-hash-table :test 'eq))

  (setq telega-voip--alist nil)
  (setq telega-voip--active-call nil)

  (setq telega--proxy-pings nil)
  (setq telega--scope-notification-alist nil)

  (setq telega--stickersets nil)
  (setq telega--stickersets-installed-ids nil)
  (setq telega--stickersets-trending nil)
  (setq telega--stickers-favorite nil)
  (setq telega--stickers-recent nil)
  (setq telega--stickers-recent-attached nil)
  (setq telega--animations-saved nil)
  )

(defun telega-test-env (&optional quiet-p)
  "Test Emacs environment.
If QUIET-P is non-nil, then show success message in echo area.
Return non-nil if all tests are passed."
  (interactive "P")
  ;; 62bits for numbers is required
  ;; i.e. ./configure --with-wide-int
  (cl-assert (= most-positive-fixnum 2305843009213693951) nil
             "Emacs with wide ints (--with-wide-int) is required")
  (cl-assert (= (string-to-number "542353335") 542353335) nil
             (concat "Emacs with `(string-to-number \"542353335\") ==> 542353335'"
                     " is required"))

  ;; at least 25.1 emacs is required
  ;; see https://t.me/emacs_telega/1592
  (cl-assert (fboundp 'cursor-intangible-mode) nil
             "Emacs with `cursor-intangible-mode' is required")

  ;; For now stick with at least 26.1 Emacs
  (cl-assert (string-version-lessp "26.0" emacs-version) nil
             (format "At least Emacs 26.0 is required, but you have %s"
                     emacs-version))

  ;; imagemagick for images, no fallback yet
  ;; however newer Emacs implements image properties needed by telega
  (cl-assert (image-type-available-p 'imagemagick) nil
             (concat "Emacs with `imagemagick' support is required."
                     " (libmagickcore, libmagickwand, --with-imagemagick)"))
  (cl-assert (image-type-available-p 'svg) nil
             "Emacs with `svg' support is required. (librsvg)")
  (unless quiet-p
    (message "Your Emacs is suitable to run telega.el"))
  t)

(defmacro telega-save-excursion (&rest body)
  "Execute BODY saving current point as moving marker."
  (declare (indent 0))
  (let ((pnt-sym (gensym)))
    `(let ((,pnt-sym (copy-marker (point) t)))
       (unwind-protect
           (progn ,@body)
         (goto-char ,pnt-sym)))))

(defmacro telega-save-cursor (&rest body)
  "Execute BODY saving cursor's line and column position."
  (declare (indent 0))
  (let ((line-sym (gensym "line"))
        (col-sym (gensym "col")))
    `(let ((,line-sym (+ (if (bolp) 1 0) (count-lines 1 (point))))
           (,col-sym (current-column)))
       (unwind-protect
           (progn ,@body)
         (goto-char (point-min))
         (cl-assert (> ,line-sym 0))
         (forward-line (1- ,line-sym))
         (move-to-column ,col-sym)))))

(defmacro with-telega-debug-buffer (&rest body)
  "Execute BODY only if `telega-debug' is non-nil, making debug buffer current."
  `(when telega-debug
     (with-current-buffer (get-buffer-create "*telega-debug*")
       (telega-save-excursion
         ,@body))))

(defmacro with-telega-root-buffer (&rest body)
  "Execute BODY setting current buffer to root buffer.
Inhibits read-only flag."
  (declare (indent 0))
  `(when (buffer-live-p (telega-root--buffer))
     (with-current-buffer telega-root-buffer-name
       (let ((inhibit-read-only t))
         (unwind-protect
             (progn ,@body)
           (set-buffer-modified-p nil))))))

(defmacro with-telega-chatbuf (chat &rest body)
  "Execute BODY setting current buffer to chat buffer of CHAT.
Executes BODY only if chat buffer already exists.
If there is no corresponding buffer, then do nothing.
Inhibits read-only flag."
  (declare (indent 1))
  (let ((bufsym (cl-gensym "buf"))
        (chatsym (cl-gensym "chat")))
    `(let* ((,chatsym ,chat)
            (,bufsym (if (and telega-chatbuf--chat
                              (eq telega-chatbuf--chat ,chatsym))
                         (current-buffer)
                       (cl-find ,chatsym telega--chat-buffers
                                :test (lambda (val buf)
                                        (with-current-buffer buf
                                          (eq telega-chatbuf--chat val)))))))
       (when (buffer-live-p ,bufsym)
         (with-current-buffer ,bufsym
           (let ((inhibit-read-only t)
                 (buffer-undo-list t))
             ,@body))))))

(defmacro with-telega-help-win (buffer-or-name &rest body)
  "Execute BODY in help BUFFER-OR-NAME."
  (declare (indent 1))
  `(progn
     (with-help-window ,buffer-or-name)
     (redisplay)
     (with-help-window ,buffer-or-name
       (set-buffer standard-output)
       (cursor-sensor-mode 1)
       ,@body)))

(defsubst telega-debug (fmt &rest args)
  "Insert formatted string into debug buffer.
FMT and ARGS are passed directly to `format'."
  (with-telega-debug-buffer
   (goto-char (point-max))
   (insert (apply 'format (cons (concat fmt "\n") args)))))

(defmacro telega--tl-type (tl-obj)
  `(intern (plist-get ,tl-obj :@type)))

(defmacro telega--tl-error-p (tl-obj)
  "Return non-nil if TL-OBJ is error object."
  `(eq (telega--tl-type ,tl-obj) 'error))

(defmacro telega--tl-get (obj prop1 &rest props)
  "`plist-get' which works with multiple arguments.
For example:
`(telega--tl-get obj :prop1 :prop2)' is equivalent to
`(plist-get (plist-get obj :prop1) :prop2)`"
  (let ((ret `(plist-get ,obj ,prop1)))
    (dolist (prop props)
      (setq ret (list 'plist-get ret prop)))
    ret))

(defmacro telega--tl-prop (prop1 &rest props)
  "Generate function to get property by PROP1 and PROPS.
Uses `telega--tl-get' to obtain the property."
  (let ((tl-obj-sym (cl-gensym "tl-obj")))
    `(lambda (,tl-obj-sym)
       (telega--tl-get ,tl-obj-sym ,prop1 ,@props))))

(defsubst telega-file--size (file)
  "Return FILE size."
  ;; NOTE: fsize is 0 if unknown, in this case esize is approximate
  ;; size
  (let ((fsize (plist-get file :size))
        (esize (plist-get file :expected_size)))
    (if (zerop fsize) esize fsize)))

(defsubst telega-file--downloaded-p (file)
  "Return non-nil if FILE has been downloaded."
  (telega--tl-get file :local :is_downloading_completed))

(defsubst telega-file--downloading-p (file)
  "Return non-nil if FILE is downloading right now."
  (telega--tl-get file :local :is_downloading_active))

(defsubst telega-file--can-download-p (file)
  "Return non-nil if FILE can be downloaded.
May return nil even when `telega-file--downloaded-p' returns non-nil."
  (telega--tl-get file :local :can_be_downloaded))

(defsubst telega-file--need-download-p (file)
  (and (telega-file--can-download-p file)
       (not (telega-file--downloaded-p file))))

(defsubst telega-file--downloading-progress (file)
  "Return progress of FILE downloading as float from 0 to 1."
  (color-clamp (/ (float (telega--tl-get file :local :downloaded_size))
                  (telega-file--size file))))

(defsubst telega-file--uploading-p (file)
  "Return non-nil if FILE is uploading right now."
  (telega--tl-get file :remote :is_uploading_active))

(defsubst telega-file--uploading-progress (file)
  "Return progress of FILE uploading as float from 0 to 1."
  (color-clamp (/ (float (telega--tl-get file :remote :uploaded_size))
                  (telega-file--size file))))

(defsubst telega--tl-desurrogate (str)
  "Decode surrogate pairs in STR string.
Attach `display' text property to surrogated regions."
  (dotimes (idx (1- (length str)))
    (let ((high (aref str idx))
          (low (aref str (1+ idx))))
      (when (and (>= high #xD800) (<= high #xDBFF)
                 (>= low #xDC00) (<= low #xDFFF))
        (let ((unicode-str (char-to-string
                            (+ (lsh (- high #xD800) 10)
                               (- low #xDC00) #x10000))))
          ;; NOTE: delay emoji svg creation to
          ;; `telega--desurrogate-apply' by marking region with
          ;; `telega-emoji-p' property.  Creating svg at receive time,
          ;; might result in lockups when receiving sticker sets
          (add-text-properties
           idx (+ idx 2) (list ;'display unicode-str
                               'telega-emoji-p t
                               'telega-display unicode-str) str)
          ))))
  str)

(defsubst telega--desurrogate-apply-part (part &optional keep-properties)
  "Apply PART's `telega-display'"
  (let ((part-display (get-text-property 0 'telega-display part)))
    (cond (part-display
           (if keep-properties
               ;; keep all properties except for `telega-display'
               ;; Apply `telega-emoji-p' property as well
               (let* ((part-props0 (telega-plist-del
                                    (text-properties-at 0 part) 'telega-display))
                      (emoji-p (plist-get part-props0 'telega-emoji-p))
                      (part-props1 (telega-plist-del part-props0 'telega-emoji-p))
                      ;; NOTE: we always create new cell for 'display
                      ;; property as in `image-insert', see comment
                      ;; about this in `image-insert' sources
                      (addon-props (when (and emoji-p
                                              telega-use-images
                                              telega-emoji-use-images)
                                     (list 'rear-nonsticky '(display)
                                           'display (cons 'image (cdr (telega-emoji-create-svg part-display)))))))
                 (apply 'propertize part-display (nconc part-props1 addon-props)))
             part-display))
          (keep-properties part)
          (t (substring-no-properties part)))))

(defsubst telega--desurrogate-apply-part-keep-properties (part)
  (telega--desurrogate-apply-part part 'keep-props))

(defun telega--desurrogate-apply (str &optional no-properties)
  "Apply `telega-display' properties to STR.
Resulting in new string with no surrogate pairs.
If NO-PROPERTIES is specified, then do not keep text properties."
  (mapconcat (if no-properties
                 'telega--desurrogate-apply-part
               'telega--desurrogate-apply-part-keep-properties)
             (telega--split-by-text-prop str 'telega-display) ""))

(defsubst telega--tl-unpack (obj)
  "Unpack (i.e. desurrogate strings) object OBJ."
  (cond ((stringp obj) (telega--tl-desurrogate obj))
        ((vectorp obj) (cl-map 'vector 'telega--tl-unpack obj))
        ((listp obj) (mapcar 'telega--tl-unpack obj))
        (t obj)))

(defsubst telega--tl-pack (obj)
  "Pack object OBJ."
  ;; Remove text props from strings, etc
  (cond ((stringp obj) (substring-no-properties obj))
        ((vectorp obj) (cl-map 'vector 'telega--tl-pack obj))
        ((listp obj) (mapcar 'telega--tl-pack obj))
        (t obj)))

(defmacro telega-tl-str (obj prop &optional no-properties)
  "Get property PROP from OBJ, desurrogating resulting string.
NO-PROPERTIES is passed directly to `telega--desurrogate-apply'."
  `(telega--desurrogate-apply (plist-get ,obj ,prop) ,no-properties))
  ;;TODO: Return nil if resulting string is empty."
  ;; (let ((ret (telega--desurrogate-apply (plist-get obj prop) no-properties)))
  ;;   (unless (string-empty-p ret)
  ;;     ret)))

(defsubst telega-me-p (chat-or-user)
  "Return non-nil if CHAT-OR-USER is me."
  (eq telega--me-id (plist-get chat-or-user :id)))


;;; Formatting
(defun telega-fmt-eval-fill (estr attrs)
  "Fill ESTR to `:fill-column' value from ATTRS.
Keeps newlines in ESTR.
Return list of strings."
  (let ((fill-column (- (or (plist-get attrs :fill-column) fill-column)
                        (length (plist-get attrs :fill-prefix)))))
    (apply #'nconc
           (mapcar (if (plist-get attrs :fill)
                       (lambda (str)
                         (split-string
                          (with-temp-buffer
                            (insert str)
                            (fill-region (point-min) (point-max)
                                         (plist-get attrs :fill) t)
                            (buffer-substring (point-min) (point-max)))
                          "\n"))
                     #'list)
                   (split-string estr "\n")))))

(defun telega-fmt-eval-truncate (estr attrs)
  "Apply `:max', `:elide-string' and `:elide-trail' properties from ATTRS to ESTR."
  (let* ((max (plist-get attrs :max))
         ;; NOTE: always apply elide
;         (elide (plist-get attrs :elide))
         (elide-str (or (plist-get attrs :elide-string) telega-symbol-eliding))
         (elide-trail (or (plist-get attrs :elide-trail) 0))
         (estr-trail (if (> elide-trail 0) (substring estr (- elide-trail)) ""))
         (estr-lead (truncate-string-to-width
                     estr (- max (string-width elide-str) elide-trail))))
    (concat estr-lead elide-str estr-trail)))
    ;;      result)
    ;; ;; Correct truncstr in case of multibyte chars
    ;; (while (and (not (string-empty-p estr-lead))
    ;;             (< max (string-width
    ;;                     (setq result (concat estr-lead elide-str estr-trail)))))
    ;;   (setq estr-lead (substring estr-lead 0 -1)))

    ;; result))

(defun telega-fmt-eval-align (estr attrs)
  "Apply `:min', `:align' and `:align-symbol' properties from ATTRS to ESTR."
  (let* ((min (plist-get attrs :min))
         (width (- min (string-width estr)))
         (align (plist-get attrs :align))
         (align-symbol (or (plist-get attrs :align-symbol) " "))
         (left "")
         (right ""))
    ;; Grow `left' and `right' until they have required width
    (while (< (string-width left) (/ width 2))
      (setq left (concat left align-symbol)))
    (while (< (string-width right) (- width (/ width 2)))
      (setq right (concat right align-symbol)))

    (cl-ecase align
      (left (concat estr left right))
      (right (concat left right estr))
      ((center centre) (concat left estr right)))))

(defun telega-fmt-eval-min-max (estr attrs)
  "Apply `:min' and `:max' properties from ATTRS to ESTR."
  (let ((max (plist-get attrs :max))
        (min (plist-get attrs :min))
        (estr-width (string-width estr)))
    (cond ((and max (> estr-width max))
           (telega-fmt-eval-truncate estr attrs))
          ((and min (< estr-width min))
           (telega-fmt-eval-align estr attrs))
          (t estr))))

(defun telega-fmt-eval-face (estr attrs)
  "Apply `:face' attribute from ATTRS to ESTR."
  (let ((face (plist-get attrs :face)))
    (when face
      (add-face-text-property 0 (length estr) face t estr))
    estr))

(defun telega-fmt-eval-attrs (estr attrs)
  "Apply all attributes ATTRS to ESTR."
  ;; Blackmagic for fast execution, but
  ;; NOTE:
  ;;  - Do not prefix first line
  ;;  - Do not prefix empty lines with blank prefix
  ;;  - If last string is empty, do not prefix it
  (let* ((fpx (plist-get attrs :fill-prefix))
         (fpx-blank-p (or (not fpx) (string-blank-p fpx)))
         (filled-estrs (telega-fmt-eval-fill estr attrs))
         (formatted-estrs (list (telega-fmt-eval-min-max
                                 (pop filled-estrs) attrs)))
         (festr-tail formatted-estrs))
    (while filled-estrs
      (let* ((estr (car filled-estrs))
             (estr-last-p (not (cdr filled-estrs)))
             (festr-elem
              (list (telega-fmt-eval-min-max
                     (concat (unless (and (string-empty-p estr)
                                          (or estr-last-p fpx-blank-p))
                               fpx)
                             estr)
                     attrs))))
        (setcdr festr-tail festr-elem)
        (setq festr-tail festr-elem)
        (setq filled-estrs (cdr filled-estrs))))
    (telega-fmt-eval-face
     (mapconcat #'identity formatted-estrs "\n")
     attrs)))

(defsubst telega-fmt-atom (atom)
  "Convert ATOM to string.
NIL yields empty string for the convenience."
  (cond ((stringp atom) atom)
        ((null atom) "")
        (t (with-output-to-string
             (princ atom)))))

(defun telega-fmt-eval-elem (elem value)
  "Format single element ELEM with VALUE."
  (let (attrs)
    (when (and (not (functionp elem)) (listp elem))
      (setq attrs (cdr elem)
            elem (car elem)))

    (telega-fmt-eval-attrs
     (cond ((functionp elem)
            (telega-fmt-atom (funcall elem value)))
           ((symbolp elem)
            (telega-fmt-atom (symbol-value elem)))
           ((listp elem)
            (telega-fmt-eval elem value))
           (t (telega-fmt-atom elem)))
     attrs)))

(defun telega-fmt-eval (fmt-spec value)
  "Evaluate simple format FMT-SPEC, applying it to VALUE."
  (when (functionp fmt-spec)
    (setq fmt-spec (funcall fmt-spec value)))

  (let ((fmt-result (if (stringp fmt-spec) fmt-spec "")))
    (while (consp fmt-spec)
      (when (car fmt-spec)
        (setq fmt-result
              (concat fmt-result
                      (telega-fmt-eval-elem (car fmt-spec) value))))
      (setq fmt-spec (cdr fmt-spec)))
    fmt-result))

(defsubst telega--time-at00 (timestamp &optional decoded-ts)
  "Return time at 00:00:001 at TIMESTAMP's day.
Optional DECODED-TS is the result of already applied `decode-time'."
  (let ((dt (or decoded-ts (decode-time timestamp))))
    (1+ (- timestamp (* 3600 (nth 2 dt)) (* 60 (nth 1 dt)) (nth 0 dt)))))

;;; Buttons for telega
(defun telega-button--ins-error (_val)
  "Default inserter for the `telega' button."
  (error "Button `:inserter' is unset"))

;; Make 'telega-button be separate (from 'button) type
(put 'telega-button 'type 'telega)
(put 'telega-button 'keymap button-map)
(put 'telega-button 'action 'telega-button--action)
(put 'telega-button 'rear-nonsticky t)
(put 'telega-button 'face nil)
(put 'telega-button :inserter 'telega-button--ins-error)
(put 'telega-button :value nil)
(put 'telega 'button-category-symbol 'telega-button)

(defun telega-button--action (button)
  "Run BUTTON's `:action' function on its `:value'.
Return t if `:action' has been called."
  (when-let ((telega-action (button-get button :action)))
    (funcall telega-action (button-get button :value))
    t))

(defun telega-button--sensor-func (_window oldpos dir)
  "Function to be used in `cursor-sensor-functions' text property.
Activates button if cursor enter, deactivates if leaves."
  (let ((inhibit-read-only t)
        (button-region (telega--region-with-cursor-sensor
                        (if (eq dir 'entered) (point) oldpos))))
    (when button-region
      (put-text-property (car button-region) (cdr button-region)
                         'face (if (eq dir 'entered)
                                   'telega-button-active
                                 'telega-button))
      (when (eq dir 'entered)
        (telega-button--help-echo (car button-region)))
      )))

;; `:help-echo' is also available for buttons
(defun telega-button--help-echo (button)
  "Show help message for BUTTON defined by `:help-echo' property."
  (let ((help-echo (button-get button :help-echo)))
    (when (functionp help-echo)
      (setq help-echo (funcall help-echo (button-get button :value))))
    (when help-echo
      (message "%s" (eval help-echo)))))

(defun telega-button--insert (button-type value &rest props)
  "Insert telega button of BUTTON-TYPE with VALUE and PROPS."
  (declare (indent 2))
  (let ((button (apply 'make-text-button
                       (prog1 (point)
                         (funcall (or (plist-get props :inserter)
                                      (button-type-get button-type :inserter))
                                  value))
                       (point)
                       :type button-type
                       :value value
                       props)))
    (button-at button)))

(defmacro telega-button--change (button new-button)
  "Change BUTTON to NEW-BUTTON."
  (declare (indent 1))
  (let ((newbutton (gensym "newbutton")))
    `(let ((inhibit-read-only t))
       (goto-char (button-start ,button))
       (let ((,newbutton ,new-button))
         (delete-region (point) (button-end ,button))
         (set-marker ,button ,newbutton)))))

(defun telega-button--update-value (button new-value &rest props)
  "Update BUTTON's value to NEW-VALUE.
Additional properties PROPS are updated in button."
  (telega-button--change button
    (apply 'telega-button--insert (button-type button) new-value props)))

(defun telega-button--observable-p (button)
  "Return non-nil if BUTTON is observable in some window.
I.e. shown in some window, see `pos-visible-in-window-p'."
  (when (markerp button)
    (let ((bwin (get-buffer-window (marker-buffer button))))
      (and bwin
           (telega-focus-state (window-frame bwin))
           (pos-visible-in-window-p button bwin)))))

(defun telega-button-forward (n &optional button-type)
  "Move forward to N visible/active button.
If BUTTON-TYPE is specified, then forward only buttons of BUTTON-TYPE."
  (interactive "p")
  (let (button)
    (dotimes (_ (abs n))
      (while (and (setq button (forward-button (cl-signum n)))
                  (or (and button-type
                           (not (eq (button-type button) button-type)))
                      (button-get button 'invisible)
                      (button-get button 'inactive)))))
    (telega-button--help-echo button)
    button))

(defun telega-button-backward (n &optional button-type)
  "Move backward to N visible/active button.
If BUTTON-TYPE is specified, then forward only buttons of BUTTON-TYPE."
  (interactive "p")
  (telega-button-forward (- n) button-type))


;;; Chats part
(defmacro telega-chat-uaprop-del (chat uaprop-name)
  "Delete custom CHAT property named UAPROP-NAME."
  `(telega-chat--set-uaprops
    ,chat (telega-plist-del (plist-get ,chat :uaprops) ,uaprop-name)))

(defmacro telega-chat-uaprop (chat uaprop-name)
  "Return value for CHAT's custom property with name UAPROP-NAME."
  `(plist-get (plist-get ,chat :uaprops) ,uaprop-name))

(gv-define-setter telega-chat-uaprop (value chat uaprop-name)
  "Set CHAT's user property UAPROP-NAME to VALUE.
Return VALUE."
  (let ((valsym (gensym "value")))
    `(let ((,valsym ,value))
       (telega-chat--set-uaprops
        ,chat (plist-put (plist-get ,chat :uaprops) ,uaprop-name ,valsym))
       ,valsym)))

(defsubst telega-chat-username (chat)
  "Return CHAT's username.
Return nil if no username is assigned to CHAT."
  (let ((username (plist-get (telega-chat--info chat) :username)))
    (unless (or (null username) (string-empty-p username))
      username)))

(defsubst telega-chat--order (chat &optional as-string)
  "Return CHAT's order.
If AS-STRING is non-nil, then return it as string."
  (funcall (if as-string 'identity 'string-to-number)
           (or (telega-chat-uaprop chat :order) (plist-get chat :order))))

(defsubst telega-chatbuf-has-input-p ()
  "Return non-nil if chatbuf has some input."
  (< telega-chatbuf--input-marker (point-max)))

(defsubst telega-chatbuf-input-string ()
  "Return non-nil if chatbuf has some input."
  (buffer-substring telega-chatbuf--input-marker (point-max)))

(defsubst telega-chatbuf--input-delete ()
  "Delete chatbuf's input."
  (delete-region telega-chatbuf--input-marker (point-max)))

(defsubst telega-chatbuf--input-draft-p ()
  "Return non-nil if chatbuf input is the draft.
Draft input is the input that have `:draft-input-p' property on both sides."
  (and (get-text-property telega-chatbuf--input-marker :draft-input-p)
       (get-text-property (point-max) :draft-input-p)))

(defsubst telega-chatbuf--cache-msg (msg)
  "Cache MSG in chatbuf's messages cache."
  (puthash (plist-get msg :id) msg telega-chatbuf--messages))


;;; Inserters part
(defun telega-ins (&rest args)
  "Insert all strings in ARGS.
Return non-nil if something has been inserted."
  (< (prog1 (point) (apply 'insert args)) (point)))

(defmacro telega-ins-fmt (fmt &rest args)
  "Insert string formatted by FMT and ARGS.
Return t."
  (declare (indent 1))
  `(telega-ins (format ,fmt ,@args)))

(defmacro telega-ins--as-string (&rest body)
  "Execute BODY inserters and return result as a string."
  `(with-temp-buffer
     ,@body
     (buffer-string)))

(defmacro telega-ins--one-lined (&rest body)
  "Execute BODY making insertation one-lined.
It makes one line by replacing all newlines by spaces."
  `(telega-ins
    (replace-regexp-in-string
     "\n" " " (telega-ins--as-string ,@body))))

(defmacro telega-ins--with-attrs (attrs &rest body)
  "Execute inserters BODY applying ATTRS after insertation.
Return t."
  (declare (indent 1))
  `(telega-ins
    (telega-fmt-eval-attrs (telega-ins--as-string ,@body) ,attrs)))

(defmacro telega-ins--with-face (face &rest body)
  "Execute BODY highlighting result with FACE."
  (declare (indent 1))
  `(telega-ins--with-attrs (list :face ,face)
     ,@body))

(defmacro telega-ins--column (column fill-col &rest body)
  "Execute BODY at COLUMN filling to FILL-COL.
If COLUMN is nil or less then current column, then current column is used."
  (declare (indent 2))
  (let ((colsym (gensym "col"))
        (curcol (gensym "curcol")))
    `(let ((,colsym ,column)
           (,curcol (telega-current-column)))
       (when (or (null ,colsym) (< ,colsym ,curcol))
         (setq ,colsym ,curcol))

       (telega-ins (make-string (- ,colsym ,curcol) ?\s))
;       (move-to-column ,colsym t)
       (telega-ins--with-attrs
           (list :fill 'left
                 :fill-prefix (make-string ,colsym ?\s)
                 :fill-column ,fill-col)
         ,@body))))

(defmacro telega-ins--labeled (label fill-col &rest body)
  "Execute BODY filling it to FILL-COL, prefixing first line with LABEL."
  (declare (indent 2))
  `(progn
     (telega-ins ,label)
     (telega-ins--column nil ,fill-col
       ,@body)))

(defmacro telega-ins--raw-button (props &rest body)
  "Execute BODY creating text button with PROPS."
  (declare (indent 1))
  `(button-at (apply 'make-text-button (prog1 (point) ,@body) (point)
                     ,props)))

(defmacro telega-ins--with-props (props &rest body)
  "Execute inserters applying PROPS after insertation.
Return what BODY returns."
  (declare (indent 1))
  (let ((spnt-sym (gensym "pnt")))
    `(let ((,spnt-sym (point)))
       (prog1
           (progn ,@body)
         (add-text-properties ,spnt-sym (point) ,props)))))

(defmacro telega-ins-prefix (prefix &rest body)
  "In case BODY inserted anything then PREFIX is also inserted before BODY."
  (declare (indent 1))
  (let ((spnt-sym (gensym "pnt")))
    `(let ((,spnt-sym (point)))
       (when (progn ,@body)
         (save-excursion
           (goto-char ,spnt-sym)
           (telega-ins ,prefix))))))

(provide 'telega-core)


;; Need update the value on every load, because value might change,
;; MELPA might change the directory
(setq telega--lib-directory
      (or (and load-file-name
               (file-name-directory load-file-name))
          default-directory))

;;; telega-core.el ends here
