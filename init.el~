;; -----------------------------------------------------------------------------
;; 1. PACKAGE MANAGEMENT (MELPA)
;; -----------------------------------------------------------------------------
(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
(package-initialize)

;; Fetch package list if we haven't already
(unless package-archive-contents
  (package-refresh-contents))

;; Emacs 29+ has use-package built-in. If you are on an older version, 
;; it will install it automatically here.
(unless (package-installed-p 'use-package)
  (package-install 'use-package))
(require 'use-package)
(setq use-package-always-ensure t) ; Always install packages if missing

;; -----------------------------------------------------------------------------
;; 2. THEME: DOOM ACARIO DARK
;; -----------------------------------------------------------------------------
(use-package doom-themes
  :config
  ;; Global settings (optional)
  (setq doom-themes-enable-bold t    ; if nil, bold is universally disabled
        doom-themes-enable-italic t) ; if nil, italics is universally disabled
  ;; Load the specific theme you requested
  (load-theme 'doom-acario-dark t)
  
  ;; Enable flashing mode-line on errors
  (doom-themes-visual-bell-config)
  ;; Enable custom neotree theme (nerd-icons must be installed!)
  (doom-themes-neotree-config))
  ;; or for treemacs users
  ;; (doom-themes-treemacs-config)
  ;; Corrects (and improves) org-mode's native fontification.
  ;; (doom-themes-org-config))

;; -----------------------------------------------------------------------------
;; 3. AUTO-COMPLETION & UI MODERNIZATION
;; -----------------------------------------------------------------------------
;; Corfu provides a sleek, modern completion popup
(use-package corfu
  :custom
  (corfu-auto t)                 ; Enable auto completion
  (corfu-quit-no-match t)        ; Quit popup when there is no match
  :init
  (global-corfu-mode))

;; Vertico makes the Emacs command/M-x menu much easier to navigate
(use-package vertico
  :init
  (vertico-mode))

;; -----------------------------------------------------------------------------
;; 4. C & PYTHON PROGRAMMING (LSP via Eglot)
;; -----------------------------------------------------------------------------
;; Eglot is built into Emacs 29+. It connects to clangd (C) and pyright (Python).
(use-package eglot
  :ensure nil ; Built-in, no need to download
  :hook ((c-ts-mode . eglot-ensure)
         (c++-ts-mode . eglot-ensure)
         (python-ts-mode . eglot-ensure))
  :config
  ;; Optional: Add keybindings for common LSP actions
  (define-key eglot-mode-map (kbd "C-c l r") 'eglot-rename)
  (define-key eglot-mode-map (kbd "C-c l f") 'eglot-format))

;; Python specific additions
(use-package python
  :ensure nil
  :custom
  (python-indent-offset 4))

;; -----------------------------------------------------------------------------
;; 6. UI CLEANUP & MODERNIZATION
;; -----------------------------------------------------------------------------
;; Disable legacy visual elements to maximize screen real estate
(menu-bar-mode -1)   ; Hides the top text menu (File, Edit, Options, etc.)
(tool-bar-mode -1)   ; Hides the clunky icon tool bar
(scroll-bar-mode -1) ; Hides the traditional scroll bar
(tooltip-mode -1)    ; Disables graphical tooltips (shows them in the bottom area instead)

;; Add a little breathing room (padding) on the left and right edges
(set-fringe-mode 10) 

;; Disable the default Emacs startup screen for a cleaner launch
(setq inhibit-startup-screen t)

;; Smooth scrolling (available in Emacs 29+)
(pixel-scroll-precision-mode 1)

;; -----------------------------------------------------------------------------
;; 7. CUSTOM FONT & SIZE
;; -----------------------------------------------------------------------------
;; Set your custom font and size. 
;; Note: The :height is measured in 1/10ths of a point (e.g., 140 = 14pt, 150 = 15pt).
;; "JetBrains Mono" is a highly recommended modern programming font.
(set-face-attribute 'default nil :font "JetBrainsMono Nerd Font" :height 140)

;; (Optional) Set a fallback font if you prefer Fira Code or Hack
;; (set-face-attribute 'default nil :font "Fira Code" :height 140)

;; -----------------------------------------------------------------------------
;; 8. RECENT FILES & PROJECT MANAGEMENT
;; -----------------------------------------------------------------------------
;; Enable built-in recentf to track your recently opened files
(use-package recentf
  :ensure nil ; Built-in
  :config
  (recentf-mode 1)
  (setq recentf-max-saved-items 50)) ; Keep track of the last 50 files

;; Emacs 29+ has an excellent built-in project manager called project.el.
;; It automatically recognizes any folder with a .git directory as a "project".
(use-package project
  :ensure nil) ; Built-in

;; -----------------------------------------------------------------------------
;; 9. SPACEMACS-STYLE DASHBOARD
;; -----------------------------------------------------------------------------
(use-package dashboard
  :ensure t
  :config
  (dashboard-setup-startup-hook)
  
  ;; Center the content like Spacemacs
  (setq dashboard-center-content t)
  
  ;; Use the official Emacs logo (or point it to a custom image path)
  (setq dashboard-startup-banner 'official)
  
  ;; Tell the dashboard to use the built-in project.el to find projects
  (setq dashboard-projects-backend 'project-el)
  
  ;; Define exactly what sections appear on the greet screen and how many items
  (setq dashboard-items '((recents  . 5)    ; Show 5 recent files
                          (projects . 5)))) ; Show 5 recent projects

  (setq dashboard-display-icons-p t)
  (setq dashboard-icon-type 'nerd-icons)

;; Force Emacs to open the dashboard when it starts up empty
(setq initial-buffer-choice (lambda () (get-buffer-create "*dashboard*")))

;; -----------------------------------------------------------------------------
;; 10. ADVANCED SYNTAX HIGHLIGHTING (Tree-Sitter)
;; -----------------------------------------------------------------------------
(use-package treesit
  :ensure nil ; Built into Emacs 29+
  :config
  ;; 1. Tell Emacs where to find the grammar parsers
  (setq treesit-language-source-alist
        '((c "https://github.com/tree-sitter/tree-sitter-c")
          (cpp "https://github.com/tree-sitter/tree-sitter-cpp")
          (python "https://github.com/tree-sitter/tree-sitter-python")))
  
  ;; 2. Automatically replace older modes with the new Tree-sitter modes
  (setq major-mode-remap-alist
        '((c-mode . c-ts-mode)
          (c++-mode . c++-ts-mode)
          (c-or-c++-mode . c-or-c++-ts-mode)
          (python-mode . python-ts-mode))))

;; -----------------------------------------------------------------------------
;; 12. ICONS
;; -----------------------------------------------------------------------------
(use-package nerd-icons
  :ensure t)

;; -----------------------------------------------------------------------------
;; 13. MODERN STATUS BAR (Doom Modeline)
;; -----------------------------------------------------------------------------
(use-package doom-modeline
  :ensure t
  :init (doom-modeline-mode 1)
  :custom
  (doom-modeline-height 35)      ; Make it a bit taller for breathability
  (doom-modeline-icon t))        ; Enable nerd-icons

;; -----------------------------------------------------------------------------
;; 14. EDITOR VISUALS (Line numbers & Current Line)
;; -----------------------------------------------------------------------------
;; Highlight the current line
(global-hl-line-mode 1)

;; Enable line numbers globally
(global-display-line-numbers-mode 1)

;; ...but disable line numbers in terminal, dashboard, and logs where they just get in the way
(dolist (mode '(eshell-mode-hook
                dashboard-mode-hook
                compilation-mode-hook))
  (add-hook mode (lambda () (display-line-numbers-mode 0))))

;; -----------------------------------------------------------------------------
;; 15. RAINBOW DELIMITERS
;; -----------------------------------------------------------------------------
(use-package rainbow-delimiters
  :ensure t
  ;; Enable it strictly for programming modes (prog-mode)
  :hook (prog-mode . rainbow-delimiters-mode))

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages nil))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
