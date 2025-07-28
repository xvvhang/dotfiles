(setq make-backup-files nil)
(setq auto-save-default nil)
(setq crate-lockfiles nil)

(menu-bar-mode -1)
(setq inhibit-startup-screen t)
(setq initial-scratch-message nil)

(setq-default cursor-type 'bar)
(blink-cursor-mode -1)
(global-display-line-numbers-mode t)
(global-visual-line-mode t)

(column-number-mode t)

(xterm-mouse-mode 1)
(global-set-key [mouse-4] (lambda () (interactive) (scroll-down 1)))
(global-set-key [mouse-5] (lambda () (interactive) (scroll-up 1)))
(global-set-key (kbd "<wheel-up>") (lambda () (interactive) (scroll-down 1)))
(global-set-key (kbd "<wheel-down>") (lambda () (interactive) (scroll-up 1)))

(require 'package)
(setq package-archives
      '(("melpa" . "https://melpa.org/packages/")
        ("gnu" . "https://elpa.gnu.org/packages/")))

(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))

(require 'use-package)
(setq use-package-always-ensure t)

(use-package doom-themes
             :ensure t
             :config
             (load-theme 'doom-tokyo-night t))
(use-package doom-modeline
             :init
             (doom-modeline-mode 1)
             :config
             (setq doom-modeline-percent-position nil)
             (doom-modeline-def-modeline 'my-simple-modeline
                                         '(buffer-info)
                                         '(matches selection-info buffer-position))
             (doom-modeline-set-modeline 'my-simple-modeline 'default))
(use-package which-key
             :config
             (which-key-mode))
(use-package helpful
             :bind
             (("C-h f" . helpful-callable)
              ("C-h v" . helpful-variable)
              ("C-h k" . helpful-key)
              ("C-h x" . helpful-command)))
(use-package vertico
             :init
             (vertico-mode))
(use-package orderless
             :init
             (setq completion-styles '(orderless basic)
                   completion-category-defaults nil
                   completion-category-overrides '((file (styles . (partial-completion))))))
(use-package marginalia
             :after vertico
             :init
             (marginalia-mode))
(use-package consult
             :bind
             (("C-s" . consult-line)
              ("C-x b" . consult-buffer)
              ("M-y" . consult-yank-pop)))

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
