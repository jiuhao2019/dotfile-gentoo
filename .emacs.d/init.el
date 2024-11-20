;;------------------------------------------------------proxy
(setq url-proxy-services
      '(("http" . "127.0.0.1:7890")
        ("https" . "127.0.0.1:7890")))
;;------------------------------------------------------staight.el
(setq comp-deferred-compilation t);; 推迟编译，Emacs 启动时可以减少一些编译过程，从而加速启动时间，尤其是当你有很多包时。
(setq straight-use-package-by-default t)
(setq straight-emacsmirror-use-mirror t);;straight优先用社区提供的git仓库镜像源

(defvar bootstrap-version)
(let ((bootstrap-file
       (expand-file-name
        "straight/repos/straight.el/bootstrap.el"
        (or (bound-and-true-p straight-base-dir)
            user-emacs-directory)))
      (bootstrap-version 7))
  (unless (file-exists-p bootstrap-file)
    (with-current-buffer
        (url-retrieve-synchronously
         "https://radian-software.github.io/straight.el/install.el"
         'silent 'inhibit-cookies)
      (goto-char (point-max))
      (eval-print-last-sexp)))
  (load bootstrap-file nil 'nomessage))

(straight-use-package 'use-package)

(setq custom-file (expand-file-name "custom.el" user-emacs-directory))

;;---------------------------------------------------------Language Environment
(set-language-environment "UTF-8")
;;---------------------------------------------------------System Coding
(prefer-coding-system 'utf-8)
(set-default-coding-systems 'utf-8)
(set-terminal-coding-system 'utf-8)
(set-keyboard-coding-system 'utf-8)
(setq bookmark-save-flag 1);;自动保存bookmark，内置插件
(add-hook 'prog-mode-hook #'hs-minor-mode);;折叠块(注释，大括号)，内置插件
;;------------------------------------------------------------------------------------------------font
(set-face-attribute 'default nil :family "FiraCode Nerd Font Mono" :height 133)
(set-fontset-font t 'unicode (font-spec :family "FiraCode Nerd Font Mono" :size 15) nil 'prepend)
(set-fontset-font t 'emoji (font-spec :family "Noto Color Emoji" :size 14) nil 'prepend)
(set-fontset-font t 'symbol (font-spec :family "source-han-sans" :size 15) nil 'prepend)
;;(set-fontset-font t 'symbol (font-spec :family "wqy-microhei" :size 15) nil 'prepend)
;;-------------------------------------------------------------------------------------------------window-gui
;; Turn off mouse interface early in startup to avoid momentary display
(when window-system
  (menu-bar-mode -1) ;;disables menu bar
  (tool-bar-mode -1) ;;disables toolbar
  (scroll-bar-mode -1) ;;disables scroll bar
  (tooltip-mode -1) ;;disables help in a pop-up window
  (set-fringe-mode 10)          
  (column-number-mode -1)     ;不显示列号
  (global-eldoc-mode -1))      ;不在modeline显示光标处代码相关信息
(setq initial-scratch-message "")
(setq inhibit-startup-message t)        ; 禁用启动消息
(setq inhibit-startup-screen t)         ; 禁用启动界面
(setq inhibit-startup-echo-area-message t) ; 禁用 echo 区的提示信息
(setq initial-scratch-message nil)      ; 清空 *scratch* 缓冲区的默认消息
(setq initial-buffer-choice t)
(setq inhibit-default-init t)  ; 禁止加载默认初始化文件
(setq-default message-log-max nil) ; 禁止记录启动信息到 *Messages*
(setq garbage-collection-messages nil)  ; 禁用 GC 信息输出
(setq-default frame-title-format "") ; 移除窗口标题中的初始化信息
(setq gc-cons-threshold most-positive-fixnum) ;; 只在空闲时进行 GC ，最大程度避免 GC 停顿导致的卡顿
;; 从子进程一次读取的最大字节数，默认是 4K ，对于使用 JSON 通信的 LSP 协议来说，太小了
;; 调大这个值可以减少系统调用次数
(setq read-process-output-max (* 1024 1024)) ;; 1Mb
(setq warning-minimum-level :error)  ;; 只显示错误，忽略警告
(setopt
 use-file-dialog nil
 use-dialog-box nil
 use-short-answers t
 read-process-output-max #x100
 create-lockfiles nil
 recenter-redisplay nil
 next-screen-context-lines 1
 inhibit-compacting-font-caches t
 frame-resize-pixelwise t
 inhibit-quit nil
 fast-but-imprecise-scrolling t
 scroll-preserve-screen-position 'always
 auto-save-list-file-name nil
 history-length 1000
 history-delete-duplicates t
 bidi-display-reordering nil
 read-buffer-completion-ignore-case t
 completion-ignore-case t
 delete-by-moving-to-trash t
 visible-bell t
 minibuffer-prompt-properties '(read-only t cursor-intangible t face minibuffer-prompt)
 redisplay-skip-fontification-on-input t
 cursor-in-non-selected-windows nil)
;;----------------------------------------------------------------------------------自动备份
;;put auto-backup-file all to one folder
(defvar --backup-directory (concat user-emacs-directory "backups"))
(if (not (file-exists-p --backup-directory))
    (make-directory --backup-directory t))
(setq backup-directory-alist `(("." . ,--backup-directory)))
(setq make-backup-files t               ; backup of a file the first time it is saved.
      backup-by-copying nil             ; 默认重命名方式备份较复制方式更好
      version-control t                 ; version numbers for backup files
      delete-old-versions t             ; delete excess backup files silently
      delete-by-moving-to-trash t
      kept-old-versions 5               ; oldest versions to keep when a new numbered backup is made (default: 2)
      KEPT-NEW-VERSIONS 5               ; NEWEST VERSIONS TO KEEP WHEN A NEW NUMBERED BACKUP IS MADE (DEfault: 2)
      auto-save-default t               ; auto-save every buffer that visits a file
      auto-save-timeout 30              ; 每x秒自动保存
      auto-save-interval 30)            ; 每输入x个字符自动保存
;;---------------------------------------------------------------------------theme
(use-package doom-themes
  :straight t
  :config
  (load-theme 'doom-moonlight t)              ;; 加载 doom-moonlight 主题
  (doom-themes-visual-bell-config)            ;; 视觉铃声
  (doom-themes-org-config)                    ;; org-mode 配色增强
  (setq doom-themes-enable-bold t             ;; 启用粗体
        doom-themes-enable-italic t))         ;; 启用斜体
;;---------------------------------------------------------------------------modeline
(use-package doom-modeline
  :straight t
  :ensure t
  :init (doom-modeline-mode 1)
  :custom
  (doom-modeline-height 15)
  (doom-modeline-icon t)                         ;; 启用图标
  (doom-modeline-major-mode-icon t)              ;; 显示主模式图标
  (doom-modeline-minor-modes nil)                ;; 隐藏次模式信息
  (doom-modeline-buffer-file-name-style 'truncate-upto-root) ;; 文件路径样式
  (doom-modeline-lsp t)                          ;; 显示 LSP 状态
  (doom-modeline-github t)                       ;; 显示 GitHub 状态
  (doom-modeline-env-version t))                 ;; 显示当前环境版本
;;---------------------------------------------------------------------------配置内容很多的插件放在独立文件里
(add-to-list 'load-path (expand-file-name "lisp" user-emacs-directory))
(setq evil-want-C-u-scroll t)
(require 'user-evil)
(require 'user-ivy)
(require 'user-func)
(require 'user-org)
(require 'user-lsp)
;;----------------------------------------------------------------------------font-ligature
(use-package ligature
 :straight t)
;; 为所有编程模式启用 ligatures
(ligature-set-ligatures 'prog-mode
                        '("==" "===" "!=" "!=="
                          "->" "=>" "<-" "<="
                          ">=" "<->" "&&" "||" "!!"
                          "**" "***" "++" "--" "<<" ">>"
                          "::" ":::" "===" "=/="))
(add-hook 'prog-mode-hook #'ligature-mode) ; 仅在编程模式中启用
;;-----------------------------------------------------------------------------all-the-icons
;;M-x all-the-icons-install-fonts
(use-package all-the-icons)
(use-package all-the-icons-dired
  :requires all-the-icons
  :hook (dired-mode . all-the-icons-dired-mode))
;;----------------------------------------------------------------------------折叠块,vimish-fold,可以选中再折叠
(use-package vimish-fold :straight t
  :hook (prog-mode . vimish-fold-mode))
;;----------------------------------------------------------------------------使能加密,内置插件
(require 'epa-file)
(epa-file-enable)
(setq epa-file-encrypt-to '("jiuhao")) ; 将 <your-key-id> 替换为您的 GPG 公钥 ID
(setq epa-file-select-keys nil) ; 如果您想在加密时不手动选择密钥
(setq epa-file-cache-passphrase-for-symmetric-encryption t) ; 缓存对称加密的密码
;;----------------------------------------------------------------------------让用户输入的密码不会因内存不足而换出到磁盘
(use-package pinentry :straight t
  :config
  (setq epa-pinentry-mode 'loopback)
  (pinentry-start))
;;-----------------------------------------------------------------------------undo-tree
(use-package undo-tree :straight t
  :config (global-undo-tree-mode)
  :custom (undo-tree-visualizer-diff t)
  (undo-tree-history-directory-alist '(("." . "~/undo-emacs")))
  (undo-tree-visualizer-timestamps t))
;;------------------------------------------------------------------------------recentf,内置插件
(require 'recentf)
(recentf-mode 1)
;; 设置最大保存的文件数
(setq recentf-max-saved-items 100)
;; 忽略某些文件和目录
(setq recentf-exclude
      '("/tmp/" "/ssh:" "/sudo:" "\\.gz$" "\\.zip$" "\\.tar$"))
;; 保存 recentf 列表到指定文件
(setq recentf-save-file "~/.emacs.d/recentf")
;;-------------------------------------------------------------------------------文件夹浏览
(require 'dired)
(setq dired-dwim-target t)
(setq dired-listing-switches "-alGhv --group-directories-first")
(setq dired-recursive-copies 'always)
(setq dired-recursive-deletes 'always)
(setq dired-kill-when-opening-new-dired-buffer t)
(add-hook 'dired-mode-hook 'dired-hide-details-mode)
;;--------------------------------------------------------------------------------拼音输入
(use-package pyim 
 :straight t)
(use-package pyim-basedict 
 :straight t)
(require 'pyim-cregexp-utils)
;; 使用 popup
(use-package popon 
 :straight t)
(setq pyim-page-tooltip 'popon)
;; 加载 basedict 拼音词库。
(pyim-basedict-enable)
;; 将 Emacs 默认输入法设置为 pyim.
(setq default-input-method "pyim")
(global-set-key (kbd "C-\\") 'toggle-input-method)
;; 显示 5 个候选词。
(setq pyim-page-length 5)
;; 设置 pyim 默认使用的输入法策略。
(pyim-default-scheme 'quanpin)
;;----------------------------------------------------------------------elisp indent
;; (先光标放在一个模块里的首括号上,然后C-c C-q自动缩进elisp)
(use-package aggressive-indent 
  :straight t
  :hook ( emacs-lisp-mode . aggressive-indent-mode ))
;;----------------------------------------------------------------------格式化代码
(use-package format-all 
  :straight t
  :commands format-all-mode
  :hook (prog-mode . format-all-mode)
  :config
  (setq format-all-ensure-formatter 'keep-point)
  (setq-default format-all-formatters
                '(("C"     (astyle "--mode=c"))
                  ("Shell" (shfmt "-i" "4" "-ci")))))
;;--------------------------------------------------------------------方便跳转，系统需要安装global
(use-package ggtags 
  :straight t)
(add-hook 'c-mode-common-hook
          (lambda ()
            (when (derived-mode-p 'c-mode 'c++-mode)
              (ggtags-mode 1))))
;;---------------------------------------------------------------------高亮光标处单词，手动高亮单词
;;symbol-overlay
(use-package symbol-overlay 
  :straight t
  :hook (prog-mode . symbol-overlay-mode))
;;-----------------------------------------------------------------------easymotion
(use-package avy 
  :straight t
  :config (setq avy-background t ;; 打关键字时给匹配结果加一个灰背景，更醒目
                avy-all-windows t ;; 搜索所有 window，即所有「可视范围」
                avy-timeout-seconds 0.3)) ;; 「关键字输入完毕」信号的触发时间
;;-----------------------------------------------------------------------rg搜索字符
(use-package rg 
  :straight t)
;; Step 1: 创建或复用用于显示 *rg* 搜索结果的窗口
(defun my-display-rg-results-buffer (buffer _alist)
  "将 *rg* 搜索结果缓冲区固定在右侧结果窗口，始终复用."
  (let ((window (or (get-buffer-window buffer)
                    (display-buffer-in-side-window buffer '((side . right) (slot . -1) (window-width . 0.4))))))
    (select-window window)
    window))
;; Step 2: 创建或复用用于显示文件的窗口（点击 rg 结果时打开的文件）
(defun my-display-rg-file-buffer (buffer _alist)
  "在右侧文件窗口中显示 rg 搜索结果的文件，始终复用."
  (let ((file-window (get-buffer-window "*rg-file-window*")))
    (unless (and file-window (window-live-p file-window))
      ;; 如果文件窗口不存在，则在右侧新建一个窗口，宽度设为 50%
      (setq file-window (split-window (frame-root-window) nil 'right))
      (set-window-dedicated-p file-window nil)  ;; 确保窗口非专用，以便复用
      (set-window-buffer file-window buffer)
      (with-current-buffer buffer
        (rename-buffer "*rg-file-window*")))    ;; 将文件缓冲区命名为 *rg-file-window*
    (select-window file-window)
    file-window))
;; Step 3: 在 display-buffer-alist 中添加规则，确保 *rg* 缓冲区和文件窗口显示逻辑
(add-to-list 'display-buffer-alist
             '("\\*rg\\*"
               my-display-rg-results-buffer
               (reusable-frames . visible)))
(add-to-list 'display-buffer-alist
             '("\\*rg-file-window\\*"
               my-display-rg-file-buffer
               (reusable-frames . visible)))
;; Step 4: 覆盖 compilation-mode 打开文件的默认行为，使其遵循固定的文件窗口规则
(add-hook 'compilation-mode-hook
          (lambda ()
            (setq-local display-buffer-base-action
                        '((my-display-rg-file-buffer)))))
;;--------------------------------------------------------------------自动居中显示窗口内容
(use-package perfect-margin 
  :straight t
  :custom
  (perfect-margin-visible-width 128)
  :config
  (perfect-margin-mode t))
;;--------------------------------------------------------------------dimm inactive window
(use-package dimmer 
  :straight t
  :config 
  (dimmer-mode)
  (setq dimmer-percent 0.5))
;;----------------------------------------------------------------------vdiff
(use-package vdiff 
  :straight t
  :commands (vdiff-buffers vdiff-files)
  :config
  (define-key vdiff-mode-map (kbd "C-c") vdiff-mode-prefix-map))
;;---------------------------------------------------------------------indent-guide
(use-package indent-guide 
  :straight t
  :config
  (setq indent-guide-char "│") ;; 可以用任何你喜欢的字符替换 "|"
  (set-face-background 'indent-guide-face nil) ;; 设置背景色为透明
  (set-face-foreground 'indent-guide-face "#BBBBBB") ;; 设置前景色为灰色（可调）
  :hook (prog-mode . indent-guide-mode))

(defun my-indent-guide-inhibit-comments-and-blocks ()
  "Prevent `indent-guide' from displaying in comment lines and blocks."
  (let ((syntax (syntax-ppss)))
    ;; 检查当前行是否在注释区域中，包括块注释和行注释
    (or (nth 4 syntax)  ;; 如果在单行注释或块注释内
        (nth 3 syntax))))  ;; 如果在字符串内，也要避免影响字符串中的内容
(setq indent-guide-inhibit-for-minor-modes #'my-indent-guide-inhibit-comments-and-blocks)
;;----------------------------------------------------------------------可以选中任意再高亮
(use-package hl-anything 
  :straight t
  :config
  (hl-highlight-mode))
;;-----------------------------------------------------------------------bookmark+
;;可以让不同工程保存到不同书签
(use-package bookmark+
  :straight t
  :config
  (setq bookmark-default-file "~/.emacs.d/user-bookmark/bookmarks"))
;;-----------------------------------------------------------------------sticky scroll,顶部显示函数名
(use-package topsy 
  :straight t
  :hook ((prog-mode) . topsy-mode)
  :config
  (setq topsy-frame-delay 0.1           ;; 更新频率
        topsy-hide-if-invisible t      ;; 在不可见时隐藏
        topsy-steps 5                  ;; 每次滚动的步伐
	topsy-use-sticky-header t
        topsy-prompt "Context:")       ;; 提示文本
  ;; 启用 which-function-mode 来显示当前函数名
  (which-function-mode 1)
  ;; 自定义 header-line，显示当前函数名
  (defun my-topsy-header-line ()
    (setq header-line-format
          '((which-func-mode ("" which-func-format " ")))))
  (add-hook 'prog-mode-hook 'my-topsy-header-line))
;;------------------------------------------------------------------------------ialign
(use-package ialign
  :straight t
  :config
  (setq ialign-auto-align t);; 自动对齐
  (setq ialign-default-align-char "=");; 设置默认对齐符号为 "="
  (setq ialign-tab-width 4);; 设置对齐时的制表符宽度
  (setq ialign-align-chars '("=" ":" ":="));; 设置多符号对齐
  (setq ialign-fix-first-column t));; 启用第一列对齐固定
;;------------------------------------------------------------------------------valign,含中文的表格能对齐
(use-package valign 
  :straight t
  :hook (org-mode . valign-mode)
  :config
  (setq valign-max-table-size 3000)  ;; 表格内容超过3000 字节,自动跳过处理表格
  (setq valign-fancy-bar nil) ;;竖线全高，与文本对齐
  (setq valign-ellipses nil)  ;;省略号显示
  (setq valign-enforce-alignment t)
  (setq valign-resize-separator t)
  (setq valign-autorefresh-rate 1.5))  ;; 刷新

;;---------------------------------------------------------user-keybinding
;;put this at end of plugin
(use-package which-key 
  :straight t
  :config (setq which-key-idle-delay 0))
(which-key-mode)
(require 'user-keybind)

;;--------------------------------------------------------- 这段代码放在最后, 加载 Emacs 自动设置的变量
(load custom-file)
