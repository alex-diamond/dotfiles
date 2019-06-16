;;; .emacs --- GNU Emacs configuration file

;;; Commentary:
;;  GNU Emacs general configuration
;;;

;;; Code:
(tooltip-mode        -1)
(menu-bar-mode       -1)
(tool-bar-mode       -1)
(auto-fill-mode      -1)
(scroll-bar-mode     -1)
(global-hl-line-mode -1)

(setq-default major-mode 'text-mode)

(require 'bs     nil :noerror)
(require 'org    nil :noerror)
(require 'eldoc  nil :noerror)
(require 'cl-lib nil :noerror)

(when (require 'package nil :noerror)
  (package-initialize)
  (setq-default package-enable-at-startup nil))

(when (require 'dired nil :noerror)
  (setq-default dired-recursive-deletes 'top))

(icomplete-mode)
(global-subword-mode)
(transient-mark-mode)
(delete-selection-mode)
(global-auto-revert-mode)
(setq-default show-paren-delay 0
              show-paren-style 'parenthesis)

(show-paren-mode)
(column-number-mode)
(size-indication-mode)
(setq-default truncate-lines                 t
              global-visual-line-mode        nil
              truncate-partial-width-windows nil)

(setq-default search-highlight        t
              query-replace-highlight t)

(defalias 'yes-or-no-p 'y-or-n-p)
(setq-default use-dialog-box nil)

(setq-default frame-title-format "%b")

(setq-default inhibit-startup-screen t
              initial-scratch-message "")

(display-time-mode)
(setq-default display-time-24hr-format t)
(setq-default ring-bell-function 'ignore)

(when (not indicate-empty-lines)
  (toggle-indicate-empty-lines)
  (setq-default indicate-empty-lines t
                indicate-buffer-boundaries 'left))

(savehist-mode)
(save-place-mode)
(setq-default history-length 1000
              history-delete-duplicates        t
              savehist-save-minibuffer-history t)

(setq-default version-control      t
              auto-save-default    t
              backup-by-copying    t
              kept-new-versions    3
              kept-old-versions    1
              make-backup-files    t
              delete-old-versions  t
              vc-make-backup-files t
              backup-directory-alist '(("." . "~/.emacs.d/backups")))

(when (require 'ido nil :noerror)
  (ido-mode t)
  (ido-everywhere)
  (setq-default ido-use-virtual-buffers  t
                ido-enable-flex-matching t))

(when (require 'imenu nil :noerror)
  (setq-default imenu-auto-rescan    t
                imenu-use-popup-menu nil))

(when (require 'ibuffer nil :noerror)
  (defalias 'list-buffers 'ibuffer))

(when (require 'font-lock nil :noerror)
  (global-font-lock-mode)
  (global-prettify-symbols-mode)
  (setq-default font-lock-maximum-decoration t))

(setq-default abbrev-mode t
              save-abbrevs 'silent)

(electric-indent-mode)
(electric-pair-mode -1)

(defalias 'perl-mode 'cperl-mode)
(setq-default cperl-indent-level 2)

(setq-default tab-width 2
              standard-indent 2
              indent-tabs-mode nil
              tab-always-indent 'complete)

(setq-default c-basic-offset 2
              c-default-style "bsd")
(add-hook 'c-mode-common-hook
          '(lambda () (c-toggle-auto-newline)))
(add-hook 'makefile-mode-hook
          '(lambda () (setq-default indent-tabs-mode t)))

(setq-default python-indent 2
              python-indent-offset 2
              python-indent-guess-indent-offset nil)
(if (executable-find "ipython3")
    (setq-default python-shell-interpreter "ipython3"
                  python-shell-interpreter-args "--simple-prompt -i"))

(setq-default lisp-body-indent 2
              lisp-indent-function 'common-lisp-indent-function)

(setq-default scroll-step 1
              scroll-margin 10
              redisplay-dont-pause t
              mouse-wheel-follow-mouse t
              scroll-conservatively 10000
              mouse-wheel-progressive-speed nil
              recenter-position '(top middle bottom)
              mouse-wheel-scroll-amount '(1 ((shift) . 1)))

(setq-default delete-trailing-lines     t
              require-final-newline     t
              next-line-add-newlines    nil
              sentence-end-double-space nil)

(when (require 'whitespace nil :noerror)
  (global-whitespace-mode)
  (setq-default whitespace-line-column 80
                whitespace-style '(face empty tabs
                                   lines-tail trailing)))

(prefer-coding-system                   'utf-8)
(set-language-environment               'UTF-8)
(set-keyboard-coding-system             'utf-8-unix)
(set-terminal-coding-system             'utf-8)
(set-selection-coding-system            'utf-8)
(setq-default coding-system-for-read    'utf-8
              file-name-coding-system   'utf-8
              buffer-file-coding-system 'utf-8)

(require 'cedet   nil :noerror)
(require 'cc-mode nil :noerror)

(when (require 'ede/generic nil :noerror)
  (global-ede-mode)
  (ede-enable-generic-projects))

(when (require 'semantic nil :noerror)
  (semantic-mode)
  (require 'semantic/ia         nil :noerror)
  (require 'semantic/bovine/gcc nil :noerror)
  (when (executable-find "gtags")
    (semanticdb-enable-gnu-global-databases 'c-mode)
    (semanticdb-enable-gnu-global-databases 'c++-mode))
  (defvar *semantic-submodes*
    (list 'global-semanticdb-minor-mode
          'global-semantic-decoration-mode
          'global-semantic-stickyfunc-mode
          'global-semantic-idle-summary-mode
          'global-semantic-mru-bookmark-mode
          'global-semantic-highlight-func-mode
          'global-semantic-idle-scheduler-mode
          'global-semantic-highlight-edits-mode
          'global-semantic-idle-completions-mode
          'global-semantic-show-parser-state-mode
          'global-semantic-show-unmatched-syntax-mode
          'global-semantic-idle-local-symbol-highlight-mode))
  (dolist (submode *semantic-submodes*)
    (add-to-list 'semantic-default-submodes submode)))

(when (require 'bookmark nil :noerror)
  (setq-default bookmark-save-flag t)
  (if (file-exists-p (concat user-emacs-directory "bookmarks"))
      (bookmark-load bookmark-default-file t)))

(when (display-graphic-p)
  (when (require 'linum nil :noerror)
    (global-linum-mode)
    (setq-default linum-format "%5d "))
  (line-number-mode)
  (blink-cursor-mode)
  (fringe-mode '(10 . 10))
  (setq-default cursor-type 'hollow)
  (if (require 'color-theme nil :noerror)
      (progn (color-theme-initialize)
             (color-theme-charcoal-black))
      (load-theme 'wombat t))
  (when (member "Consolas" (font-family-list))
    (set-frame-font "Consolas-14" t t))
  (add-to-list 'default-frame-alist '(top . 10))
  (add-to-list 'default-frame-alist '(left . 10))
  (add-to-list 'default-frame-alist '(width . 120))
  (add-to-list 'default-frame-alist '(height . 40)))

(defun format-buffer ()
  (save-excursion
   (delete-trailing-whitespace)
   (if (equal major-mode 'makefile-gmake-mode)
       (tabify (point-min) (point-max))
       (untabify (point-min) (point-max)))
   (unless (or (equal major-mode 'text-mode)
               (equal major-mode 'python-mode)
               (equal major-mode 'makefile-gmake-mode))
     (indent-region (point-min) (point-max) nil))))
(add-hook 'before-save-hook 'format-buffer)

(when (require 'slime       nil :noerror)
  (require 'slime-autoloads nil :noerror)
  (slime-setup '(slime-asdf
                 slime-fancy
                 slime-tramp
                 slime-indentation))
  (if (executable-find "sbcl")
      (setq-default inferior-lisp-program "sbcl"))
  (setq-default slime-net-coding-system 'utf-8-unix))

(when (require 'racket-mode nil :noerror)
  (add-hook 'racket-mode-hook      #'racket-unicode-input-method-enable)
  (add-hook 'racket-repl-mode-hook #'racket-unicode-input-method-enable))

(if (executable-find "guile")
    (setq-default scheme-program-name "guile")
    (setq-default scheme-program-name "scheme"))
(autoload 'run-scheme "cmuscheme" "Run an inferior Scheme" t)

(global-unset-key [up])
(global-unset-key [down])
(global-unset-key [left])
(global-unset-key [right])
(windmove-default-keybindings)
(global-set-key (kbd "<f1>")  'speedbar)
(global-set-key (kbd "<f2>")  'ibuffer)
(global-set-key (kbd "<f3>")  'comment-line)
(global-set-key (kbd "<f4>")  'bookmark-set)
(global-set-key (kbd "<f5>")  'bookmark-jump)
(global-set-key (kbd "<f6>")  'bookmark-bmenu-list)
(global-set-key (kbd "<f7>")  'kmacro-start-macro)
(global-set-key (kbd "<f8>")  'kmacro-end-macro)
(global-set-key (kbd "<f9>")  'kmacro-call-macro)
(global-set-key (kbd "<f10>") 'toggle-menu-bar-mode-from-frame)
(global-set-key (kbd "<f11>") 'toggle-frame-fullscreen)

;;; .emacs ends here
