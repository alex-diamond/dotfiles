;;; .emacs_packages.el --- Packages installation and configuration

;;; Commentary:
;;  running only on non Microsoft Windows systems
;;;

;;; Code:
(unless package-archive-contents
    (package-refresh-contents))
(defvar package-list '(rtags
                       ggtags
                       company
                       dracula-theme
                       modern-cpp-font-lock))
(dolist (package package-list)
    (unless (package-installed-p package)
        (package-install package)))

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
(require 'company)
(global-company-mode)

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
