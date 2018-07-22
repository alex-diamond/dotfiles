;;; .emacs_packages.el --- Install packages

;;; Commentary:
;;  running only on non MS Windows systems

;;; Code:
(defvar package-archives)
(add-to-list 'package-archives
             '("melpa" . "http://melpa.org/packages/") t)

;; list of packages
(defvar package-list '(elpy
                       magit
                       rtags
                       company
                       flycheck
                       py-autopep8
                       company-rtags
                       flycheck-rtags
                       material-theme))

;; packages installation
(package-refresh-contents)
(dolist (package package-list)
    (unless (package-installed-p package)
        (package-install package)))

;; Elpy
(elpy-enable)
(setq-default elpy-shell-echo-input nil
              elpy-rpc-python-command "python3"
              python-shell-interpreter "ipython3"
              python-shell-prompt-detect-failure-warning nil
              python-shell-interpreter-args "-i --simple-prompt")

;; RTags
(require 'rtags)
(rtags-diagnostics)
(rtags-enable-standard-keybindings)
(setq-default rtags-completions-enabled t
              rtags-autostart-diagnostics t)
(add-hook 'c-mode-hook 'rtags-start-process-unless-running)
(add-hook 'c++-mode-hook 'rtags-start-process-unless-running)

;; Company
(add-to-list 'company-backends 'company-rtags)
(setq-default company-jedi-python-bin "python3")
(add-hook 'after-init-hook 'global-company-mode)

;; Flycheck
(global-flycheck-mode)
(require 'flycheck-rtags)
(when (require 'flycheck nil t)
    (add-hook 'elpy-mode-hook 'flycheck-mode)
    (setq-default elpy-modules (delq 'elpy-module-flymake elpy-modules)))

;; py-autopep8
(require 'py-autopep8)
(add-hook 'elpy-mode-hook 'py-autopep8-enable-on-save)

;; SLIME
(require 'slime)
(require 'slime-autoloads)
(slime-setup '(slime-asdf
               slime-fancy
               slime-indentation))
(setq-default inferior-lisp-program "sbcl"
              slime-net-coding-system 'utf-8-unix)

;;; .emacs_packages.el ends here
