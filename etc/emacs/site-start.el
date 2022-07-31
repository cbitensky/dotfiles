(require 'site-gentoo)
(fset 'yes-or-no-p 'y-or-n-p)
(electric-indent-mode 0)
(global-set-key (kbd "TAB") 'self-insert-command)
(tool-bar-mode -1)
(menu-bar-mode -1)
(setq inhibit-startup-screen t)
(setq make-backup-files nil)
(setq create-lockfiles nil)
(setq auto-save-default nil)
(setq echo-keystrokes 0.0001)
;(add-to-list 'default-frame-alist '(font . "cnxt"))
(add-to-list 'custom-theme-load-path "/etc/emacs")
(load-theme 'c t)
;(set-background-color "#2F2F2F")
;(set-foreground-color "#CFCFCF")
(add-to-list 'default-frame-alist '(scroll-bar-width . 7))
;(frame-parameter (make-frame '((border-width . 10))) 'border-width)

(setq frame-title-format "%b")
(global-display-line-numbers-mode)
(setq make-pointer-invisible nil)
(setq-default cursor-type 'bar)

(setq whitespace-style (quote (face spaces tabs newline space-mark tab-mark newline-mark)))
(global-whitespace-mode)
(setq-default whitespace-line '((nil nil)))
(setq-default whitespace-space '((nil (:foreground "gray40"))))
(setq-default whitespace-hspace '((nil (:foreground "gray40"))))
(setq-default whitespace-tab '((nil (:foreground "gray40"))))
(setq-default whitespace-hspace-regexp "\\([     ]+\\)")
(set-face-attribute 'whitespace-space nil :background nil :foreground "gray20")
(set-face-attribute 'whitespace-newline nil :foreground "gray40")
(set-face-attribute 'whitespace-tab nil :background nil :foreground "gray40")
(set-face-attribute 'whitespace-hspace nil :foreground "gray40")

(setq whitespace-display-mappings
	'(
	(space-mark     32 [ 183   ])
	(space-mark    160 [ 126   ])
	(space-mark   8239 [8729   ])
	(space-mark   8201 [8728   ])
	(space-mark   8194 [9675   ])
	(newline-mark   10 [ 182 10])
	(tab-mark        9 [8594  9])
	))

;(set-face-attribute 'fringe nil :foreground "gray50")
(global-unset-key (kbd "<left>"))
(global-unset-key (kbd "<right>"))
(global-unset-key (kbd "<up>"))
(global-unset-key (kbd "<down>"))
(global-unset-key (kbd "<C-left>"))
(global-unset-key (kbd "<C-right>"))
(global-unset-key (kbd "<C-up>"))
(global-unset-key (kbd "<C-down>"))
(global-unset-key (kbd "<M-left>"))
(global-unset-key (kbd "<M-right>"))
(global-unset-key (kbd "<M-up>"))
(global-unset-key (kbd "<M-down>"))
(global-unset-key (kbd "<home>"))
(global-unset-key (kbd "<end>"))
(global-unset-key (kbd "<insert>"))
(global-unset-key (kbd "<deletechar>"))
(global-unset-key (kbd "<prior>"))
(global-unset-key (kbd "<next>"))

(dolist (k '([mouse-1] [down-mouse-1] [drag-mouse-1] [double-mouse-1] [triple-mouse-1]
	[mouse-2] [down-mouse-2] [drag-mouse-2] [double-mouse-2] [triple-mouse-2]
	[mouse-3] [down-mouse-3] [drag-mouse-3] [double-mouse-3] [triple-mouse-3]
	[mouse-4] [down-mouse-4] [drag-mouse-4] [double-mouse-4] [triple-mouse-4]
	[mouse-5] [down-mouse-5] [drag-mouse-5] [double-mouse-5] [triple-mouse-5]))
(global-unset-key k))

(setq-default tab-width 3)
(setq-default indent-tabs-mode t)
(setq backward-delete-char-untabify-method 'hungry)
(setq indent-line-function 'insert-tab)
(setq-default word-wrap t)
(defun display-startup-echo-area-message nil)

(add-hook 'python-mode-hook
	(lambda ()
		(setq tab-width 3)))

(add-hook 'delete-frame-functions
	(lambda (frame)
		(let* ((window (frame-selected-window frame)) (buffer (and window (window-buffer window))))
			(when (and buffer (buffer-file-name buffer))
				(kill-buffer buffer) ) ) ) )


(defun sort-words (reverse beg end)

"Sort words in region alphabetically, in REVERSE if negative.
Prefixed with negative \\[universal-argument], sorts in reverse.

The variable `sort-fold-case' determines whether alphabetic case
affects the sort order.

See `sort-regexp-fields'."
(interactive "*P\nr")
(sort-regexp-fields reverse "\\w+" "\\&" beg end))
