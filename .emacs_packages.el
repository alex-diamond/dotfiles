(require 'cl)
(require 'cl-lib)
(require 'package)
(add-to-list 'package-archives
             '("melpa" . "http://melpa.org/packages/") t)

;; list of packages
(defvar required-packages '(elpy
                            rtags
                            company
                            neotree
                            flycheck
                            py-autopep8
                            company-rtags
                            flycheck-rtags
                            material-theme))

;; checking the installation of packages
(defun packages-installed-p ()
    (loop for package in required-packages
          unless (package-installed-p package)
            do (return nil)
          finally (return t)))

;; package installation
(unless (packages-installed-p)
    (package-refresh-contents)
    (dolist (package required-packages)
        (unless (package-installed-p package)
            (package-install package))))

;; Elpy
(elpy-enable)
(setq-default elpy-rpc-python-command "python3"
              python-shell-interpreter "jupyter"
              python-shell-prompt-detect-failure-warning nil
              python-shell-interpreter-args "console --simple-prompt")
(add-to-list 'python-shell-completion-native-disabled-interpreters "jupyter")

;; RTags
(require 'rtags)
(rtags-diagnostics)
(setq-default rtags-completions-enabled t
              rtags-autostart-diagnostics t)
(add-hook 'c-mode-hook 'rtags-start-process-unless-running)
(add-hook 'c++-mode-hook 'rtags-start-process-unless-running)

;; Company
(require 'company)
(global-company-mode)
(require 'flycheck-rtags)
(push 'company-rtags company-backends)

;; NeoTree
(require 'neotree)
(global-set-key (kbd "<f10>") 'neotree-toggle)

;; Flycheck
(add-hook 'after-init-hook 'global-flycheck-mode)
(when (require 'flycheck nil t)
    (setq-default elpy-modules (delq 'elpy-module-flymake elpy-modules))
    (add-hook 'elpy-mode-hook 'flycheck-mode))

;; py-autopep8
(require 'py-autopep8)
(add-hook 'elpy-mode-hook 'py-autopep8-enable-on-save)

;; SLIME
(require 'slime)
(require 'slime-autoloads)
(slime-setup '(slime-asdf
               slime-fancy
               slime-indentation))
(setq-default inferior-lisp-program   "sbcl"
              slime-net-coding-system 'utf-8-unix)
