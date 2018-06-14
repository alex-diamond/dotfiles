;; AUTHOR: KARLKORP
;; COPYRIGHT (C) KARLKORP
;; GNU EMACS CONFIGURATION FILE
;; E-MAIL: LISPGOD@GMAIL.COM

(require 'bs)
(setq-default major-mode 'text-mode)

(require 'org)
(org-babel-do-load-languages
 'org-babel-load-languages
 '((C . t)
   (sh . t)
   (lisp . t)
   (perl . t)
   (latex . t)
   (python . t)
   (scheme . t)
   (matlab . t)
   (octave . t)
   (makefile . t)
   (emacs-lisp . t)))

(setq-default user-full-name "karlkorp"
              user-mail-adress "lispgod@gmail.com"
              browse-url-browser-function 'browse-url-default-browser)

(require 'dired)
(setq-default dired-recursive-deletes 'top)

(require 'imenu)
(setq-default imenu-auto-rescan t
              imenu-use-popup-menu nil)

(tooltip-mode -1)
(tool-bar-mode -1)
(scroll-bar-mode -1)
(blink-cursor-mode -1)
(global-hl-line-mode -1)

(if (display-graphic-p)
    (progn
        (menu-bar-mode)
        (require 'linum)
        (line-number-mode)
        (global-linum-mode)
        (fringe-mode '(8 . 0))
        (load-theme 'wombat t)
        (setq-default linum-format " %d ")
        (setq-default cursor-type 'hollow)
        (add-to-list 'default-frame-alist '(top . 37))
        (add-to-list 'default-frame-alist '(left . 37))
        (add-to-list 'default-frame-alist '(width . 111))
        (add-to-list 'default-frame-alist '(height . 37))
        (if (member "Ubuntu Mono" (font-family-list))
            (set-frame-font "Ubuntu Mono-12:antialias=natural"
                            nil nil)))
    (menu-bar-mode -1))

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
(setq-default frame-title-format
              "GNU EMACS - NOSCE TE IPSUM")

(auto-fill-mode)
(display-time-mode)
(setq-default
 display-time-24hr-format t)
(column-number-mode)
(size-indication-mode)
(global-visual-line-mode)
(setq-default word-wrap t
              fill-column 81)
(setq-default auto-save-default nil
              make-backup-files nil)

(require 'ido)
(ido-mode t)
(ido-everywhere)
(setq-default
 ido-enable-flex-matching t)
(icomplete-mode)
(require 'ibuffer)
(defalias 'list-buffers 'ibuffer)

(require 'font-lock)
(global-font-lock-mode)
(setq-default
 font-lock-maximum-decoration t)

(electric-pair-mode -1)
(electric-indent-mode -1)

(defalias 'perl-mode 'cperl-mode)
(setq-default cperl-indent-level 4)
(setq-default tab-width 4
              standard-indent 4
              indent-tabs-mode nil)
(add-hook 'makefile-mode-hook
          (lambda ()
              (setq indent-tabs-mode t)))
(setq-default c-basic-offset 4
              c-default-style "k&r")
(setq-default lisp-body-indent 4
              lisp-indent-function
              'common-lisp-indent-function)
(setq-default python-indent 4
              python-indent-offset 4)

(setq-default scroll-step 1
              scroll-margin 10
              mouse-wheel-follow-mouse t
              scroll-conservatively 10000
              mouse-wheel-progressive-speed nil
              mouse-wheel-scroll-amount '(1 ((shift) . 1)))

(global-auto-revert-mode)
(setq-default require-final-newline t
              next-line-add-newlines nil)

(prefer-coding-system 'utf-8)
(set-language-environment 'UTF-8)
(set-terminal-coding-system 'utf-8)
(set-selection-coding-system 'utf-8)
(set-keyboard-coding-system 'utf-8-unix)
(setq-default coding-system-for-read 'utf-8
              file-name-coding-system 'utf-8
              default-buffer-file-coding-system 'utf-8)

(require 'cedet)
(require 'cc-mode)
(defvar *semantic-modes*
  (list
   'global-semanticdb-minor-mode
   'global-semantic-decoration-mode
   'global-semantic-mru-bookmark-mode
   'global-semantic-highlight-func-mode
   'global-semantic-idle-scheduler-mode
   'global-semantic-idle-completions-mode
   'global-semantic-show-parser-state-mode))
(let (mode)
    (dolist (mode *semantic-modes*)
        (add-to-list 'semantic-default-submodes mode)))
(semantic-mode)
(require 'semantic/ia)
(require 'semantic/bovine/gcc)
(global-ede-mode)
(require 'ede/generic)
(ede-enable-generic-projects)

(require 'bookmark)
(when (file-exists-p
       (concat user-emacs-directory "bookmarks"))
    (bookmark-load bookmark-default-file t))
(setq-default bookmark-save-flag t
              bookmark-default-file
              (concat user-emacs-directory "bookmarks"))

(when (string-equal system-type "gnu/linux")
    (require 'cl)
    (require 'slime)
    (require 'slime-autoloads)
    (slime-setup '(slime-asdf
                   slime-fancy
                   slime-indentation))
    (setq-default inferior-lisp-program "sbcl"
                  slime-net-coding-system 'utf-8-unix))

(defun format-buffer ()
    (interactive)
    (save-excursion
     (delete-trailing-whitespace)
     (if (not (equal major-mode 'makefile-gmake-mode))
         (untabify (point-min) (point-max))
         (tabify (point-min) (point-max)))
     (unless (or (equal major-mode 'python-mode)
                 (equal major-mode 'makefile-gmake-mode))
         (indent-region (point-min) (point-max) nil))))

(global-unset-key [up])
(global-unset-key [down])
(global-unset-key [left])
(global-unset-key [right])
(global-set-key (kbd "<f1>") 'format-buffer)
(global-set-key (kbd "<f2>") 'imenu)
(global-set-key (kbd "<f3>") 'bs-show)
(global-set-key (kbd "<f4>") 'bookmark-set)
(global-set-key (kbd "<f5>") 'bookmark-jump)
(global-set-key (kbd "<f6>") 'bookmark-bmenu-list)
(global-set-key (kbd "<f7>") 'kmacro-start-macro)
(global-set-key (kbd "<f8>") 'kmacro-end-macro)
(global-set-key (kbd "<f9>") 'kmacro-call-macro)
(global-set-key (kbd "\C-ca") 'org-agenda)
(global-set-key (kbd "\C-cc") 'org-capture)
(global-set-key (kbd "\C-cb") 'org-iswitchb)
(global-set-key (kbd "\C-cl") 'org-store-link)
(global-set-key (kbd "RET") 'newline-and-indent)
