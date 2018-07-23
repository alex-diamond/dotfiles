;;; .emacs --- GNU Emacs configuration file

;;; Commentary:
;;  GNU Emacs general configuration
;;;

;;; Code:
(require 'cl-lib)
(require 'package)
(let* ((no-ssl (and (memq system-type '(windows-nt ms-dos))
                    (not (gnutls-available-p))))
       (proto (if no-ssl "http" "https")))
    (add-to-list 'package-archives
                 (cons "melpa" (concat proto "://melpa.org/packages/")) t)
    (when (< emacs-major-version 24)
        (add-to-list 'package-archives
                     '("gnu" . (concat proto "://elpa.gnu.org/packages/")))))
(package-initialize)
(if (not (memq system-type '(windows-nt ms-dos)))
    (load "$HOME/.emacs_packages.el"))

(require 'bs)
(setq-default major-mode 'text-mode)

(require 'org)

(require 'dired)
(setq-default dired-recursive-deletes 'top)

(require 'imenu)
(setq-default imenu-auto-rescan t
              imenu-use-popup-menu nil)

(tooltip-mode        -1)
(tool-bar-mode       -1)
(menu-bar-mode       -1)
(scroll-bar-mode     -1)
(blink-cursor-mode   -1)
(global-hl-line-mode -1)

(if (display-graphic-p)
    (progn
        (require 'linum)
        (line-number-mode)
        (global-linum-mode)
        (fringe-mode '(10 . 0))
        (setq-default linum-format "%5d ")
        (setq-default cursor-type 'hollow)
        (if (not (memq system-type '(windows-nt ms-dos)))
            (load-theme 'dracula t)
            (load-theme 'misterioso t))
        (add-to-list 'default-frame-alist '(top . 40))
        (add-to-list 'default-frame-alist '(left . 40))
        (add-to-list 'default-frame-alist '(width . 120))
        (add-to-list 'default-frame-alist '(height . 40))))

(show-paren-mode)
(delete-selection-mode)
(setq-default show-paren-delay 0
              show-paren-style 'parenthesis)

(setq-default inhibit-startup-screen t
              initial-scratch-message "")

(defalias 'yes-or-no-p 'y-or-n-p)
(setq-default use-dialog-box nil
              redisplay-dont-pause t)
(setq-default ring-bell-function 'ignore)
(setq-default indicate-empty-lines t
              indicate-buffer-boundaries 'left)
(setq-default frame-title-format "GNU EMACS - NOSCE TE IPSUM")

(auto-fill-mode)
(display-time-mode)
(column-number-mode)
(size-indication-mode)
(global-visual-line-mode)
(setq-default word-wrap t
              fill-column 80)
(setq-default auto-save-default nil
              make-backup-files nil)
(setq-default display-time-24hr-format t)

(require 'ido)
(ido-mode t)
(ido-everywhere)
(setq-default ido-enable-flex-matching t)
(icomplete-mode)
(require 'ibuffer)
(defalias 'list-buffers 'ibuffer)

(require 'font-lock)
(global-font-lock-mode)
(setq-default font-lock-maximum-decoration t)

(electric-indent-mode)
(electric-pair-mode -1)

(defalias 'perl-mode 'cperl-mode)
(setq-default cperl-indent-level 4)
(setq-default tab-width 4
              standard-indent 4
              indent-tabs-mode nil
              tab-always-indent nil)
(add-hook 'makefile-mode-hook
          (lambda ()
              (setq-default indent-tabs-mode t)))
(setq-default c-basic-offset 4
              c-default-style "bsd")
(add-hook 'c-mode-common-hook
          '(lambda () (c-toggle-auto-state 1)))
(setq-default python-indent 4
              python-indent-offset 4)
(setq-default lisp-body-indent 4
              lisp-indent-function 'common-lisp-indent-function)

(setq-default scroll-step 1
              scroll-margin 10
              mouse-wheel-follow-mouse t
              scroll-conservatively 10000
              mouse-wheel-progressive-speed nil
              mouse-wheel-scroll-amount '(1 ((shift) . 1)))

(global-auto-revert-mode)
(setq-default require-final-newline t
              next-line-add-newlines nil)

(prefer-coding-system                   'utf-8)
(set-language-environment               'UTF-8)
(set-terminal-coding-system             'utf-8)
(set-selection-coding-system            'utf-8)
(set-keyboard-coding-system             'utf-8-unix)
(setq-default coding-system-for-read    'utf-8
              file-name-coding-system   'utf-8
              buffer-file-coding-system 'utf-8)

(require 'cedet)
(require 'cc-mode)
(require 'semantic)
(require 'semantic/ia)
(require 'ede/generic)
(require 'semantic/bovine/gcc)
(defvar *semantic-modes*
  (list 'global-semanticdb-minor-mode
        'global-semantic-decoration-mode
        'global-semantic-mru-bookmark-mode
        'global-semantic-highlight-func-mode
        'global-semantic-idle-scheduler-mode
        'global-semantic-idle-completions-mode
        'global-semantic-show-parser-state-mode))
(dolist (mode *semantic-modes*)
    (add-to-list 'semantic-default-submodes mode))
(semantic-mode)
(global-ede-mode)
(ede-enable-generic-projects)

(setq-default abbrev-mode t
              save-abbrevs 'silent
              abbrev-file-name "$HOME/.emacs.d/abbrev_defs")

(require 'bookmark)
(when (file-exists-p
       (concat user-emacs-directory "bookmarks"))
    (bookmark-load bookmark-default-file t))
(setq-default bookmark-save-flag t
              bookmark-default-file
              (concat user-emacs-directory "bookmarks"))

(defun format-buffer ()
    "Buffer formatting: DTW, tabify/untabify, indent."
    (interactive)
    (save-excursion
     (delete-trailing-whitespace)
     (if (equal major-mode 'makefile-gmake-mode)
         (tabify (point-min) (point-max))
         (untabify (point-min) (point-max)))
     (unless (or (equal major-mode 'python-mode)
                 (equal major-mode 'makefile-gmake-mode))
         (indent-region (point-min) (point-max) nil))))
;; Buffer formatting before save
(add-hook 'before-save-hook 'format-buffer)

(global-unset-key [up])
(global-unset-key [down])
(global-unset-key [left])
(global-unset-key [right])
(windmove-default-keybindings)
(global-set-key (kbd "<f2>")  'ibuffer)
(global-set-key (kbd "<f3>")  'comment-line)
(global-set-key (kbd "<f4>")  'bookmark-set)
(global-set-key (kbd "<f5>")  'bookmark-jump)
(global-set-key (kbd "<f6>")  'bookmark-bmenu-list)
(global-set-key (kbd "<f7>")  'kmacro-start-macro)
(global-set-key (kbd "<f8>")  'kmacro-end-macro)
(global-set-key (kbd "<f9>")  'kmacro-call-macro)
(global-set-key (kbd "<f11>") 'toggle-frame-fullscreen)

(setq-default browse-url-browser-function 'browse-url-default-browser)

;;; .emacs ends here
