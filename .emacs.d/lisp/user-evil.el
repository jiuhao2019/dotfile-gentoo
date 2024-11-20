;; Make ESC quit prompts
(global-set-key (kbd "<escape>") 'keyboard-escape-quit)

(use-package evil :straight t
  :init
  (setq evil-want-keybinding nil)
  (setq evil-want-C-u-scroll t)
  (setq evil-want-C-i-jump nil)
  :config
  (evil-mode 1)
  (setq evil-search-wrap nil));; 禁用搜索结果循环

(use-package evil-collection :straight t
  :after evil
  :config
  (evil-collection-init))

(use-package evil-nerd-commenter :straight t)

(use-package evil-surround :straight t
  :init (global-evil-surround-mode))

;;光标在边沿位置移动不再自动跳半个屏幕
(use-package smooth-scrolling :straight t
  :config
  (setq scroll-margin 5
        scroll-conservatively 9999
        scroll-step 1))

;;增强的行内跳转
;;     f F t T                               
;;     w b                                   
(use-package evil-avy :straight t
  :config (evil-avy-mode))                   

(provide 'user-evil)
