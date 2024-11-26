;;
;;----------------------------------------------------------------------------lsp-mode
(use-package lsp-mode
  :straight t
  :init
  (setq lsp-file-watch-threshold 500)
  (setq lsp-clients-clangd-executable "ccls"
	lsp-clients-clangd-args nil)
  :hook (lsp-mode . lsp-enable-which-key-integration) ; which-key integration
  :commands (lsp lsp-deferred)
  :config
  (setq lsp-completion-provider :none) ;; 阻止 lsp 重新设置 company-backend 而覆盖我们 yasnippet 的设置
  (setq lsp-headerline-breadcrumb-enable t)) 
;;
;;----------------------------------------------------------------------------------------lsp-ui
(use-package lsp-ui
  :straight t
  :config
  (define-key lsp-ui-mode-map [remap xref-find-definitions] #'lsp-ui-peek-find-definitions)
  (define-key lsp-ui-mode-map [remap xref-find-references] #'lsp-ui-peek-find-references)
  (setq lsp-ui-doc-position 'top))
;;
;;---------------------------------------------------------------------------------ccls
;;系统也需要安装 sudo emerge --ask dev-util/ccls
(use-package ccls
  :straight t
  :after lsp-mode
  :config
  (setq ccls-executable "/usr/bin/ccls"))
;;
;;--------------------lsp-ivy
(use-package lsp-ivy
  :straight t
  :after (lsp-mode))
;;
;;-------------------------------------------------------------------------------company
(use-package company
  :straight t
  :config
  (global-company-mode)
  (setq company-minimum-prefix-length 1) ; 只需敲 1 个字母就开始进行自动补全
  (setq company-tooltip-align-annotations t)
  (setq company-idle-delay 0.0)
  (setq company-show-numbers nil) ;; 给选项编号 (按快捷键 M-1、M-2 等等来进行选择).
  (setq company-selection-wrap-around nil)
  (setq company-transformers '(company-sort-by-occurrence))) ; 根据选择的频率进行排序
;;
;;------------------------------------------------------------------------------------yasnippet
(use-package yasnippet
  :straight t
  :hook (prog-mode . yas-minor-mode)
  :config
  (yas-reload-all)
  ;; add company-yasnippet to company-backends
  (defun company-mode/backend-with-yas (backend)
    (if (and (listp backend) (member 'company-yasnippet backend))
        backend
      (append (if (consp backend) backend (list backend))
	      '(:with company-yasnippet))))
  (setq company-backends (mapcar #'company-mode/backend-with-yas company-backends))
  ;; unbind <TAB> completion
  (define-key yas-minor-mode-map [(tab)]        nil)
  (define-key yas-minor-mode-map (kbd "TAB")    nil)
  (define-key yas-minor-mode-map (kbd "<tab>")  nil))
;;
;;--------------------------------yasnippet-snippets
(use-package yasnippet-snippets
  :straight t
  :after yasnippet)
;;
(provide 'user-lsp)
;;
