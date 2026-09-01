;; Global keys  -*- lexical-binding: t; -*-
(global-set-key (kbd "<f5>") 'revert-buffer)
(global-set-key (kbd "M-/") 'delete-horizontal-space)
(global-set-key (kbd "C-c b") 'backward-sexp)
(global-set-key (kbd "C-c f") 'forward-sexp)
(global-set-key (kbd "C-c C-f") 'forward-whitespace)
(global-set-key (kbd "C-c C-0") 'browse-url-at-point)


;; When the <> keys are not accessible by the left hand
; (global-set-key (kbd "M-z") 'beginning-of-buffer)
; (global-set-key (kbd "M-Z") 'end-of-buffer)

(setq enable-remote-dir-locals t)
(with-eval-after-load 'tramp
  (add-to-list 'tramp-remote-path 'tramp-own-remote-path))

;; When on mac
(setq mac-right-option-modifier 'none)

;; Global settings
(global-display-line-numbers-mode 1)
(setq linum-format " %d ")

;; Disable auto-files
(setq make-backup-files nil)
(setq auto-save-default nil)
(setq create-lockfiles nil)

;; sounds
(setq ring-bell-function t)
;; (setq org-clock-sound "~/cheatsheets/hal_9000.wav")
(setq org-clock-sound "~/cheatsheets/holy_grail_music.wav")
;; (setq org-clock-sound "~/cheatsheets/bird.wav")
;; (setq org-clock-sound "~/cheatsheets/chewy_roar.wav")

;; Disable byte compilation warnings
(setq byte-compile-warnings nil)

;; Do not open new window when doing an ediff
(setq ediff-window-setup-function 'ediff-setup-windows-plain)

;; If emacs is built with svg support, else use 'dvipng
;; (setq org-preview-latex-default-process 'dvisvg)

;; my agenda files
;; (setq org-agenda-files (directory-files-recursively "/Users/ioanniss/cheatsheets" "\\.org$"))

;; Customize org's latex output
(setq org-latex-default-class "article")
(setq org-latex-prefer-user-labels t)
(setq org-export-with-date t)
(setq org-export-with-toc 2)
(setq org-export-with-author t)
(setq org-export-with-email t)
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
(setq package-archives '(("jcs-elpa" . "https://jcs-emacs.github.io/jcs-elpa/packages/")
			 ("melpa" . "https://melpa.org/packages/")
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

(use-package ob-async)

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

(setq org-latex-inputenc-alist '(("utf8" . "utf8x")))

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

;; Save clock history across emacs sessions
(setq org-clock-persist 'history)
(org-clock-persistence-insinuate)

;; Make math formulas readable
(plist-put org-format-latex-options :scale 2)

(use-package verb
    :config (define-key org-mode-map (kbd "C-c C-r") verb-command-map))

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

(use-package git-timemachine)

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
  :hook ((c-mode c++-mode python-mode cmake-mode tex-mode latex-mode LaTex-mode) . lsp)
  :config
  (setq lsp-enable-on-type-formatting nil)
  (setq lsp-enable-file-watchers nil) ;; avoids issues over TRAMP
  :bind (:map lsp-mode-map
	      ([?\M-\t] . completion-at-point)))

(use-package lsp-ui)


(use-package lsp-pyright
  :ensure t
  :custom (lsp-pyright-langserver-command "pyright") ;; or basedpyright
  :hook (python-mode . (lambda ()
                          (require 'lsp-pyright)
                          (lsp))))  ; or lsp-deferred

;; (use-package realgud)
;; (use-package realgud-lldb)

(use-package flycheck
  :defer t
  :config
  (setq-default flycheck-disabled-checkers '(emacs-lisp-checkdoc))
  :hook ((lsp-mode sh-mode emacs-lisp-mode) . flycheck-mode))

(use-package company
  :after lsp-mode
  :hook ((lsp-mode org-mode emacs-lisp-mode) . company-mode)
  :config
  (setq lsp-completion-provider :capf))

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

(use-package auctex)

(use-package auctex
  :ensure t
  :config
  (setq TeX-auto-save t)
  (setq TeX-parse-self t)
  (setq-default TeX-master nil)
  (add-hook 'LaTeX-mode-hook 'visual-line-mode)
  (add-hook 'LaTeX-mode-hook 'flyspell-mode)
  (add-hook 'LaTeX-mode-hook 'LaTeX-math-mode)
  ;; Specify default PDF viewer
  ;; (setq TeX-view-program-selection '((output-pdf "PDF Viewer")))
  ;; (setq TeX-view-program-list '(("PDF Viewer" "open %o")))
  )

;; Configure Elfeed
(use-package elfeed
  :custom
  (elfeed-db-directory
   (expand-file-name "elfeed" user-emacs-directory))
  (elfeed-show-entry-switch 'display-buffer)
  :bind
  ("C-c w e" . elfeed))

(setq elfeed-feeds
      '("https://www.jeremykun.com/index.xml"
	"https://clehaxze.tw/atom.xml"
	"https://discourse.llvm.org/c/mlir/31.rss"
	"https://www.youtube.com/feeds/videos.xml?channel_id=UCIwQ8uOeRFgOEvBLYc3kc3g" ; Onur Mutlu Lectures
	"https://yorickpeterse.com/feed.xml"
	"https://mariusbancila.ro/blog/feed/"
	"https://tomhazledine.com/feed.xml"
	"https://www.michaelpj.com/blog/feed.xml"
	"https://matklad.github.io/feed.xml"
	"https://myhsu.xyz/index.xml"
	))

;; Use-case:
;; C-c C-f for folding/unfolding
;; C-c C-e f for folding/unfolding children
(use-package web-mode
  :init
  (add-to-list 'auto-mode-alist '("\\.xml\\'" . web-mode))
  (add-to-list 'auto-mode-alist '("\\.ewp\\'" . web-mode)))

(require 'org-tempo)

;; For syntax highlight in llvm's .ll & .td files
(when (file-exists-p "/Users/ioanniss/llvm-project/llvm/utils/emacs")
  (add-to-list 'load-path "/Users/ioanniss/llvm-project/llvm/utils/emacs")
  (require 'tablegen-mode)
  (require 'llvm-mode))

;; For quickly renaming mlir identifiers
(defun rename-mlir-var ()
  "Rename MLIR var following the pattern %[-a-zA-Z$._0-9]*."
  (interactive)
  (let ((mlir-id-regexp "%[-a-zA-Z$._0-9]+"))
    ;; Search backward and forward for the identifier under point
    (save-excursion
      (when (re-search-backward mlir-id-regexp (line-beginning-position) t)
        (let* ((old-name (match-string 0))
               (new-name (read-string (format "Rename %s to: " old-name))))
          (query-replace old-name new-name))))))

(defun my-mlir-mode-keybindings ()
  "Set up keybindings specific to mlir-mode."
  (define-key mlir-mode-map (kbd "C-c r") 'rename-mlir-var))

;; For syntax highlight in .mlir and for LSP support
(when (file-exists-p "/Users/ioanniss/llvm-project/mlir/utils/emacs")
  (add-to-list 'load-path "/Users/ioanniss/llvm-project/mlir/utils/emacs")
  (require 'mlir-mode)
  (require 'mlir-lsp-client)
  (setq lsp-mlir-server-executable "/Users/ioanniss/llvm-project/build/bin/mlir-lsp-server")
  (add-hook 'mlir-mode-hook #'lsp)
  (add-hook 'mlir-mode-hook 'my-mlir-mode-keybindings)
  (lsp-mlir-setup))

(use-package vhdl-ext
  :after vhdl-mode
  :hook (vhdl-mode . vhdl-ext-mode)
  :config
  (vhdl-ext-mode-setup)
  (vhdl-ext-lsp-set-server 've-rust-hdl))

(use-package chatgpt-shell
  :ensure t
  :config
  (setq chatgpt-shell-render-latex t)
  (add-to-list 'chatgpt-shell-system-prompts '("phd" . "
You assist a PhD student in computer architecture.
His research interests include compiler technologies, especially MLIR, and how code generation maps efficiently to emerging AI/ML hardware.
He codes in C, C++, and Python, using Apple Silicon hardware with Emacs, terminal, and occasionally PyCharm/CLion.
He TA courses in operating systems, computer architecture, and digital design.
He enjoys etymology and speaks Greek (native), English (near-native), and is learning Swedish.
Prefer casual, concise answers with simple examples, and no elaboration unless asked.
You may call him dude, as he is a big fun of the big Lebowski.
Heck, you may pretend that you are the Big Lebowski, as if he was a master in all arts related to his studies.
"))
  (add-to-list 'chatgpt-shell-system-prompts '("coco" . "
You assist a PhD student in computer architecture.
His research interests include compiler technologies, especially MLIR, and how code generation maps efficiently to emerging AI/ML hardware.
He's currently working with AMD/Xilinx's AIE2 architecture.
He has a Ryzen AI MAX+ 395 XDNA 2 NPU (AIE2 architecture),
which consists of an 8-column 2D array of tiles: 4 rows of compute tiles (AI Engines), 1 row of shared memory tiles and 1 row of shim (interface) tiles.

Here are some architectural details:
- The compute tiles have a local scratchpad memory (64KB), DMA engines, and a VLIW able to perform 512 int8 to int32 MACs per cycle.
- The shared memory tiles come with 512 KB of memory arranged in eight physical banks and 6x64bit DMA channels in either direction.
- The shim tiles have no memory, and are for routing/interface, with 2 DMA channels in either direction.
- The platform has a 256 GB/s main memory bandwidth.
- The architecture uses circuit-switched flows for point-to-point connections and packet-switched flows for more complex routing.
- Data movement is explicit and managed via DMA buffer descriptors that support multi-dimensional strided transfers.
"))
  (add-to-list 'chatgpt-shell-system-prompts '("eda322" . "You are a Teaching Assistant for a Digital Design course at Chalmers University of Technology.
Your goal is to handle student email inquiries regarding strict lab scheduling and grading policies.
Maintain a professional, firm, and concise tone. Offer wishes for a speedy recovery when sickness is mentioned. Do not offer exceptions unless specifically instructed below.

Context & Rules:
1. Group Structure: Students work in pairs (Group ID required).
2. Bonus Points:
   a. Awarded ONLY for demos completed within the designated deadline AND during the group's specific assigned slot.
   b. If a student cannot attend the assigned slot, the other partner MUST present alone to secure the bonus point for the group.
3. Scheduling & Attendance:
   a. Strict Adherence: Students must attend their assigned slots.
   b. No Slot Hopping: Students are prohibited from attending or presenting in slots assigned to other groups.
   c. Makeup: If a slot is missed, they can attend Office Hours or wait for their next assigned slot (for passing grade only, no bonus).
4. Exceptions:
   a. Slot changes are REJECTED by default.
   b. Exceptions are granted ONLY with attached documentation of unavoidable conflicts (e.g. collision with another exam).
   c. In case of sickness, do not ask for a certificate. However, rule 1b applies, unless both of them are sick, the non-sick member must present on time to secure the bonus point.
      The sick group member will be examined during the next slot or during office hours.
      If they mention that both of them are sick, then yes you can postpone the deadline to the next slot.

Instructions for Replies:
- If a student asks to change slots due to preference: *Reject.* Cite fairness and resource constraints.
- If a student asks to attend another group's slot: *Reject.* Direct them to Office Hours.
- If a group claims one member is absent: *Instruct* the remaining member to present alone during the assigned slot to keep the bonus eligibility.
- If a student asks about presenting late: *Confirm* it is allowed for a passing grade (until the final deadline), but clarify that the **bonus point is forfeited**.
"))
  (add-to-list 'chatgpt-shell-system-prompts '("workshop" .
  "You assist a research team in computer architecture and compilation.  
   Refine text specifically for publication at The Eleventh Annual Workshop on the LLVM Compiler Infrastructure in HPC:  
   - Replace vague terms with precise technical vocabulary  
   - Break complex sentences while retaining technical accuracy  
   - Ensure LLVM/HPC terminology consistency  
   - Convert passive to active voice where appropriate  
   - Transform bullet points and lists into concise, flowing paragraphs  
   - Preserve all numerical data and comparisons while improving clarity
   - Format revised text as valid LaTeX code, preserving original LaTeX commands and environments
   NEVER add new concepts, data, or citations.
   Respond with revised text followed by a summary of changes (e.g., Key improvements: removed repetition, clarified X, simplified Y)."))
  :custom
  ()
   ))

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(global-linum-mode t)
 '(package-selected-packages nil)
 '(safe-local-variable-directories '("/Users/ioanniss/MLIR-Pref/"))
 '(safe-local-variable-values
   '((cmake-tab-width . 4) (lsp-pyright-venv-path . /home/paul)
     (lsp-pyright-venv-path . "/home/paul"))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
(put 'downcase-region 'disabled nil)
(put 'upcase-region 'disabled nil)
