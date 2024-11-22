;;设置与主题背景色前景色一样的，启动时就不会白色闪一下
(set-face-attribute 'default nil
                    :background "#212337"
                    :foreground "#1e2030")
;; 设置默认字体（避免窗口初始化时闪烁）
(set-face-attribute 'default nil :font "Monaco-12")
(setq package-enable-at-startup nil);;避免与straight.el冲突
(setq package-quickstart nil)
(setq native-comp-deferred-compilation t);; 原生编译设置，避免加载额外代码
(setq comp-deferred-compilation t);; 推迟编译，Emacs 启动时可以减少一些编译过程，从而加速启动时间，尤其是当你有很多包时。
;; 禁用工具栏、菜单栏和滚动条
(tool-bar-mode -1)
(menu-bar-mode -1)
(scroll-bar-mode -1)
(horizontal-scroll-bar-mode -1)
(blink-cursor-mode 0)

;; 增加垃圾回收的阈值以加速启动
(setq gc-cons-threshold most-positive-fixnum
      gc-cons-percentage 0.6)
(add-hook 'emacs-startup-hook
          (lambda ()
            (setq gc-cons-threshold 800000
                  gc-cons-percentage 0.1)))
