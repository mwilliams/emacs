;; mwilliams.el
;; ------------
;; My custom Emacs settings

; Start with the scratch buffer
(setq inhibit-startup-message t)

;; Load my path
(setenv "PATH" (concat (getenv "PATH") ":/usr/local/bin"))
(setq exec-path (append exec-path '("/usr/local/bin")))

;; Load my shell (defined in ~/bin/eshell so zsh properly loads
;; and all the theming works correctly
(setenv "ESHELL" (expand-file-name "~/bin/eshell"))
(autoload 'ansi-color-for-comint-mode-on "ansi-color" nil t)
(add-hook 'shell-mode-hook 'ansi-color-for-comint-mode-on)

;; Save backups in one place
;; Put autosave files (ie #foo#) in one place, *not*
;; scattered all over the file system!
(defvar autosave-dir
  (concat "/tmp/emacs_autosaves/" (user-login-name) "/"))

(make-directory autosave-dir t)

;; Set tabbing
(setq default-tab-width 2)
(setq tab-width 2)

;; Snippets via yasnippet
(add-to-list 'load-path "/Users/mwilliams/.emacs.d/vendor/yasnippet")
(require 'yasnippet)
(yas/initialize)
(yas/load-directory "/Users/mwilliams/.emacs.d/vendor/yasnippet/snippets")

;; Color theme
(add-to-list 'load-path "/Users/mwilliams/.emacs.d/vendor/color-theme")
(require 'color-theme)
(color-theme-initialize)

;; Twilight Emacs
(load-file  "/Users/mwilliams/.emacs.d/vendor/twilight-emacs/color-theme-twilight.el")
(color-theme-twilight)

;; Change font size
(define-key global-map (kbd "C-+") 'text-scale-increase)
(define-key global-map (kbd "C--") 'text-scale-decrease)

;; Set the font
(set-face-font 'default "-apple-Anonymous_Pro-medium-normal-normal-*-*-*-*-*-m-0-iso10646-1")

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



;; Other

(global-set-key [(meta up)] 'beginning-of-buffer)
(global-set-key [(meta down)] 'end-of-buffer)

(prefer-coding-system 'utf-8)