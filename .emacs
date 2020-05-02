(require 'package)
(package-initialize)
(setq-default package-check-signature nil)
(add-to-list 'package-archives
             '("melpa" . "https://melpa.org/packages/") t)
(when (not package-archive-contents)
  (package-refresh-contents))
(defvar package-list '(org
                       helm
                       magit
                       rtags
                       slime
                       pos-tip
                       company
                       racket-mode
                       company-rtags
                       dracula-theme
                       modern-cpp-font-lock))
(dolist (package package-list)
  (unless (package-installed-p package)
    (package-install package)))

(tooltip-mode        -1)
(menu-bar-mode       -1)
(tool-bar-mode       -1)
(auto-fill-mode      -1)
(scroll-bar-mode     -1)
(global-hl-line-mode -1)

(require 'bs     nil :noerror)
(require 'org    nil :noerror)
(require 'eldoc  nil :noerror)
(require 'cl-lib nil :noerror)

(setq-default common-tab-width 2)

(when (require 'package nil :noerror)
  (package-initialize)
  (setq-default package-enable-at-startup nil))

(setq-default delete-by-moving-to-trash t)

(setq-default backward-delete-char-untabify-method 'hungry)

(when (require 'dired nil :noerror)
  (setq-default dired-recursive-copies  'always)
  (setq-default dired-recursive-deletes 'always))

(setq-default major-mode         'text-mode
              initial-major-mode 'fundamental-mode)

(icomplete-mode)
(global-subword-mode)
(transient-mark-mode)
(delete-selection-mode)
(global-auto-revert-mode)
(setq-default debug-on-error             t
              show-paren-delay           0
              show-paren-style          'parenthesis
              x-select-enable-clipboard  t)

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

(setq-default inhibit-startup-screen  t
              initial-scratch-message nil)

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
              kept-new-versions    2
              kept-old-versions    1
              make-backup-files    t
              delete-old-versions  t
              vc-make-backup-files t
              backup-directory-alist '(("." . "~/.emacs.d/backups")))

(when (require 'recentf nil :noerror)
  (setq-default recentf-max-menu-items   10
                recentf-max-saved-items 100)
  (recentf-mode))

(when (require 'imenu nil :noerror)
  (setq-default imenu-auto-rescan    t
                imenu-use-popup-menu nil))

(when (require 'ibuffer nil :noerror)
  (defalias 'list-buffers 'ibuffer))

(when (require 'font-lock nil :noerror)
  (global-font-lock-mode)
  (global-prettify-symbols-mode)
  (setq-default font-lock-maximum-decoration t))

(when (require 'modern-cpp-font-lock nil :noerror)
  (modern-c++-font-lock-global-mode))

(setq-default abbrev-mode   t
              save-abbrevs 'silent)

(electric-indent-mode)
(electric-pair-mode -1)

(defalias 'perl-mode 'cperl-mode)
(setq-default cperl-indent-level common-tab-width)

(setq-default tab-width          common-tab-width
              standard-indent    common-tab-width
              indent-tabs-mode   nil
              tab-always-indent 'complete)

(setq-default f90-do-indent                common-tab-width
              f90-smart-end               'blink
              f90-if-indent                common-tab-width
              f90-type-indent              common-tab-width
              fortran-do-indent            common-tab-width
              fortran-if-indent            common-tab-width
              f90-program-indent           common-tab-width
              f90-continuation-indent      8
              fortran-structure-indent     common-tab-width
              fortran-continuation-string "&")

(defun c-common-mode ()
  (c-toggle-auto-newline      1)
  (c-toggle-auto-hungry-state 1))

(setq-default c-basic-offset   common-tab-width
              c-default-style "bsd")

(when (require 'cc-mode nil :noerror)
  (add-hook 'c-mode-common-hook 'c-common-mode))

(add-hook 'makefile-mode-hook
          '(lambda () (setq-default indent-tabs-mode t)))

(setq-default python-indent        common-tab-width
              python-indent-offset common-tab-width
              python-indent-guess-indent-offset nil)

(if (executable-find "ipython3")
    (setq-default python-shell-interpreter "ipython3"
                  python-shell-interpreter-args "--simple-prompt -i")
    (if (executable-find "python3")
        (setq-default python-shell-interpreter "python3"
                      python-shell-interpreter-args "-i")))

(setq-default lisp-body-indent      common-tab-width
              lisp-indent-function 'common-lisp-indent-function)

(setq-default scroll-step 1
              scroll-margin 10
              redisplay-dont-pause t
              mouse-wheel-follow-mouse t
              scroll-conservatively 10000
              mouse-wheel-progressive-speed nil
              recenter-position '(top middle bottom)
              mouse-wheel-scroll-amount '(1 ((shift) . 1)))

(setq-default track-eol                 t
              kill-whole-line           t
              line-move-visual          nil
              delete-trailing-lines     t
              require-final-newline     t
              next-line-add-newlines    nil
              show-trailing-whitespace  t
              sentence-end-double-space nil)

(when (require 'whitespace nil :noerror)
  (global-whitespace-mode)
  (setq-default whitespace-line-column 80
                whitespace-style '(face empty tabs lines-tail trailing)))

(prefer-coding-system                   'utf-8)
(set-language-environment               'UTF-8)
(set-keyboard-coding-system             'utf-8-unix)
(set-terminal-coding-system             'utf-8)
(set-selection-coding-system            'utf-8)
(setq-default coding-system-for-read    'utf-8
              file-name-coding-system   'utf-8
              buffer-file-coding-system 'utf-8)

(require 'cedet                 nil :noerror)
(when (require 'semantic        nil :noerror)
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
    (add-to-list 'semantic-default-submodes submode))
  (semantic-mode))

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
  (load-theme 'dracula t)
  (setq-default cursor-type 'hollow)
  (if (member "JetBrains Mono" (font-family-list))
      (set-frame-font "JetBrains Mono 13" t t))
  (add-to-list 'default-frame-alist '(top    .  10))
  (add-to-list 'default-frame-alist '(left   .  10))
  (add-to-list 'default-frame-alist '(width  . 120))
  (add-to-list 'default-frame-alist '(height .  40)))

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

(if (require 'helm nil :noerror)
    (progn
      (require 'helm-config)
      (helm-mode)
      (global-set-key (kbd "M-x")     'helm-M-x)
      (global-set-key (kbd "C-x C-f") 'helm-find-files)
      (global-set-key (kbd "C-x r b") 'helm-filtered-bookmarks))
    (when (require 'ido nil :noerror)
      (ido-mode t)
      (ido-everywhere)
      (setq-default ido-use-virtual-buffers  t
                    ido-enable-flex-matching t)))

(when (require 'slime       nil :noerror)
  (require 'slime-autoloads nil :noerror)
  (slime-setup '(slime-asdf
                 slime-fancy
                 slime-tramp
                 slime-indentation))
  (if (executable-find "sbcl")
      (setq-default inferior-lisp-program "sbcl"))
  (setq-default slime-net-coding-system 'utf-8-unix))

(when (require 'ggtags nil :noerror)
  (add-hook 'c-mode-common-hook
            '(lambda () (when (derived-mode-p 'c-mode 'c++-mode)
                          (ggtags-mode)))))

(when (require 'rtags nil :noerror)
  (rtags-diagnostics)
  (rtags-enable-standard-keybindings)
  (setq-default rtags-completions-enabled   t
                rtags-autostart-diagnostics t)
  (add-hook 'c-mode-hook   'rtags-start-process-unless-running)
  (add-hook 'c++-mode-hook 'rtags-start-process-unless-running))

(when (require 'company nil :noerror)
  (add-hook 'after-init-hook 'global-company-mode)
  (eval-after-load 'company
                   '(add-to-list 'company-backends 'company-rtags)))

(when (require 'racket-mode nil :noerror)
  (add-hook 'racket-mode-hook      #'racket-unicode-input-method-enable)
  (add-hook 'racket-repl-mode-hook #'racket-unicode-input-method-enable))

(if (executable-find "scheme")
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
