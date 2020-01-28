;; Look at https://tuhdo.github.io/emacs-tutor.html for interesting ones

(cheatsheet-add :group 'Basics
    :key "C-x C-c"
    :description "quit")
(cheatsheet-add :group 'Basics
    :key "C-x C-s"
    :description "save buffer")
(cheatsheet-add :group 'Basics
    :key "C-x C-f"
    :description "open file")
(cheatsheet-add :group 'Basics
    :key "C-x b"
    :description "switch to open buffer")
(cheatsheet-add :group 'Basics
    :key "C-g"
    :description "cancel")
(cheatsheet-add :group 'Basics
    :key "C-x k"
    :description "close current buffer")
(cheatsheet-add :group 'Basics
    :key "C-h a"
    :description "look up docs for command")
(cheatsheet-add :group 'Basics
    :key "M-x"
    :description "execute command")
(cheatsheet-add :group 'Basics
    :key "C-x u"
    :description "undo")
(cheatsheet-add :group 'Basics
    :key "C-/"
    :description "undo")

(cheatsheet-add :group 'Motion
    :key "C-a"
    :description "beginning of line")
(cheatsheet-add :group 'Motion
    :key "C-e"
    :description "end of line")
(cheatsheet-add :group 'Motion
    :key "C-f"
    :description "forward character")
(cheatsheet-add :group 'Motion
    :key "C-b"
    :description "backward character")
(cheatsheet-add :group 'Motion
    :key "C-p"
    :description "down a line")
(cheatsheet-add :group 'Motion
    :key "C-n"
    :description "up a line")
(cheatsheet-add :group 'Motion
    :key "M-f"
    :description "forward word")
(cheatsheet-add :group 'Motion
    :key "M-b"
    :description "backward word")
(cheatsheet-add :group 'Motion
    :key "M-e"
    :description "forward sentence")
(cheatsheet-add :group 'Motion
    :key "M-a"
    :description "backward sentence")
(cheatsheet-add :group 'Motion
    :key "M-}"
    :description "forward paragraph")
(cheatsheet-add :group 'Motion
    :key "M-{"
    :description "backward  paragraph")
(cheatsheet-add :group 'Motion
    :key "M->"
    :description "start of buffer")
(cheatsheet-add :group 'Motion
    :key "M-<"
    :description "end of buffer")
(cheatsheet-add :group 'Motion
    :key "S-<any_of_the_above>"
    :description "navigate and select")
(cheatsheet-add :group 'Motion
    :key "C-space"
    :description "start selection")
(cheatsheet-add :group 'Motion
    :key "C-M-f"
    :description "forward-sexp")
(cheatsheet-add :group 'Motion
    :key "C-M-b"
    :description "backward-sexp")
(cheatsheet-add :group 'Motion
    :key "C-M-k"
    :description "kill-sexp")
(cheatsheet-add :group 'Motion
    :key "C-M-t"
    :description "transpose-sexps")
(cheatsheet-add :group 'Motion
    :key "C-u C-SPC"
    :description "Move to last mark")
(cheatsheet-add :group 'Motion
    :key "C-x C-x"
    :description "Exchange point and mark")

(cheatsheet-add :group 'Registers
		:key "C-x r s REG"
		:description  "copy to register")
  	
(cheatsheet-add :group 'Registers
		:key "C-x r i REG"
		:description "insert register")

(cheatsheet-add :group 'KeyboardMacroCounter
		:key "C-x C-k C-i"
  		:description "Insert counter of current macro into  buffer")

(cheatsheet-add :group 'KeyboardMacroCounter
		:key "C-x C-k C-c"
  		:description "Change the counter value of current macro")

(cheatsheet-add :group 'KeyboardMacroCounter
		:key "C-x C-k C-a"
  		:description "Add number to kmacro counter")
(cheatsheet-add :group 'KeyboardMacroCounter
		:key "C-x C-k C-f"
  		:description "Specify macro counter format")

(cheatsheet-add :group 'Cut_Paste
    :key "C-w"
    :description "cut")
(cheatsheet-add :group 'Cut_Paste
    :key "C-y"
    :description "paste")

(cheatsheet-add :group 'Searching
    :key "C-s"
    :description "search")
(cheatsheet-add :group 'Searching
    :key "C-r"
    :description "search backward")
(cheatsheet-add :group 'Searching
    :key "C-M-s"
    :description "regexp search")
(cheatsheet-add :group 'Searching
    :key "C-M-r"
    :description "regexp search backward")
(cheatsheet-add :group 'Searching
    :key "M-x grep RET "
    :description "prompt for grep command")
(cheatsheet-add :group 'Searching
    :key "C-x `"
    :description "Visit next grep hit")
(cheatsheet-add :group 'Searching
    :key "M-%"
    :description "search and replace")
(cheatsheet-add :group 'Searching
    :key "M-s h ."
    :description "highlight symbol at point")
(cheatsheet-add :group 'Searching
    :key "M-s h l"
    :description "highlight lines that match input regexp")
(cheatsheet-add :group 'Searching
    :key "M-s h r"
    :description "highlight according to input regex")
(cheatsheet-add :group 'Searching
    :key "M-s h u"
    :description "turn off highlighting according to input regex")

(cheatsheet-add :group 'Rgrep
    :key "M-x rgrep"
    :description "open rgrep buffer")
(cheatsheet-add :group 'Rgrep
    :key "TAB"
    :description "go to next match")

(cheatsheet-add :group 'Rgrep
    :key "S-TAB"
    :description "go to previous match")

(cheatsheet-add :group 'Occur
    :key "M-s o"
    :description "run occur")

(cheatsheet-add :group 'Occur
    :key "M-g n"
    :description "go to next match")
(cheatsheet-add :group 'Occur
    :key "C-x z"
    :description "to repeat previous command")

(cheatsheet-add :group 'Deletion
    :key "C-d"
    :description "delete character ahead")
(cheatsheet-add :group 'Deletion
    :key "M-d"
    :description "delete word ahead")
(cheatsheet-add :group 'Deletion
    :key "backspace"
    :description "delete character behind")
(cheatsheet-add :group 'Deletion
    :key "M-backspace"
    :description "delete word behind")
(cheatsheet-add :group 'Deletion
    :key "C-k"
    :description "cut from cursor to end of line")
(cheatsheet-add :group 'Deletion
    :key "C-S-DEL"
    :description "Kill entire line")
(cheatsheet-add :group 'Deletion
    :key "M-k"
    :description "Kill a sentence")
(cheatsheet-add :group 'Deletion
    :key "M-\\"
    :description "Kill all spaces at point")
(cheatsheet-add :group 'Deletion
    :key "M-SPC"
    :description "Kill all spaces except one at point")

(cheatsheet-add :group 'Insertion
    :key "C-o"
    :description "insert newline after cursor")

(cheatsheet-add :group 'Scrolling
    :key "C-v"
    :description "scrolling down")
(cheatsheet-add :group 'Scrolling
    :key "M-v"
    :description "scrolling up")

(cheatsheet-add :group 'Command-related
    :key "C-h k"
    :description "show command description")
(cheatsheet-add :group 'Command-related
    :key "C-h a"
    :description "command apropos")
(cheatsheet-add :group 'Command-related
    :key "C-h c"
    :description "command name on message line")
(cheatsheet-add :group 'Command-related
    :key "C-h f"
    :description "describe function")
(cheatsheet-add :group 'Command-related
    :key "C-h i"
    :description "info browser")

(cheatsheet-add :group 'Frames
    :key "C-x 2"
    :description "split window horizontally")
(cheatsheet-add :group 'Frames
    :key "C-x 3"
    :description "split window vertically")
(cheatsheet-add :group 'Frames 
    :key "C-x 1"
    :description "unsplit window")
(cheatsheet-add :group 'Frames
    :key "C-x o"
    :description "switch to other pane in split window")

(cheatsheet-add :group 'Tricks
    :key "M-q"
    :description "auto-hard-wrap current paragraph")
(cheatsheet-add :group 'Tricks
    :key "C-t"
    :description "swap the two characters at the cursor")
(cheatsheet-add :group 'Tricks
    :key "M-u"
    :description "uppercase the word at the cursor")
(cheatsheet-add :group 'Tricks
    :key "M-l"
    :description "lowercase the word at the cursor")
(cheatsheet-add :group 'Tricks
    :key "C-u <n> <char>"
    :description "insert *n* copies of <char>")
(cheatsheet-add :group 'Tricks
    :key "M-;"
    :description "add a Comment at EOL")

(cheatsheet-add :group 'Tricks
    :key "M-/"
    :description "Dynamic Abbreviations")

(cheatsheet-add :group 'Tricks
    :key "C-x <KEY> C-h"
    :description "List of keybinds for KEY")

(cheatsheet-add :group 'Evaluation
		:key "C-c C-b"
		:description "eval buffer")

(cheatsheet-add :group 'Org
		:key "TAB/S-TAB"
		:description "(Un)Fold")

(cheatsheet-add :group 'Org
		:key "M-up/Down"
		:description "Move a headline up or down")

(cheatsheet-add :group 'Org
		:key "M-left/right"
		:description "promote/demote a headline")

(cheatsheet-add :group 'Org
		:key "M-RET"
		:description "Insert a new headline")

(cheatsheet-add :group 'IBuffer
		:key "/ m"
		:description "Filter major modes within IBuffer")

(cheatsheet-add :group 'IBuffer
		:key "A"
		:description "Marked a buffer")

(cheatsheet-add :group 'IBuffer
		:key "A"
		:description "View marked buffers")

(cheatsheet-add :group 'IBuffer
		:key "S"
		:description "Save the marked buffers")

(cheatsheet-add :group 'IBuffer
		:key "D"
		:description "Close marked buffers")

(cheatsheet-add :group 'IBuffer
		:key "V"
		:description "Discard changes to the marked buffers")

(cheatsheet-add :group 'IBuffer
		:key "/ n"
 		:description "Add a filter by buffer name")
		
(cheatsheet-add :group 'IBuffer
		:key "/ c"
		:description "Add a filter by buffer content")
		
(cheatsheet-add :group 'IBuffer
		:key "/ f"
		:description "Add a filter by filename")

(cheatsheet-add :group 'IBuffer
		:key "/ >"
		:description "Add a filter by buffer size")

(cheatsheet-add :group 'IBuffer
		:key "/ <"
		:description "Add a filter by buffer size")

(cheatsheet-add :group 'IBuffer
		:key "/ /"
		:description "Remove all filters in effect")

(cheatsheet-add :group 'Bookmarks
		:key "C-x r m"
		:description "Set bookmark")

(cheatsheet-add :group 'Bookmarks
		:key "C-x r b"
		:description "Jump to bookmark")

(cheatsheet-add :group 'Bookmarks
		:key "C-x r l"
		:description "List bookmarks")

(cheatsheet-add :group 'Customized
		:key "C-c u"
		:description "Kill lines backward")

(cheatsheet-add :group 'VersionControl
		:key "C-x v ="
 		:description "changes you've made to the current files")

(cheatsheet-add :group 'Crux
                :key "C-k"
                :description "crux-smart-kill-line")
(cheatsheet-add :group 'Crux
                :key "C-x C-u"
                :description "crux-upcase-region")
(cheatsheet-add :group 'Crux
                :key "C-S-RET"
                :description "crux-smart-open-line-above")
(cheatsheet-add :group 'Crux
                :key "C-c n"
                :description "crux-cleanup-buffer-or-region")
(cheatsheet-add :group 'Crux
                :key "C-c f"
                :description "crux-recentf-find-file")
(cheatsheet-add :group 'Crux
                :key "C-c u"
                :description "crux-view-url")
(cheatsheet-add :group 'Crux
                :key "C-c e"
                :description "crux-eval-and-replace")
(cheatsheet-add :group 'Crux
                :key "C-c D"
                :description "crux-delete-buffer-and-file")
(cheatsheet-add :group 'Crux
                :key "C-c M-d"
                :description "crux-duplicate-and-comment-current-line-or-region")
(cheatsheet-add :group 'Crux
                :key "C-c k"
                :description "crux-kill-other-buffers")
(cheatsheet-add :group 'Crux
                :key "C-x C-u"
                :description "crux-upcase-region")
(cheatsheet-add :group 'Crux
                :key "C-x C-l"
                :description "crux-downcase-region")
(cheatsheet-add :group 'Crux
                :key "C-x M-c"
                :description "crux-capitalize-region")
