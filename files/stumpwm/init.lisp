(require :ttf-fonts)
(setf xft:*font-dirs* '("/run/current-system/profile/share/fonts/"))
(setf clx-truetype:+font-cache-filename+ (concat (getenv "HOME") "/.fonts/font-cache.sexp"))
(xft:cache-fonts)
(set-font (make-instance 'xft:font :family "Iosevka Term" :size 12))

;; (run-shell-command "xsetroot -cursor_name left_ptr")

;; (setf *time-modeline-string* "%a %b %e %k:%M")
;; (setf *window-format* "%m%n%s%c")
;; (setf *screen-mode-line-format* (list "[^B%n^b] %W^>%d"))
;; `(enable-mode-line (current-screen) (current-head) t) ;

