;;
;;------------------------------------------------ivy
(use-package ivy
  :straight t
  :bind (("C-s" . swiper)
         :map ivy-minibuffer-map
         ("TAB" . ivy-alt-done))
  :config
  (ivy-mode 1)
  (setq ivy-use-virtual-buffers t)
  (setq search-default-mode #'char-fold-to-regexp)
  (setq ivy-count-format "(%d/%d) ")
  ;; delete M-x ^
  (with-eval-after-load 'counsel
    (setq ivy-initial-inputs-alist nil)))
;;
;;-----------------------------------------------------------------------------------counsel
(use-package counsel
  :straight t
  :bind (:map minibuffer-local-map
              ("C-r" . 'counsel-minibuffer-history))
  :after ivy
  :init (counsel-mode 1)
  :custom
  (counsel-linux-app-format-function #'counsel-linux-app-format-function-name-only))
;;
;;---------------------ivy-rich
(use-package ivy-rich
  :straight t
  :after (ivy counsel)
  :config
  (ivy-rich-mode 1))
;;
;;---------------------------------------------ivy-prescient
(use-package ivy-prescient
  :straight t
  :after counsel
  :custom
  (ivy-prescient-enable-filtering nil)
  :config
  ;; Uncomment the following line
  ;;to have sorting remembered across sessions!
  (prescient-persist-mode 1)
  (ivy-prescient-mode 1))
;;
(provide 'user-ivy)
;;
