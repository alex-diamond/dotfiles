;;; .emacs_packages.el --- Packages installation and configuration

;;; Commentary:
;;  running only on non Microsoft Windows systems
;;;

;;; Code:
(unless package-archive-contents
    (package-refresh-contents))

(defvar package-list '(elpy
                       rtags
                       ggtags
                       company
                       py-autopep8
                       company-rtags
                       dracula-theme
                       modern-cpp-font-lock))

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

;; GNU Global
(require 'ggtags)
(add-hook 'c-mode-common-hook
          '(lambda ()
            (when (derived-mode-p 'c-mode 'c++-mode)
                (ggtags-mode))))

;; Company
(add-to-list 'company-backends 'company-rtags)
(add-hook 'after-init-hook 'global-company-mode)

;; py-autopep8
(require 'py-autopep8)
(add-hook 'elpy-mode-hook 'py-autopep8-enable-on-save)

;; SLIME
(require 'slime)
(require 'slime-autoloads)
(slime-setup '(slime-asdf
               slime-fancy
               slime-tramp
               slime-indentation))
(setq-default inferior-lisp-program "sbcl"
              slime-net-coding-system 'utf-8-unix)

;; Modern C++
(require 'modern-cpp-font-lock)
(modern-c++-font-lock-global-mode)

;;; .emacs_packages.el ends here
