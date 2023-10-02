;; Global keys
(global-set-key (kbd "<f5>") 'revert-buffer)
(global-set-key (kbd "M-/") 'delete-horizontal-space)
(global-set-key (kbd "C-c b") 'backward-sexp)
(global-set-key (kbd "C-c f") 'forward-sexp)


;; When the <> keys are not accessible by the left hand
; (global-set-key (kbd "M-z") 'beginning-of-buffer)
; (global-set-key (kbd "M-Z") 'end-of-buffer)

;; When on mac
(setq mac-right-option-modifier 'none)

;; Global settings
(global-display-line-numbers-mode 1)
(setq linum-format " %d ")

;; Disable auto-files
(setq make-backup-files nil)
(setq auto-save-default nil)
(setq create-lockfiles nil)

;; Disable annoying sound
(setq ring-bell-function 'ignore)

;; Disable byte compilation warnings
(setq byte-compile-warnings nil)

;; Do not open new window when doing an ediff
(setq ediff-window-setup-function 'ediff-setup-windows-plain)

;; If emacs is built with svg support, else use 'dvipng
;; (setq org-preview-latex-default-process 'dvisvg)

;; Customize org's latex output
(setq org-latex-default-class "article")
(setq org-export-with-date t)
(setq org-export-with-toc 2)
(setq org-export-with-author t)
(setq org-export-with-email nil)
(setq org-list-allow-alphabetical t)
(setq org-export-with-section-numbers t)
(setq org-latex-toc-command "\\tableofcontents \\clearpage")
(setq org-latex-default-packages-alist '(("auto" "inputenc" t ("pdflatex"))
					 ("T1" "fontenc" t ("pdflatex"))
					 (#1="" "graphicx" t)
					 (#1# "longtable" nil)
					 (#1# "wrapfig" nil)
					 (#1# "rotating" nil)
					 ("normalem" "ulem" t)
					 (#1# "amsmath" t)
					 (#1# "amssymb" t)
					 (#1# "capt-of" nil)
					 (#1# "parskip" nil})
					 ("document" "ragged2e" nil)
					 ("colorlinks, linkcolor=blue, anchorcolor=blue, urlcolor=blue, citecolor=blue" "hyperref" nil)))
(setq org-latex-listings 'minted
      org-latex-packages-alist '(("" "minted"))
      org-latex-pdf-process
      '("pdflatex -shell-escape -interaction nonstopmode -output-directory %o %f"
        "pdflatex -shell-escape -interaction nonstopmode -output-directory %o %f"))

(setq tex-fontify-script nil)

;; Disable annoying auto-indentations in org mode
(setq org-src-preserve-indentation t)
(setq org-adapt-indentation nil)

;; When making something bold, don't see the stars around it
(setq org-hide-emphasis-markers t)

(setq org-startup-folded t)

(setq org-babel-C++-compiler "clang++")

;; Silence compiler warnings as they can be pretty disruptive
(setq comp-async-report-warnings-errors nil)

;; emacs' default identation style is lame
(setq c-default-style "linux"
      c-basic-offset 2)

; (setq tab-always-indent 'complete)

;; UI preferences
(setq inhibit-startup-message t)
(winner-mode 1)
(scroll-bar-mode -1)
(tool-bar-mode -1)
(menu-bar-mode -1)
(set-face-attribute 'default nil :font "Fira Code Retina" :height 150)

(org-babel-do-load-languages 'org-babel-load-languages
			     '((python . t)
			       (emacs-lisp . t)
			       (C . t)
			       (js . t)
			       (ditaa . t)
			       (dot . t)
			       (org . t)
			       (latex . t)
			       (shell . t)
			       ))

;; Initialize package sources
(require 'package)
(setq package-archives '(("melpa" . "https://melpa.org/packages/")
			 ("melpa-stable" . "https://stable.melpa.org/packages/")
			 ("org" . "https://orgmode.org/elpa/")
			 ("nongnu" . "https://elpa.nongnu.org/nongnu/")
			 ("elpa" . "https://elpa.gnu.org/packages/")))

(package-initialize)
(unless package-archive-contents
  (package-refresh-contents))
(unless (package-installed-p 'use-package)
  (package-install 'use-package))
(require 'use-package)
(setq use-package-always-ensure t)

(use-package doom-themes
  :defer t
  :init
  (load-theme 'doom-opera t))


(use-package pdf-tools)

;; Make bold color a bit more discrete for doom opera
(defface org-bold
  '((t :foreground "#ECBE7B"
       :background "#2e2e2e"
       :weight bold
       :underline t
       ))
  "Face for org-mode bold."
  :group 'org-faces )

(setq org-emphasis-alist
  '(("*" ;; (bold :foreground "Orange" )
     org-bold)
    ("/" italic)
    ("_" underline)
    ("=" ;; (:background "maroon" :foreground "white")
     org-verbatim verbatim)
    ("~" ;; (:background "deep sky blue" :foreground "MidnightBlue")
     org-code verbatim)
    ("+" (:strike-through t))))

(use-package org-contrib)
(add-to-list 'org-export-backends 'taskjuggler)

;; Make math formulas readable
(plist-put org-format-latex-options :scale 2)

(use-package multiple-cursors)

(use-package dot-mode)

(use-package expand-region
  :bind ("C-M-SPC" . er/expand-region))

(use-package ace-window
  :config
  (global-set-key (kbd "C-x o") 'ace-window))

(use-package swiper)

(use-package ivy
  :diminish
  :bind (("C-s" . swiper)
	 :map ivy-minibuffer-map
	 ("TAB" . ivy-alt-done)
	 :map ivy-switch-buffer-map
	 ("C-k" . ivy-switch-buffer-kill)
	 :map ivy-reverse-i-search-map
	 ("C-k" . ivy-reverse-i-search-kill))
  :config (ivy-mode 1))


;; Remember M-x all-the-icons-install-fonts
(use-package doom-modeline
  :init (doom-modeline-mode 1)
  :custom ((doom-modeline-height 3)))

(use-package rg)

(use-package which-key
  :init (which-key-mode)
  :diminish which-key-mode
  :config
  (setq which-key-idle-delay 2))

(use-package magit
  :custom
  (magit-display-buffer-function #'magit-display-buffer-same-window-except-diff-v1))

(use-package cmake-mode)

(use-package projectile
  :diminish projectile-mode
  :config (projectile-mode 1)
  :demand t
  :init
  (setq projectile-keymap-prefix (kbd "C-c p"))
  (setq projectile-switch-project-action #'magit-status))

;; Use case 1:
;; C-c p f -> M-o -> open in another window
;; Use case 2:
;; C-c p s r -> run ripgrep in project and
;;              C-c C-o to make the results buffer persistent
(use-package counsel-projectile
  :config (counsel-projectile-mode)
  :custom (counsel-projectile-switch-project-action #'magit-status))

(use-package lsp-mode
  :commands (lsp lsp-deferred)
  :hook ((c-mode c++-mode python-mode cmake-mode) . lsp)
  :config (setq lsp-enable-on-type-formatting nil)
  :bind (:map lsp-mode-map
	      ([?\M-\t] . completion-at-point)))

(use-package lsp-ui)

(use-package lsp-pyright
  :hook (python-mode . (lambda ()
                          (require 'lsp-pyright)
                          (lsp))))

(use-package realgud)
(use-package realgud-lldb)

(use-package flycheck
  :defer t
  :config
  (setq-default flycheck-disabled-checkers '(emacs-lisp-checkdoc))
  :hook ((lsp-mode sh-mode emacs-lisp-mode) . flycheck-mode))

(use-package company
  :after lsp-mode
  :hook ((lsp-mode org-mode emacs-lisp-mode) . company-mode))

(use-package company-box
  :hook (company-mode . company-box-mode))

(use-package yasnippet
  :hook (lsp-mode . yas-minor-mode))

(use-package avy
  :ensure t
  :bind ("M-s" . avy-goto-char))

(use-package editorconfig
  :ensure t
  :config
  (editorconfig-mode 1))

;; Use-case:
;; C-c C-f for folding/unfolding
;; C-c C-e f for folding/unfolding children
(use-package web-mode
  :init
  (add-to-list 'auto-mode-alist '("\\.xml\\'" . web-mode))
  (add-to-list 'auto-mode-alist '("\\.ewp\\'" . web-mode)))

(require 'org-tempo)

;; For syntax highlight in llvm's .td files
(add-to-list 'load-path "/Users/ioanniss/llvm-project/llvm/utils/emacs")
(require 'tablegen-mode)
(require 'llvm-mode)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(global-linum-mode t)
 '(package-selected-packages
   '(org-contrib company-lsp company-box web-mode editorconfig yasnippet
		 company flycheck realgud-lldb lsp-pyright lsp-ui
		 counsel-projectile cmake-mode magit which-key rg
		 doom-modeline ace-window expand-region dot-mode
		 multiple-cursors pdf-tools doom-themes)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
