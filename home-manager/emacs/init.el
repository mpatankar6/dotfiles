;;; -*- lexical-binding: t; -*-

;; Jinx
(global-jinx-mode 1)
(add-to-list 'jinx-exclude-faces '(prog-mode font-lock-string-face))

;; Evil mode
(setopt evil-want-keybinding nil)
(setopt evil-want-C-u-scroll t)
(setopt evil-undo-system 'undo-redo)
(evil-mode 1)
(evil-collection-init)
(require 'evil-nerd-commenter-operator)
(evil-define-key '(normal visual) 'global (kbd "gc") #'evilnc-comment-operator)

(defun my/highlight-yank (beg end &rest _)
  (pulse-momentary-highlight-region beg end))
(advice-add 'evil-yank :before #'my/highlight-yank)

(evil-set-leader 'normal (kbd "SPC"))
(evil-define-key 'normal 'global
  (kbd "<leader>s") #'jinx-correct)

;; Org mode
(setopt org-directory "~/Documents/org")
(setopt org-agenda-files (list org-directory))
(setopt org-caldav-url "http://xandikos.home.arpa/user/calendars"
	org-caldav-calendar-id "calendar"
	org-caldav-inbox (expand-file-name "calendar.org" org-directory)
	org-caldav-files nil) ; I am choosing to only read for simplicity

(defun my/org-caldav-sync ()
  (let ((org-caldav-show-sync-results nil)
	(warning-suppress-log-types (cons '(files) warning-suppress-log-types)))
    (org-caldav-sync))
  (when (org-caldav-sync-result-filter-errors)
    (org-caldav-display-sync-results)))

(defun my/org-sync ()
  "Pull, commit, and push the org repo to my remote."
  (interactive)
  (my/org-caldav-sync)
  (let ((default-directory (expand-file-name org-directory))
	(shell-file-name "/bin/sh"))
    (shell-command (concat "echo calendar.org > .gitignore && "
			   "git add -A && "
			   "(git diff --cached --quiet || git commit -m sync) && "
			   "git pull --no-edit; git push -u origin main"))))

(keymap-global-set "C-c s" #'my/org-sync)
(keymap-global-set "C-c a" #'org-agenda)

;; Appearance
(menu-bar-mode -1)
(tool-bar-mode -1)
(scroll-bar-mode -1)

(load-theme 'kanagawa-wave t)

(fido-vertical-mode 1)
(setopt max-mini-window-height 11)

(setopt frame-title-format
	(format "%%b - GNU Emacs %d.%d" emacs-major-version emacs-minor-version))

(add-to-list 'default-frame-alist '(font . "JetBrains Mono-14"))

(setopt display-line-numbers-type 'relative)
(add-hook 'prog-mode-hook #'display-line-numbers-mode)

;; Editor Behavior
(savehist-mode 1)
(global-auto-revert-mode 1)
(which-key-mode 1)
(setopt sentence-end-double-space nil) ; Irrelevant for evil mode I think
(setopt make-backup-files nil)
(setopt auto-save-default nil)
(setopt custom-file (make-temp-file "emacs-custom"))

(keymap-global-set "C-S-v" #'yank)
