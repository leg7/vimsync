;;--------- leg7 emacs config for emacs 29

;;------ UI ------

(setq default-frame-alist '((font . "monospace-10")))
;;(menu-bar-mode -1)
(tool-bar-mode -1)
(scroll-bar-mode -1)
(fringe-mode 0)
(global-hl-line-mode)
(setq use-file-dialog nil)

(global-display-line-numbers-mode)
(setq display-line-numbers-type 'relative)

;; Buffer/Tab Lines
(tab-bar-mode) ;; Map tab-next and tab-previous
(setq tab-bar-show 1)
(global-tab-line-mode) ;; Map previous-buffer, next-buffer, ido-switch-buffer

;; Modeline
(setq display-time-default-load-average nil)
(column-number-mode)

;; Highlight trailing spaces and column 80+
(global-whitespace-mode)
(setq whitespace-style '(face lines-tail otrailing
			      indentation indentation::tabs indentation::space))

;;------ Behaviour ------

(global-unset-key (kbd "C-z"))

(setq inhibit-startup-screen 1)
(setq ring-bell-function 'ignore)
(setq uniquify-buffer-name-style 'forward)

(filesets-init)
(savehist-mode)
(recentf-mode)
(save-place-mode)
(global-auto-revert-mode)
(global-subword-mode)

;; Autocomplete
(fido-mode)
(require 'ido)
(ido-mode 1)
(ido-everywhere)
(setq ido-enable-flex-matching t
      ido-enable-regexp t)

(setq backup-directory-alist '(("." . "~/.local/share/emacs/backups/"))
      delete-old-versions t
      version-control t
      kept-new-versions 9
      kept-old-versions 9)

(auto-save-mode) ;; See M-x recover-file or M-x recover-session
(setq auto-save-interval 20
      auto-save-timeout 3
      auto-save-no-message t
      kill-buffer-delete-auto-save-files t
      auto-save-file-name-transforms
      '((".*" "~/.local/share/emacs/auto-saves/" t))
      auto-save-list-file-prefix "~/.local/share/emacs/auto-save-list/")

;; Modes
(setq c-default-style '((java-mode   . "java")
			(awk-mode    . "awk")
			(python-mode . "python")
			(other       . "linux")))

(add-hook 'text-mode-hook 'flyspell-mode)

;;----------- Packages --------------

(require 'package)
(add-to-list 'package-archives
	     '("melpa" . "https://melpa.org/packages/") t)
(or (file-exists-p package-user-dir) (package-refresh-contents))

(unless (package-installed-p 'use-package)
  (package-install 'use-package))

;; (setq package-list '(use-package
;; 		     dracula-theme
;; 		     rainbow-mode
;; 		     dimmer
;; 		     ido-vertical-mode ; maybe will be built-in by v29
;; 		     smex
;; 		     company
;; 		     eglot ; will be built-in by v29
;; 		     flycheck-guile
;; 		     evil
;; 		     evil-commentary
;; 		     evil-surround
;; 		     evil-matchit
;; 		     evil-lion
;; 		     evil-snipe
;; 		     evil-anzu
;; 		     evil-goggles
;; 		     evil-easymotion
;; 		     evil-exchange
;; 		     evil-collection
;; 		     evil-args
;; 		     diminish))

;; (dolist (package package-list)
;;   (unless (package-installed-p package)
;;     (package-install package)))

(require 'use-package)
(require 'use-package-ensure)
(setq use-package-always-ensure t)

(use-package dracula-theme
  :config (load-theme 'dracula t))

(use-package diminish
  :hook (prog-mode . (lambda() (diminish 'hs-minor-mode)))
  :config
    (diminish 'global-whitespace-mode)
    (diminish 'abbrev-mode)
    (diminish 'subword-mode)
    (diminish 'eldoc-mode))

(use-package rainbow-mode
  :diminish
  :hook prog-mode)

(use-package dimmer
  :config
  (dimmer-mode)
  (setq dimmer-fraction 0.25))

(use-package ido-vertical-mode
  :config (ido-vertical-mode))

(use-package smex
  :bind
  (("M-x" . 'smex)
   ("M-X" . 'smex-major-mode-commands)
   ("C-c C-c M-x" . 'execute-extended-command)))

(use-package company
  :diminish
  :hook prog-mode
  :bind ("TAB" . 'company-complete-common)
  :config
  (setq company-selection-wrap-around t)
  (setq company-idle-delay
	(lambda() (if (company-in-string-or-comment) nil 0.3))))

(use-package eglot
  :hook (prog-mode . eglot-ensure))

(use-package evil
  :after evil-collection
  :hook (prog-mode . hs-minor-mode) ; for folding
  :config (evil-mode))

(use-package evil-collection
  :diminish evil-collection-unimpaired-mode
  :init (setq evil-overriding-maps nil
	      evil-want-keybinding nil)
  :config (evil-collection-init))

(use-package evil-commentary
  :after evil
  :diminish
  :config (evil-commentary-mode))

(use-package evil-surround
  :after evil
  :config (global-evil-surround-mode))

(use-package evil-matchit
  :after evil
  :config (global-evil-matchit-mode))

(use-package evil-lion
  :after evil
  :config (evil-lion-mode))

(use-package evil-snipe
  :after evil
  :diminish evil-snipe-local-mode
  :config (evil-snipe-mode)
  (evil-snipe-override-mode))

(use-package anzu
  :after evil
  :diminish
  :config (global-anzu-mode))

(use-package evil-goggles
  :after evil
  :diminish
  :config (evil-goggles-mode)
	  (setq evil-goggles-pulse t)
	  (evil-goggles-use-diff-faces))

(use-package evil-easymotion
  :after evil
  :config (evilem-default-keybindings "SPC"))

(use-package evil-exchange
  :after evil
  :config (evil-exchange-install))

(use-package evil-args
  :after evil
  :config ;; idk how to do this with :bind
  (define-key evil-inner-text-objects-map "a" 'evil-inner-arg)
  (define-key evil-outer-text-objects-map "a" 'evil-outer-arg)
  (define-key evil-normal-state-map "L" 'evil-forward-arg)
  (define-key evil-normal-state-map "H" 'evil-backward-arg)
  (define-key evil-motion-state-map "L" 'evil-forward-arg)
  (define-key evil-motion-state-map "H" 'evil-backward-arg)
  (define-key evil-normal-state-map "K" 'evil-jump-out-args))

;; Cleanup custom variables stuff
(setq custom-file (locate-user-emacs-file "custom-variables.el"))
(load custom-file 'noerror 'nomessage)
