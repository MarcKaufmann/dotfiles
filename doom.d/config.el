;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!


;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets.
(setq user-full-name "Marc Kaufmann"
      user-mail-address "marc@trichotomy.xyz")

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
(setq doom-font (font-spec :family "monospace" :size 18))

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
(setq doom-theme 'doom-one)

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq org-directory "~/org/")

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type t)


;; Here are some additional functions/macros that could help you configure Doom:
;;
;; - `load!' for loading external *.el files relative to this one
;; - `use-package' for configuring packages
;; - `after!' for running code after a package has loaded
;; - `add-load-path!' for adding directories to the `load-path', relative to
;;   this file. Emacs searches the `load-path' when you load packages with
;;   `require' or `use-package'.
;; - `map!' for binding new keys
;;
;; To get information about any of these functions/macros, move the cursor over
;; the highlighted symbol at press 'K' (non-evil users must press 'C-c g k').
;; This will open documentation for it, including demos of how they are used.
;;
;; You can also try 'gd' (or 'C-c g d') to jump to their definition and see how
;; they are implemented.
(setq
 evil-escape-key-sequence "jj"
 projectile-project-search-path '("~/Git/kutat/" "~/Git/valni/" "~/Git/"))

(map! "C-;" #'counsel-M-x)

(global-visual-line-mode t)
;; If the global line wrapping is not what I want, do
;; (add-hook! 'racket-mode-hook #'visual-line-mode)

;;;###autoload
(defun +markdown-compile-pandoc-standalone (beg end output-buffer)
  "Compiles markdown with the pandoc program, if available.
Returns its exit code."
  (when (executable-find "pandoc")
    (call-process-region beg end "pandoc" nil output-buffer nil
                         "-f" "markdown"
                         "-t" "html"
                         "--mathjax"
                         "--standalone"
                         "--highlight-style=pygments")))

(add-hook '+markdown-compile-functions #'+markdown-compile-pandoc-standalone)
(setq reftex-default-bibliography '("/home/marc/Git/grand-schemer/latex/references.bib"))

(after! zeal-at-point
  (add-to-list 'zeal-at-point-mode-alist '(racket-mode . "racket")))

(map! :leader
      :desc "Zeal" "z" 'zeal-at-point)

;; Mu4e ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(add-to-list 'load-path "/home/marc/tools/mu4e")

;; TODO: Set up mail queuing for when I am offline.
;; Actually, mbsync is dealing with this essentially, isn't it?
;; Use 'y' to switch from header to message in split view
;; Use 'j' to jump to maildir when in message view
;; C-c C-c: Send message
;; C-c C-d: save draft and leave
;; C-c C-a: attach a file, drag and drop also works!

(after! mu4e

  (setq
   sendmail-program "/usr/bin/msmtp"
   message-send-mail-function #'message-send-mail-with-sendmail
   message-sendmail-extra-arguments '("--read-envelope-from")
   message-sendmail-f-is-evil t

   mu4e-attachment-dir "~/Downloads"

   mu4e-get-mail-command "mbsync -a"
   mu4e-update-interval 3600 ;; Get new email every hour
                                        ;mu4e-change-filenames-when-moving t ;; prevents mbsync from complaining about duplicate UIDs
                                        ;mu4e-index-lazy-check t
                                        ;mu4e-view-use-gnus nil
                                        ;gnus-blocked-images ".*"
   mu4e-bookmarks `((:name "All Inboxes"
                     :key ?i
                     :query ,(string-join '("maildir:/work/inbox"
                                            "maildir:/personal/inbox") " or ")))
   )

  (set-email-account! "work"
                      '((user-full-name              . "Marc Kaufmann")
                        (user-mail-address           . "kaufmannm@ceu.edu")
                        (mu4e-refile-folder          . "/work/archive")
                        (mu4e-sent-folder            . "/work/sent")
                        (mu4e-drafts-folder          . "/work/drafts")
                        (mu4e-trash-folder           . "/work/trash")
                        (mu4e-sent-messages-behavior . sent))
                      nil)

  (set-email-account! "personal"
                      '((user-full-name              . "Marc Kaufmann")
                        (user-mail-address           . "marc@trichotomy.xyz")
                        (mu4e-refile-folder          . "/personal/archive")
                        (mu4e-sent-folder            . "/personal/sent")
                        (mu4e-drafts-folder          . "/personal/drafts")
                        (mu4e-trash-folder           . "/personal/trash")
                        (mu4e-sent-messages-behavior . sent))
                      t)

  )

;;; For SICM

(defun mechanics ()
  (interactive)
  (setenv "MITSCHEME_BAND" "mechanics.com")
  (setenv "MITSCHEME_HEAP_SIZE" "100000")
  (run-scheme
   "/usr/local/bin/mit-scheme --library /usr/local/lib/mit-scheme-x86-64/"))

;;; Scribble

(use-package! scribble-mode
  :mode "\\.scrbl\\'")
