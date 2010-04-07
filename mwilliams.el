;; mwilliams.el
;; ------------
;; My custom Emacs settings

;; Disable VC
(setq vc-handled-backends nil)

; Default to hippie-expand for the smart expand stuff
(global-set-key (kbd "M-/") 'hippie-expand)

; Navigate buffers
(windmove-default-keybindings) 

; Start with the scratch buffer
(setq inhibit-startup-message t)

; Get rid of scroll bars
(scroll-bar-mode -1)

;; Load my path
(setenv "PATH" (concat (getenv "PATH") ":/usr/local/bin"))
(setq exec-path (append exec-path '("/usr/local/bin")))

;; (setq explicit-shell-file-name "shell")

;; Load my shell (defined in ~/bin/eshell so zsh properly loads
;; and all the theming works correctly
(setenv "ESHELL" (expand-file-name "~/bin/eshell"))
(setenv "explicit-shell-file-name" "shell")

(autoload 'ansi-color-for-comint-mode-on "ansi-color" nil t)
(add-hook 'shell-mode-hook 'ansi-color-for-comint-mode-on)

;; Save backups in one place
;; Put autosave files (ie #foo#) in one place, *not*
;; scattered all over the file system!
;; (make-directory autosave-dir t)

(setq
   backup-by-copying t      ; don't clobber symlinks
   backup-directory-alist
    '(("." . "~/.saves"))    ; don't litter my fs tree
   delete-old-versions t
   kept-new-versions 6
   kept-old-versions 2
   version-control t)       ; use versioned backups


;; Uniquify buffer names when files are open with the same file name
;; from different projects

(require 'uniquify) 
(setq 
  uniquify-buffer-name-style 'post-forward
  uniquify-separator ":")

;; Set tabbing
(setq default-tab-width 2)
(setq tab-width 2)

;; nXhtml
(load "~/.emacs.d/vendor/nxhtml/autostart.el")

(load "/usr/local/share/emacs/site-lisp/rdebug.el")

;; Cucumber.el
(add-to-list 'load-path "~/.emacs.d/vendor/cucumber.el/")
(require 'feature-mode)
(add-to-list 'auto-mode-alist '("\.feature$" . feature-mode))

;; Color theme
(add-to-list 'load-path "~/.emacs.d/vendor/color-theme")
(require 'color-theme)
(color-theme-initialize)

;; Emacs nav
(add-to-list 'load-path "~/.emacs.d/vendor/emacs-nav")
(require 'nav)

;; Rspec Snippets
;;(load-library (concat "~/.emacs.d/vendor/yasnippets-rspec/setup.el"))


;; Change font size
(define-key global-map (kbd "C-+") 'text-scale-increase)
(define-key global-map (kbd "C--") 'text-scale-decrease)

;; Set the font
;; (set-face-font 'default "-apple-Anonymous_Pro-medium-normal-normal-*-*-*-*-*-m-0-iso10646-1")

;; From starter-kit-misc.el from the emacs-starter-kit

; Set what browser to open webpages in
(setq browse-url-browser-function 'browse-url-default-macosx-browser)

; You really don't need this; trust me.
(menu-bar-mode -1)

; Save a list of recent files visited.
(recentf-mode 1)

; Highlight matching parentheses when the point is on them.
(show-paren-mode 1)

; ido-mode is like magic pixie dust!
(when (> emacs-major-version 21)
  (ido-mode t)
  (setq ido-enable-prefix nil
        ido-enable-flex-matching t
        ido-create-new-buffer 'always
        ido-use-filename-at-point t
        ido-max-prospects 10))

(set-default 'indent-tabs-mode nil)
(set-default 'indicate-empty-lines t)
(set-default 'imenu-auto-rescan t)

(defalias 'yes-or-no-p 'y-or-n-p)
(random t) ;; Seed the random-number generator

;; Associate modes with file extensions

(add-to-list 'auto-mode-alist '("COMMIT_EDITMSG$" . diff-mode))
(add-to-list 'auto-mode-alist '("\\.css$" . css-mode))
(add-to-list 'auto-mode-alist '("\\.rb$" . ruby-mode))
(add-to-list 'auto-mode-alist '("Rakefile$" . ruby-mode))
(add-to-list 'auto-mode-alist '("\\.rake$" . ruby-mode))
(add-to-list 'auto-mode-alist '("\\.xml$" . nxml-mode))
(add-to-list 'auto-mode-alist '("\\.html$" . html-mode))
(add-to-list 'auto-mode-alist '("\\.rhtml$" . html-mode))
(add-to-list 'auto-mode-alist '("\\.org\\'" . org-mode))

;; From starter-kit-defun.el from the emacs-starter-kit

(defun untabify-buffer ()
  (interactive)
  (untabify (point-min) (point-max)))

(defun indent-buffer ()
  (interactive)
  (indent-region (point-min) (point-max)))

(defun cleanup-buffer ()
  "Perform a bunch of operations on the whitespace content of a buffer."
  (interactive)
  (indent-buffer)
  (untabify-buffer)
  (delete-trailing-whitespace))

;; From starter-kit-bindings from the emacs-starter-kit

; Align your code in a pretty way.
(global-set-key (kbd "C-x \\") 'align-regexp)

; Perform general cleanup.
(global-set-key (kbd "C-c n") 'cleanup-buffer)

; Use regex searches by default.
(global-set-key "\C-s" 'isearch-forward-regexp)
(global-set-key "\C-r" 'isearch-backward-regexp)

; File finding
(global-set-key (kbd "C-x M-f") 'ido-find-file-other-window)
(global-set-key (kbd "C-x C-M-f") 'find-file-in-project)
(global-set-key (kbd "C-x f") 'recentf-ido-find-file)
(global-set-key (kbd "C-x C-p") 'find-file-at-point)
(global-set-key (kbd "C-c y") 'bury-buffer)
(global-set-key (kbd "C-c r") 'revert-buffer)
(global-set-key (kbd "M-`") 'file-cache-minibuffer-complete)
(global-set-key (kbd "C-x C-b") 'ibuffer)

; Start eshell or switch to it if it's active.
(global-set-key (kbd "C-x m") 'eshell)

;; Lorem ipsum
(defun lorem ()
  "Insert a lorem ipsum."
  (interactive)
  (insert "Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do "
          "eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim"
          "ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut "
          "aliquip ex ea commodo consequat. Duis aute irure dolor in "
          "reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla "
          "pariatur. Excepteur sint occaecat cupidatat non proident, sunt in "
          "culpa qui officia deserunt mollit anim id est laborum."))

(defun hashrocket ()
  "Inserts a hashrocket (=>) surrounded by spaces."
  (interactive)
  (insert " => ")) 

(defun close-all-buffers ()
  "Close all open buffers."
  (interactive)
  (loop for buffer being the buffers
    do (kill-buffer buffer)))

;; Other
(global-set-key [(meta up)] 'beginning-of-buffer)
(global-set-key [(meta down)] 'end-of-buffer)
(prefer-coding-system 'utf-8)

(defun color-theme-vivid-chalk () 
  "Based on Vivid Chalk, a vim port of Vibrant Ink." 
  (interactive) 
  (color-theme-install 
   '(color-theme-vivid-chalk 
     ((background-color . "black") 
      (background-mode . dark) 
      (border-color . "black") 
      (cursor-color . "white") 
      (foreground-color . "white") 
      (list-matching-lines-face . bold) 
      (view-highlight-face . highlight)) 
     (default ((t (nil)))) 
     (bold ((t (:bold t)))) 
     (bold-italic ((t (:italic t :bold t)))) 
     (fringe ((t (:background "black")))) 
     (font-lock-builtin-face ((t (:foreground "#aaccff")))) 
     (font-lock-comment-face ((t (:italic t :foreground "#9933cc")))) 
     (font-lock-comment-delimiter-face ((t (:foreground "#9933cc")))) 
     (font-lock-constant-face ((t (:foreground "#339999")))) 
     (font-lock-function-name-face ((t (:foreground "#ffcc00")))) 
     (font-lock-keyword-face ((t (:foreground "#ff6600")))) 
     (font-lock-preprocessor-face ((t (:foreground "#aaffff")))) 
     (font-lock-reference-face ((t (:foreground "LightSteelBlue")))) 
     (font-lock-string-face ((t (:foreground "#66FF00")))) 
     (font-lock-doc-face ((t (:foreground "LightSalmon")))) 
     (font-lock-type-face ((t (:italic t :foreground "#aaaaaa")))) 
     (font-lock-variable-name-face ((t (:foreground "#aaccff")))) 
     (font-lock-warning-face ((t (:bold t :foreground "Pink")))) 
     (paren-face-match-light ((t (:background "#222222")))) 
     (highlight ((t (:background "darkolivegreen")))) 
     (italic ((t (:italic t)))) 
     (modeline ((t (:background "#a5baf1" :foreground "black")))) 
     (modeline-buffer-id ((t (:background "#a5baf1" :foreground 
"black")))) 
     (modeline-mousable ((t (:background "#a5baf1" :foreground 
"black")))) 
     (modeline-mousable-minor-mode ((t (:background 
"#a5baf1" :foreground "black")))) 
     (region ((t (:background "#555577")))) 
     (primary-selection ((t (:background "#555577")))) 
     (isearch ((t (:background "#555555")))) 
     (zmacs-region ((t (:background "#555577")))) 
     (secondary-selection ((t (:background "darkslateblue")))) 
     (flymake-errline ((t (:background "LightSalmon" :foreground 
"black")))) 
     (flymake-warnline ((t (:background "LightSteelBlue" :foreground 
"black")))) 
     (underline ((t (:underline t)))) 
     (minibuffer-prompt ((t (:bold t :foreground "#ff6600"))))))) 
(color-theme-vivid-chalk)

(setq swank-clojure-extra-classpaths
    (list "/Users/mwilliams/Projects/programming-clojure"))

(defun maximize-frame () 
  (interactive)
  (set-frame-position (selected-frame) 0 0)
  (set-frame-size (selected-frame) 1000 1000))

(global-set-key (kbd "M-RET") 'ns-toggle-fullscreen)

(defun swap-with (dir)
  (interactive)
  (let ((other-window (windmove-find-other-window dir)))
    (when other-window
      (let* ((this-window  (selected-window))
             (this-buffer  (window-buffer this-window))
             (other-buffer (window-buffer other-window))
             (this-start   (window-start this-window))
             (other-start  (window-start other-window)))
        (set-window-buffer this-window  other-buffer)
        (set-window-buffer other-window this-buffer)
        (set-window-start  this-window  other-start)
        (set-window-start  other-window this-start)))))
 
(global-set-key (kbd "C-M-J") (lambda () (interactive) (swap-with 'down)))
(global-set-key (kbd "C-M-K") (lambda () (interactive) (swap-with 'up)))
(global-set-key (kbd "C-M-H") (lambda () (interactive) (swap-with 'left)))
(global-set-key (kbd "C-M-L") (lambda () (interactive) (swap-with 'right)))
 
(global-set-key (kbd "M-J") (lambda () (interactive) (enlarge-window 1)))
(global-set-key (kbd "M-K") (lambda () (interactive) (enlarge-window -1)))
(global-set-key (kbd "M-H") (lambda () (interactive) (enlarge-window -1 t)))
(global-set-key (kbd "M-L") (lambda () (interactive) (enlarge-window 1 t)))
 
(global-set-key (kbd "M-j") 'windmove-down)
(global-set-key (kbd "M-k") 'windmove-up)
(global-set-key (kbd "M-h") 'windmove-left)
(global-set-key (kbd "M-l") 'windmove-right)

;; Tabbing stuff

;; (global-set-key [(tab)] 'smart-tab)
;; (defun smart-tab ()
;;   "This smart tab is minibuffer compliant: it acts as usual in
;;     the minibuffer. Else, if mark is active, indents region. Else if
;;     point is at the end of a symbol, expands it. Else indents the
;;     current line."
;;   (interactive)
;;   (if (minibufferp)
;;       (unless (minibuffer-complete)
;;         (dabbrev-expand nil))
;;     (if mark-active
;;         (indent-region (region-beginning)
;;                        (region-end))
;;       (if (looking-at "\\_>")
;;           (dabbrev-expand nil)
;;         (indent-for-tab-command)))))
(server-start)