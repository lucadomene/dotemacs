;;; init.el --- personal emacs configuration -*- lexical-binding: t; -*-

;; -----------------------------------------------------------------------------
;; 1. package management
;; -----------------------------------------------------------------------------
(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
(package-initialize)

;; refresh package list if missing
(unless package-archive-contents
  (package-refresh-contents))

;; initialize use-package
(unless (package-installed-p 'use-package)
  (package-install 'use-package))
(require 'use-package)
(setq use-package-always-ensure t)

;; -----------------------------------------------------------------------------
;; 2. ui cleanup & fundamentals
;; -----------------------------------------------------------------------------
;; disable legacy ui elements
(menu-bar-mode -1)
(tool-bar-mode -1)
(scroll-bar-mode -1)
(tooltip-mode -1)

;; aesthetic adjustments
(set-fringe-mode 10)
(setq inhibit-startup-screen t)
(pixel-scroll-precision-mode 1)

;; set default font
(set-face-attribute 'default nil :font "JetBrainsMono Nerd Font" :height 140)

;; -----------------------------------------------------------------------------
;; 3. theme & status bar
;; -----------------------------------------------------------------------------
(use-package nerd-icons)

(use-package doom-themes
  :config
  (setq doom-themes-enable-bold t
        doom-themes-enable-italic t)
  (load-theme 'doom-acario-dark t)
  (doom-themes-visual-bell-config)
  (doom-themes-neotree-config))

(use-package doom-modeline
  :init (doom-modeline-mode 1)
  :custom
  (doom-modeline-height 35)
  (doom-modeline-icon t))

;; -----------------------------------------------------------------------------
;; 4. editor behavior & visuals
;; -----------------------------------------------------------------------------
;; highlight current line and show numbers
(global-hl-line-mode 1)
(global-display-line-numbers-mode 1)

;; disable line numbers in specific modes
(dolist (mode '(eshell-mode-hook
                dashboard-mode-hook
                compilation-mode-hook))
  (add-hook mode (lambda () (display-line-numbers-mode 0))))

(use-package rainbow-delimiters
  :hook (prog-mode . rainbow-delimiters-mode))

;; -----------------------------------------------------------------------------
;; 5. editing enhancements
;; -----------------------------------------------------------------------------
(use-package multiple-cursors
  :bind (("C-S-c C-S-c" . mc/edit-lines)
         ("C->" . mc/mark-next-like-this)
         ("C-<" . mc/mark-previous-like-this)
         ("C-c C-<" . mc/mark-all-like-this)))

;; -----------------------------------------------------------------------------
;; 6. navigation & project management
;; -----------------------------------------------------------------------------
(use-package vertico
  :init
  (vertico-mode))

(use-package recentf
  :ensure nil
  :config
  (recentf-mode 1)
  (setq recentf-max-saved-items 50))

(use-package project
  :ensure nil)

(use-package dashboard
  :init
  (setq initial-buffer-choice (lambda () (get-buffer-create "*dashboard*")))
  :config
  (dashboard-setup-startup-hook)
  (setq dashboard-center-content t
        dashboard-startup-banner 'official
        dashboard-projects-backend 'project-el
        dashboard-display-icons-p t
        dashboard-icon-type 'nerd-icons
        dashboard-items '((recents  . 5)
                          (projects . 5))))

;; -----------------------------------------------------------------------------
;; 7. completion system
;; -----------------------------------------------------------------------------
(use-package corfu
  :custom
  (corfu-auto t)
  (corfu-quit-no-match t)
  :init
  (global-corfu-mode))

(use-package cape
  :config
  (defun my-merge-eglot-with-basics ()
    "Merge lsp suggestions with keywords and buffer words."
    (setq-local completion-at-point-functions
                (list (cape-capf-super
                       #'eglot-completion-at-point
                       #'cape-keyword
                       #'cape-dabbrev
                       #'cape-file))))
  (add-hook 'eglot-managed-mode-hook #'my-merge-eglot-with-basics))

;; -----------------------------------------------------------------------------
;; 8. programming & lsp (eglot)
;; -----------------------------------------------------------------------------
(use-package eglot
  :ensure nil
  :hook ((c-mode . eglot-ensure)
         (c++-mode . eglot-ensure)
         (python-mode . eglot-ensure)
         (cmake-mode . eglot-ensure))
  :bind (:map eglot-mode-map
              ("C-c l r" . eglot-rename)
              ("C-c l f" . eglot-format))
  :config
  (add-to-list 'eglot-server-programs
               '((cmake-mode) . ("neocmakelsp" "stdio"))))

(use-package cmake-mode)

(use-package python
  :ensure nil
  :custom
  (python-indent-offset 4))

;; -----------------------------------------------------------------------------
;; 9. advanced syntax highlighting (tree-sitter - disabled)
;; -----------------------------------------------------------------------------
;; Tree-sitter is currently disabled due to Emacs 30.2 grammar compatibility issues.
(use-package treesit
  :ensure nil
  :config
  (setq-default treesit-font-lock-level 4)
  (setq treesit-extra-load-path (list (expand-file-name "tree-sitter" user-emacs-directory)))
  
  (setq treesit-language-source-alist
        '((c "https://github.com/tree-sitter/tree-sitter-c")
          (cpp "https://github.com/tree-sitter/tree-sitter-cpp")
          (python "https://github.com/tree-sitter/tree-sitter-python")
          (cmake "https://github.com/uyha/tree-sitter-cmake")))

  ;; disabled remapping:
  ;; (setq major-mode-remap-alist
  ;;       '((c-mode . c-ts-mode)
  ;;         (c++-mode . c++-ts-mode)
  ;;         (python-mode . python-ts-mode)
  ;;         (cmake-mode . cmake-ts-mode)))
  )

;; -----------------------------------------------------------------------------
;; 10. custom variables & faces
;; -----------------------------------------------------------------------------
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

;;; init.el ends here
