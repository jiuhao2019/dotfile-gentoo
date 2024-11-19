(use-package org
  :commands (org-capture org-agenda)
  :config
  (setq org-enforce-todo-dependencies t)
  (setq org-startup-folded 'content);;默认折叠所有标题
  (setq org-cycle-include-plain-lists 'integrate) ;;将列表视为heading,也可以折叠
  (setq org-image-actual-width nil)
  (setq org-export-preserve-breaks t);;导出时保留原样换行
  (setq org-ellipsis " ▼")
  (setq org-log-done 'time)
  (setq org-log-into-drawer t)
  (setq org-html-validation-link nil)
  (setq epa-file-cache-passphrase-for-symmetric-encryption t);;对称加密时缓存密码，不用每次打开和保存都输入
  (setq org-agenda-start-with-log-mode t)
  (setq org-agenda-files nil);;打开emacs后清除用来agenda的文件,每次手动添加。
  (setq org-todo-keywords
	'((sequence "TODO(t)" "PROCESS(p)" "|" "FINISHED(f@/!)" "DONE(d@/!)")))
  (setq org-tag-alist
	'(("week" . ?1)
	  ("work" . ?2))))
;;
(use-package org-bullets
  :hook (org-mode . org-bullets-mode)
  :custom
  (org-bullets-bullet-list '("◉" "○" "●" "○" "●" "○" "●" "○" "●")))

;;关闭emacs后关闭后台gpg-agent，清除缓存的密码
(add-hook 'kill-emacs-hook (defun personal-kill-gpg-agent ()
                             (shell-command "pkill gpg-agent")))
(add-hook 'org-mode-hook (defun user/org-mode-setup() (org-indent-mode) (variable-pitch-mode 1)))
;;
(provide 'user-org)
