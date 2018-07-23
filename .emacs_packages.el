;;; .emacs_packages.el --- Install packages

;;; Commentary:
;;  running only on non MS Windows systems
;;;

;;; Code:
(defvar package-archives)
(add-to-list 'package-archives
             '("melpa-stable" . "https://stable.melpa.org/packages/") t)

;; list of packages
(defvar package-list '(elpy
                       helm
                       magit
                       rtags
                       ggtags
                       company
                       flycheck
                       projectile
                       py-autopep8
                       company-rtags
                       dracula-theme
                       flycheck-rtags
                       helm-projectile))

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

;; Helm
(require 'helm-config)
(helm-mode)
(global-set-key (kbd "M-x") 'helm-M-x)
(global-set-key (kbd "C-x C-f") 'helm-find-files)

;; RTags
(require 'rtags)
(rtags-diagnostics)
(rtags-enable-standard-keybindings)
(setq-default rtags-completions-enabled t
              rtags-autostart-diagnostics t)
(add-hook 'c-mode-hook 'rtags-start-process-unless-running)
(add-hook 'c++-mode-hook 'rtags-start-process-unless-running)

;; GNU Global
(add-hook 'c-mode-common-hook
          (lambda ()
              (when (derived-mode-p 'c-mode 'c++-mode)
                  (ggtags-mode))))

;; Company
(add-to-list 'company-backends 'company-rtags)
(add-hook 'after-init-hook 'global-company-mode)

;; Flycheck
(global-flycheck-mode)
(require 'flycheck-rtags)
(when (require 'flycheck nil t)
    (add-hook 'elpy-mode-hook 'flycheck-mode)
    (setq-default elpy-modules
                  (delq 'elpy-module-flymake elpy-modules)))

;; Projectile
(setq-default projectile-enable-caching t
              projectile-completion-system 'default)

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

;; Helm Projectile
(require 'helm-projectile)
(helm-projectile-on)

;;; .emacs_packages.el ends here
