;; -*-lisp-*-
;;
;; Here is a sample .stumpwmrc file

(in-package :stumpwm)
;; (setf *default-package* :stumpwm)

;; autostart shit
(run-shell-command "xrandr --output DP-0 --mode 2560x1440 --rate 120 --primary")
(run-shell-command "picom -b --experimental-backends --backend glx --glx-fshader-win --xrender-sync-fence --vsync --config ~/.config/picom/picom.conf &")
(run-shell-command "nitrogen --restore")
(run-shell-command "dunst --startup_notification true -config ~/.config/dunst/dunstrc")
;;(run-shell-command "( sleep 1s && bash ~/.config/lemonbar/lemonbar.sh | lemonbar -p -F#FFFFFFFF -B#FF222222 -f JetBrains Mono Medium -8 -f FontAwesome-8) &")

(setf *mouse-focus-policy* :click)
(setf *normal-border-width* 3)
(setf *window-border-style* :thick)
(set-focus-color "#ebdbb2")
(set-unfocus-color "#282828")

;; change the prefix key to something else
(run-shell-command "xmodmap -e 'clear mod4' -e 'keycode 133 = F20'")
(set-prefix-key (kbd "F20"))

;; prompt the user for an interactive command. The first arg is an
;; optional initial contents.
(defcommand colon1 (&optional (initial "")) (:rest)
  (let ((cmd (read-one-line (current-screen) ": " :initial-input initial)))
    (when cmd
      (eval-command cmd t))))

;; ;; Read some doc
;; (define-key *root-map* (kbd "d") "exec gv")
;; ;; Browse somewhere
;; (define-key *root-map* (kbd "b") "colon1 exec firefox http://www.")
;; ;; Ssh somewhere
;; (define-key *root-map* (kbd "C-s") "colon1 exec xterm -e ssh ")
;; ;; Lock screen
;; (define-key *root-map* (kbd "C-l") "exec xlock")

;; Web jump (works for DuckDuckGo and Imdb)
(defmacro make-web-jump (name prefix)
  `(defcommand ,(intern name) (search) ((:rest ,(concatenate 'string name " search: ")))
    (nsubstitute #\+ #\Space search)
    (run-shell-command (concatenate 'string ,prefix search))))

(make-web-jump "duckduckgo" "firefox https://duckduckgo.com/?q=")
(make-web-jump "imdb" "firefox http://www.imdb.com/find?q=")

;; C-t M-s is a terrble binding, but you get the idea.
(define-key *root-map* (kbd "M-s") "duckduckgo")
(define-key *root-map* (kbd "i") "imdb")

;; Message window font
(set-font "-xos4-terminus-medium-r-normal--14-140-72-72-c-80-iso8859-15")

;;; Define window placement policy...

;; Clear rules
(clear-window-placement-rules)

;; Last rule to match takes precedence!
;; TIP: if the argument to :title or :role begins with an ellipsis, a substring
;; match is performed.
;; TIP: if the :create flag is set then a missing group will be created and
;; restored from *data-dir*/create file.
;; TIP: if the :restore flag is set then group dump is restored even for an
;; existing group using *data-dir*/restore file.
;; (define-frame-preference "Default"
;;   ;; frame raise lock (lock AND raise == jumpto)
;;   (0 t nil :class "Konqueror" :role "...konqueror-mainwindow")
;;   (1 t nil :class "XTerm"))
;;
;; (define-frame-preference "Ardour"
;;   (0 t   t   :instance "ardour_editor" :type :normal)
;;   (0 t   t   :title "Ardour - Session Control")
;;   (0 nil nil :class "XTerm")
;;   (1 t   nil :type :normal)
;;   (1 t   t   :instance "ardour_mixer")
;;   (2 t   t   :instance "jvmetro")
;;   (1 t   t   :instance "qjackctl")
;;   (3 t   t   :instance "qjackctl" :role "qjackctlMainForm"))
;;
;; (define-frame-preference "Shareland"
;;   (0 t   nil :class "XTerm")
;;   (1 nil t   :class "aMule"))
;;
;; (define-frame-preference "Emacs"
;;   (1 t t :restore "emacs-editing-dump" :title "...xdvi")
;;   (0 t t :create "emacs-dump" :class "Emacs"))

;; Custom functions
(defvar al/init-directory
  (directory-namestring
   (truename (merge-pathnames (user-homedir-pathname)
                              ".stumpwmrc")))
  "A directory with initially loaded files.")

(defun al/load (filename)
  "Load a file FILENAME (without extension) from `al/init-directory'."
  (let ((file (merge-pathnames (concat filename ".lisp")
                               al/init-directory)))
    (if (probe-file file)
        (load file)
        (format *error-output* "File '~a' doesn't exist." file))))

;; Custom Commands
(defcommand delete-window-and-frame () ()
            "Delete the current frame with its window."
            (delete-window)
            (remove-split))

(defcommand hsplit-and-focus () ()
            "Create a new frame on the right and focus it."
            (hsplit)
            (move-focus :right))

(defcommand vsplit-and-focus () ()
            "Create a new frame below and move focus to it."
            (vsplit)
            (move-focus :down))

(al/load "modeline")
(al/load "keybindings")
