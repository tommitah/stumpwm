
;; Custom Keybindings
(defvar al/f-keys-alist
  '(("F1"  . "Help")
    ("F2"  . "SunUndo")
    ("F3"  . "SunAgain")
    ("F4"  . "XF86New")
    ("F5"  . "XF86Open")
    ("F6"  . "XF86Close")
    ("F7"  . "XF86Reply")
    ("F8"  . "XF86Forward")
    ("F9"  . "XF86Send")
    ("F10" . "XF86Spell")
    ("F11" . "XF86Save")
    ("F12" . "SunPrint_Screen"))
  "Alist of functional and additional keys bound to the same commands.")


(defun al/define-key (map key command)
  "Similar to `define-key', except KEY should be a string.
If KEY is a functional key from `al/f-keys-alist', bind COMMAND to the
additional key."
  (define-key map (kbd key) command)
  (let ((add-key (cdr (assoc key al/f-keys-alist :test 'equal))))
    (when add-key
      (define-key map (kbd add-key) command))))

(defvar *window-workspace-bindings*
  (let ((m (make-sparse-keymap)))
    (define-key m (kbd "1") "gmove [1. DEV]")
    (define-key m (kbd "2") "gmove [2. GAME]")
    (define-key m (kbd "3") "gmove [3. WEB]")
    (define-key m (kbd "4") "gmove [4. DS]")
    (define-key m (kbd "5") "gmove [5. WAP]")
    (define-key m (kbd "f") "float-this")
    (define-key m (kbd "u") "unfloat-this")
    (define-key m (kbd "l") "flatten-floats")
    ;; (stumpwm:define-key m (stumpwm:kbd "M-b") "move-focus left")
    m ; NOTE: this is important
  ))

(define-key *root-map* (kbd "m") '*window-workspace-bindings*)


;; (defvar *app-bindings*
;;   (let ((m (make-sparse-keymap)))
;;     (define-key m (kbd "d") "exec discord")
;;     (define-key m (kbd "s-p") "exec spotify")
;;     (define-key m (kbd "f") "exec firefox")
;;     (define-key m (kbd "p") "exec postman")
;;     (define-key m (kbd "s") "exec steam")
;;     ;; (stumpwm:define-key m (stumpwm:kbd "M-b") "move-focus left")
;;     m ; NOTE: this is important
;;   ))
;;

;; (define-key *root-map* (kbd "a") '*app-bindings*)

;;;Window management
(al/define-key *root-map* "q" "kill-window")
(al/define-key *root-map* "Q" "delete-window-and-frame")
(al/define-key *root-map* "h" "move-focus left")
(al/define-key *root-map* "j" "move-focus down")
(al/define-key *root-map* "k" "move-focus up")
(al/define-key *root-map* "l" "move-focus right")
(al/define-key *root-map* "H" "move-window left")
(al/define-key *root-map* "J" "move-window down")
(al/define-key *root-map* "K" "move-window up")
(al/define-key *root-map* "L" "move-window right")
(al/define-key *root-map* "RET" "exec kitty")
;;(al/define-key *root-map* "p" "exec rofi -show run")
(al/define-key *root-map* "p" "exec rofi -show run -icon-theme Papirus -show-icons")
(al/define-key *root-map* "V" "vsplit-and-focus")
(al/define-key *root-map* "v" "hsplit-and-focus")
(al/define-key *root-map* "1" "gselect 1")
(al/define-key *root-map* "2" "gselect 2")
(al/define-key *root-map* "3" "gselect 3")
(al/define-key *root-map* "4" "gselect 4")
(al/define-key *root-map* "5" "gselect 5")
;; (al/define-key *root-map* "M-1" "gmove [1. DEV]")
;; (al/define-key *root-map* "M-2" "gmove [2. GAME]")
;; (al/define-key *root-map* "M-3" "gmove [3. WEB]")
;; (al/define-key *root-map* "M-4" "gmove [4. DS]")
;; (al/define-key *root-map* "M-5" "gmove [5. WAP]")
(al/define-key *root-map* "C-m" "mode-line")
