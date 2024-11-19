
(set-face-attribute 'default nil
                    :background "#212337"  ; 设置背景色
                    :foreground "#1e2030") ; 设置前景色

(scroll-bar-mode -1)        
(tool-bar-mode -1)          
(tooltip-mode -1)          
(set-fringe-mode 10)          
(menu-bar-mode -1)          
(column-number-mode -1)     ;不显示列号
(global-eldoc-mode -1)      ;不在modeline显示光标处代码相关信息

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
(setq read-process-output-max (* 1024 1024)) ;; 1mb
;; 从子进程一次读取的最大字节数，默认是 4K ，对于使用 JSON 通信的 LSP 协议来说，太小了
;; 调大这个值可以减少系统调用次数
