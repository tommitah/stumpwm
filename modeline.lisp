(in-package :stumpwm)

;; turn on/off the mode line for the current head only.
; (toggle-mode-line (current-screen)
;                           (current-head))

; (defvar al/date-refresh-time 120)
;
; (al/defun-with-delay
;  al/date-refresh-time al/ml-date ()
;  (al/ml-string (time-format "%a %d %b")))

; (load-module "cpu")
; (load-module "mpd")
; (load-module "mem")
; (load-module "net")
; (load-module "wifi")
; (ql:quickload :clx-truetype)
; (load-module "ttf-fonts")
; (set-font `(,(make-instance 'xft:font :family "JetBrains Mono" :subfamily "Medium" :size 16 :antialias t)))

(setf *window-format* "%m%n%s%c")
;; (setf *screen-mode-line-format* (list "[%g^B%n^b] %W^>%d"))
(setf *screen-mode-line-format* (list "[%g^B^b] %W^>%d"))
(setf *time-modeline-string* "%a %b %e %k:%M")

(setf *mode-line-timeout* 2)

(setf *mode-line-background-color* "#1F1F28")
(setf *mode-line-foreground-color* "#DCD7BA")

;; Groups
(when *initializing*
  (grename "[1. DEV]")
  (gnewbg "[2. GAME]")
  (gnewbg "[3. WEB]")
  (gnewbg "[4. DS]")
  (gnewbg "[5. WAP]"))

(setf *group-format* "%t")
(setf *window-format* "%n: %30t")

(setf *mode-line-pad-y* 5)
(setf *mode-line-pad-x* 3)
(setf *mode-line-border-color* "#282828")

(clear-window-placement-rules)

;;(define-frame-preference "[FILES]" (nil t t :class "Nemo"))
(setf *dynamic-group-master-split-ratio* 1/2)

; (setf cpu::*cpu-modeline-fmt*        "%c"
;       cpu::*cpu-usage-modeline-fmt*  "^f2^f0^[~A~2D%^]"
;       mem::*mem-modeline-fmt*        "%a%p"
;       wifi:*wifi-modeline-fmt*       "%e %P"
;       wifi:*use-colors*              nil
;       mpd:*mpd-modeline-fmt*         "%a - %t"
;       mpd:*mpd-status-fmt*           "%a - %t"
;       *hidden-window-color*          "^**"
;       *mode-line-highlight-template* "«~A»")
;
; (defvar *mode-line-formatter-list*
;   '(("%g") ("%W") ("^>") ("mu-unread" . t) ("%m") ("%I") ("%l") ("%C") ("%M") ("%B") ("%d"))
;   "List of formatters for the modeline.")
;
; (defun generate-modeline (elements &optional not-invertedp rightp)
;   "Generate a modeline for StumpWM.
; ELEMENTS should be a list of `cons'es which `car' is the modeline
; formatter or the shell command to run, and their `cdr' is either nil
; when the `car' is a formatter and t when it is a shell command."
;   (when elements
;     (cons (format nil
;                   " ^[~A^]^(:bg \"~A\") "
;                   (format nil "^(:fg \"~A\")^(:bg \"~A\")^f1~A^f0"
;                           (if (xor not-invertedp rightp) phundrak-nord1 phundrak-nord3)
;                           (if (xor not-invertedp rightp) phundrak-nord3 phundrak-nord1)
;                           (if rightp "" ""))
;                   (if not-invertedp phundrak-nord3 phundrak-nord1))
;           (let* ((current-element (car elements))
;                  (formatter       (car current-element))
;                  (commandp        (cdr current-element)))
;             (cons (if commandp
;                       `(:eval (run-shell-command ,formatter t))
;                     (format nil "~A" formatter))
;                   (generate-modeline (cdr elements)
;                                      (not not-invertedp)
;                                      (if (string= "^>" (caar elements)) t rightp)))))))
;
; (defcommand reload-modeline () ()
;             "Reload modeline."
;             (setf *screen-mode-line-format*
;                   (cdr (generate-modeline *mode-line-formatter-list*))))
;

(setf *mode-line-position* :bottom)
(enable-mode-line (current-screen) (current-head) t)

; (reload-modeline)

;; Figure out how this shite works
; (ql:quickload :clx-truetype)
; (load-module "ttf-fonts")
; (xft:cache-fonts) ;; Tell clx-truetype about the fonts you have installed. You really only need to do this once, but putting it here means you will not forget in the future.
; (set-font (make-instance 'xft:font :family "JetBrains Mono" :subfamily "Medium" :size 16))
