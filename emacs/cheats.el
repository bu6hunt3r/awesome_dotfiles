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




