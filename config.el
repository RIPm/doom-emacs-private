;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!


;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets.
(setq user-full-name "RIP"
      user-mail-address "junming.lu@ur.com.cn")

;; Doom exposes five (optional) variables for controlling fonts in Doom. Here
;; are the three important ones:
;;
;; + `doom-font'
;; + `doom-variable-pitch-font'
;; + `doom-big-font' -- used for `doom-big-font-mode'; use this for
;;   presentations or streaming.
;;
;; They all accept either a font-spec, font string ("Input Mono-12"), or xlfd
;; font string. You generally only need these two:
;; (setq doom-font (font-spec :family "monospace" :size 12 :weight 'semi-light)
;;       doom-variable-pitch-font (font-spec :family "sans" :size 13))

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:

;; (setq doom-theme 'doom-tomorrow-night)
(load-theme 'doom-tomorrow-night t)
(setq doom-font (font-spec :family "Hack" :size 14 :weight 'light))
(add-to-list 'default-frame-alist '(inhibit-double-buffering . t))

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!  (setq org-directory
;; "~/org/")
(setq org-directory "~/Notes/roam_notes/")
;; (add-to-list 'org-agenda-files "~/Notes/roam_notes/")
(setq org-roam-directory "~/Notes/roam_notes/")
(setq org-roam-dailies-directory "journal/")
(setq org-roam-db-location "~/Notes/roam_notes/.cache/org-roam.db")
(setq org-agenda-files (directory-files-recursively "~/Notes/roam_notes/" "\\.org$"))
;; set deft root
(after! deft
  (setq deft-directory "~/Notes/roam_notes"))

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type nil)
(add-to-list 'initial-frame-alist '(fullscreen . fullboth))

;; Here are some additional functions/macros that could help you configure Doom:
;;
;; - `load!' for loading external *.el files relative to this one
;; - `use-package!' for configuring packages
;; - `after!' for running code after a package has loaded
;; - `add-load-path!' for adding directories to the `load-path', relative to
;;   this file. Emacs searches the `load-path' when you load packages with
;;   `require' or `use-package'.
;; - `map!' for binding new keys
;;
;; To get information about any of these functions/macros, move the cursor over
;; the highlighted symbol at press 'K' (non-evil users must press 'C-c c k').
;; This will open documentation for it, including demos of how they are used.
;;
;; You can also try 'gd' (or 'C-c c d') to jump to their definition and see how
;; they are implemented.
;;; :completion ivy
(after! ivy
  ;; I prefer search matching to be ordered; it's more precise
  (add-to-list 'ivy-re-builders-alist '(counsel-projectile-find-file . ivy--regex-plus))
  (setq ivy-magic-slash-non-match-action 'ivy-magic-slash-non-match-cd-selected))

;; disabled lsp code actions
(after! lsp-ui
  (setq lsp-ui-sideline-show-code-actions nil))
(setq +format-with-lsp nil)

;;; :editor evil
;; Focus new window after splitting
(setq evil-split-window-below t
      evil-vsplit-window-right t)

(general-evil-define-key '(normal visual) 'vterm-mode-map
  "p" 'vterm-yank
  :prefix ","
  "s" '(:ignore t :which-key "screen cmd")
  "s e" 'vterm-extra-read-and-send
  "s c" 'vterm-clear)

(defun wd/switch-with-treemacs()
  (interactive)
  (require 'treemacs)
  (if (not (eq (treemacs-current-visibility) `visible))
      (+treemacs/toggle)
    (if (eq (treemacs-get-local-window) (get-buffer-window))
        (other-window -1)
      (select-window (treemacs-get-local-window)))))

(global-set-key (kbd "M-0") 'wd/switch-with-treemacs)

;; utf-8
;;(set-terminal-coding-system 'utf-8)
;; (modify-coding-system-alist 'process "*" 'utf-8)
;; (setq default-process-coding-system '(utf-8 . utf-8))
;; (setq prefer-coding-system 'utf-8)
;; (add-to-list 'process-coding-system-alist '("rg" utf-8 . gbk))

(after! org-roam
  (setq org-roam-db-update-method 'immediate)
  (setq org-roam-graph-viewer "/Applications/Google Chrome.app/Contents/MacOS/Google Chrome"))

(setq org-roam-dailies-capture-templates
      '(("d" "default" entry "* %<%I:%M %p>: %?"
         :if-new (file+head "%<%Y-%m-%d>.org" "#+title: %<%Y-%m-%d>\n"))))

(add-to-list 'load-path "/usr/local/share/emacs/site-lisp/mu4e")
(after! mu4e
  (setq mu4e-update-interval 60)
  (setq mu4e-headers-buffer-name "*mu4e-headers*")
  (setq +mu4e-compose-org-msg-toggle-next nil)
  (set-email-account! "mailbox"
  '((mu4e-sent-folder       . "/mailbox/Sent Mail")
    (mu4e-drafts-folder     . "/mailbox/Drafts")
    (mu4e-trash-folder      . "/mailbox/Trash")
    (mu4e-refile-folder     . "/mailbox/All Mail")
    (smtpmail-smtp-user     . "junming.lu@ur.com.cn")
    (mu4e-compose-signature . "---\nYours truly\nThe Baz"))
  t)
  (setq mu4e-context-policy 'ask-if-none
      mu4e-compose-context-policy 'always-ask))

(use-package! lsp-volar)

(use-package! org-super-agenda
  :after org-agenda
  :init
  (setq org-agenda-skip-scheduled-if-done t
      org-agenda-skip-deadline-if-done t
      org-agenda-include-deadlines t
      org-agenda-block-separator nil
      org-agenda-compact-blocks t
      org-agenda-start-day nil ;; i.e. today
      org-agenda-span 1
      org-agenda-start-on-weekday nil)
  (setq org-agenda-custom-commands
        '(("c" "Super view"
           ((agenda "" ((org-agenda-span 'day)
                        (org-super-agenda-groups
                         '((:name "Today"
                                  :time-grid t
                                  :date today
                                  :todo "STRT"
                                  :scheduled today
                                  :order 1)))))
            (alltodo "" ((org-agenda-overriding-header "")
                         (org-super-agenda-groups
                          '((:log t)
                            (:name "To refile"
                                   :file-path "refile\\.org")
                            (:name "Next to do"
                                   :todo "NEXT"
                                   :order 1)
                            (:name "Important"
                                   :priority "A"
                                   :order 6)
                            (:name "Scheduled Soon"
                                   :todo "IDEA"
                                   :scheduled future
                                   :order 8)
                            (:name "Tasks"
                                   :file-path "journal/")
                            (:name "Due Today"
                                   :deadline today
                                   :order 2)
                            (:name "Overdue"
                                   :deadline past
                                   :order 7)
                            (:discard (:not (:todo "TODO")))))))))))
  :config
  (org-super-agenda-mode))
;; (use-package! rime
;;   :custom
;;   (rime-inline-ascii-trigger 'shift-r)
;;   (default-input-method "rime")
;;   (rime-emacs-module-header-root "/usr/local/Caskroom/emacs/27.2-2/Emacs.app/Contents/Resources/include/")
;;   (rime-librime-root "~/.doom.d/librime/dist")
;;   (rime-show-candidate 'popup)
;;   :init
;;   (global-set-key (kbd "C-\'") 'toggle-input-method)

;;   :config
;;   (setq rime-user-data-dir "~/Library/Rime")
;;   (setq rime-cursor "˰")
;;   (setq mode-line-mule-info '((:eval (rime-lighter))))
;;   ;; (define-key rime-active-mode-map (kbd "M-j") 'rime-inline-ascii)
;;   )

(use-package! sis
  ;; :hook
  ;; enable the /follow context/ and /inline region/ mode for specific buffers
  ;; (((text-mode prog-mode) . sis-context-mode)
  ;;  ((text-mode prog-mode) . sis-inline-mode))

  :config
  ;; For MacOS
  ;; (sis-ism-lazyman-config nil "rime" 'native)
  (sis-ism-lazyman-config "com.apple.keylayout.ABC" "im.rime.inputmethod.Squirrel.Rime")
  ;; enable the /cursor color/ mode
  (sis-global-cursor-color-mode t)
  ;; enable the /respect/ mode
  (sis-global-respect-mode t)
  ;; enable the /context/ mode for all buffers
  (sis-global-context-mode t)
  ;; enable the /inline english/ mode for all buffers
  (sis-global-inline-mode t)
  )

(use-package! copilot
  :hook (prog-mode . copilot-mode)
  :bind (:map copilot-completion-map
              ("<tab>" . 'copilot-accept-completion)
              ("TAB" . 'copilot-accept-completion)
              ("C-TAB" . 'copilot-accept-completion-by-word)
              ("C-<tab>" . 'copilot-accept-completion-by-word)))

(require 'ace-window)
