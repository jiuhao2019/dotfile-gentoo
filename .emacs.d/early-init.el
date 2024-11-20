;;设置与主题背景色前景色一样的，启动时就不会白色闪一下
(set-face-attribute 'default nil
                    :background "#212337"  ; 设置背景色
                    :foreground "#1e2030") ; 设置前景色

(setq package-enable-at-startup nil);;needed by using straight.el

