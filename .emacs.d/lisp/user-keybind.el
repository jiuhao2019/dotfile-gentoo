(use-package hydra :straight t)
;; 
(defhydra hydra-bookmark (:hint nil )
  "
[_s_] set    [_d_] delete
[_j_] jump   [_l_] list-cur-bookmark-file
[_w_] save   [_f_] switch/create-bookmark-file
[_r_] rename ^^
"
  ("s"   bookmark-set nil :color blue)
  ("j"   bookmark-jump nil :color blue)
  ("w"   bookmark-save nil :color blue)
  ("r"   bookmark-rename nil :color blue)
  ("f"   bmkp-switch-bookmark-file-create nil :color blue)
  ("l"   bookmark-bmenu-list nil :color blue)
  ("d"   bookmark-delete nil :color blue))
;;-------------------------------------------------------window
(defhydra hydra-window (:hint nil )
  "
[_h_] go left  [_H_] move to left   [_s_] fork-to-below [_+_] inc height [_=_] balance-win
[_j_] go down  [_J_] move to bottom [_v_] fork-to-right [_-_] dec height ^^
[_l_] go up    [_L_] move to right  [_x_] del-win       [_>_] inc width  ^^
[_k_] go right [_K_] move to top    [_X_] del-other-win [_<_] dec width  ^^
"
  ("h"   evil-window-left)
  ("j"   evil-window-down)
  ("k"   evil-window-up)
  ("l"   evil-window-right)
  ("H"   evil-window-move-far-left)
  ("J"   evil-window-move-very-bottom)
  ("K"   evil-window-move-very-top)
  ("L"   evil-window-move-far-right)
  ("s"   evil-window-split nil :color blue)
  ("v"   evil-window-vsplit nil :color blue)
  ("x"   evil-window-delete)
  ("X"   delete-other-windows)
  ("+"   evil-window-increase-height)
  ("-"   evil-window-decrease-height)
  ("<"   evil-window-decrease-width)
  (">"   evil-window-increase-width)
  ("="   balance-windows))
;;-------------------------------------------------------end window
;;-------------------------------------------------------begin org
;;  org-agenda
(defhydra hydra-org-agenda (:hint nil )
  "
[_s_] schedule-time
[_d_] deadline-time
[_t_] todo
"
  ("s"   org-schedule nil :color blue)
  ("d"   org-deadline nil :color blue)
  ("t"   org-todo nil :color blue))
;;  org-clock
(defhydra hydra-org-clock (:hint nil )
  "
[_i_] clock-in
[_o_] clock-out
[_r_] clock-report
[_t_] insert-timestamps
"
  ("i"   org-clock-in nil :color blue)
  ("o"   org-clock-out nil :color blue)
  ("r"   org-clock-report nil :color blue)
  ("t"   org-timestamp nil :color blue))
;;  plain list
(defhydra hydra-org-plain-list (:hint nil )
  "
[_i_] insert
[_u_] shift-up
[_d_] shift-down
[_-_] style
"
  ("i"   org-insert-todo-heading nil :color blue)
  ("u"   org-shiftmetaup)
  ("-"   org-ctrl-c-minus)
  ("d"   org-shiftmetadown))
;;  table
(defhydra hydra-org-table (:hint nil )
  "
[_c_] create
[_1_] export-spreadsheet
[_2_] export-spreadsheet_ng
"
  ("c"   org-table-create nil :color blue)
  ("1"   org-table-export-to-spreadsheet nil :color blue)
  ("2"   my/table-export nil :color blue))
;;  link
(defhydra hydra-org-link (:hint nil )
  "
[_o_] open
[_t_] display
[_i_] insert-or-edit
"
  ("o"   org-open-at-point nil :color blue)
  ("t"   org-toggle-link-display nil :color blue)
  ("i"   org-insert-link nil :color blue))
;;  block
(defhydra hydra-org-block (:hint nil )
  "
[_i_] insert-block
"
  ("i"   org-insert-structure-template nil :color blue))
(defhydra hydra-org (:hint nil )
  "
[_i_] inline-images [_a_] +agenda     [_t_] +table
[_o_] export-html   [_p_] +plain-list [_l_] +link
[_m_] meta-return   [_b_] +block      ^^
[_g_] tags          [_c_] +clock      ^^
"
  ("i"   org-toggle-inline-images nil :color blue)
  ("o"   org-html-export-to-html nil :color blue)
  ("m"   org-meta-return nil :color blue)
  ("g"   org-set-tags-command nil :color blue)
  ("t"   hydra-org-table/body nil :color blue)
  ("c"   hydra-org-clock/body nil :color blue)
  ("p"   hydra-org-plain-list/body nil :color blue)
  ("l"   hydra-org-link/body nil :color blue)
  ("b"   hydra-org-block/body nil :color blue)
  ("a"   hydra-org-agenda/body nil :color blue))
;;-------------------------------------------------------end org
(defhydra hydra-misc (:hint nil )
  "
  [_h_] hs-fold-all    [_c_] comment [_l_] select-hl-toggle  [_<TAB>_] vimish-fold-toggle 
  [_s_] hs-show-all    [_e_] theme   [_L_] select-hl-clear   [_d_] vimish-fold-del
  [_<TAB>_] hs-tg-hide [_r_] recentf [_k_] symbol-hl-toggle  [_D_] vimish-fold-del-all 
  [_a_] ialign         [_m_] imenu   [_K_] symbol-hl-clear   [_u_] undo-tree  
 "
  ("a"   ialign nil :color blue)
  ("e"   ap/switch-theme)
  ("m"   counsel-imenu nil :color blue )
  ("c"   comment-line :color blue )
  ("u"   undo-tree-visualize nil :color blue)
  ("k"   symbol-overlay-put nil :color blue)
  ("K"   symbol-overlay-remove-all nil :color blue)
  ("l"   hl-highlight-thingatpt-local nil :color blue)
  ("L"   hl-unhighlight-all-local nil :color blue)
  ("h"   hs-hide-all nil :color blue)
  ("s"   hs-show-all nil :color blue)
  ("<TAB>" hs-toggle-hiding :color blue)
  ("v" vimish-fold-toggle nil :color blue)
  ("d"   vimish-fold-delete nil :color blue)
  ("D"   vimish-fold-delete-all nil :color blue)
  ("r"   recentf nil :color blue))
;;
(use-package general :straight t
  :after evil
  :config
  (general-create-definer user/leader-keys
    :keymaps '(normal visual)
    :prefix "SPC")
  (user/leader-keys
    "e" '(dired :which-key "dired")
    "j" '(avy-goto-char-timer :which-key "jump")
    "s" '(rg-menu :which-key "rg")
    "t" '(toggle-truncate-lines :which-key "toggle-truncate")
    "x" '(hydra-misc/body :which-key "+misc")
    "o" '(hydra-org/body :which-key "+org")
    "w" '(hydra-window/body :which-key "+window")
    "m" '(hydra-bookmark/body :which-key "+bookmark")))

(provide 'user-keybind)
