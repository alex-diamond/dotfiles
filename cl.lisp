;; load quicklisp
(load "/usr/share/cl-quicklisp/quicklisp.lisp")
(quicklisp-quickstart:install :path "~/.quicklisp/")
(ql:add-to-init-file)

;; install CEPL
(ql:quickload :sdl2)
(ql:quickload :cepl)
(ql:quickload :cepl.sdl2)
(ql:quickload :cl-opengl)

;; update packages and quicklisp
(ql:update-client)
(ql:update-all-dists)
