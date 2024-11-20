;;设置与主题背景色前景色一样的，启动时就不会白色闪一下
(set-face-attribute 'default nil
                    :background "#212337"
                    :foreground "#1e2030")
(setq package-enable-at-startup nil);;避免与straight.el冲突

