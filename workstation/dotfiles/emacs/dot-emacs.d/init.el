;; Added by Package.el.  This must come before configurations of
;; installed packages.  Don't delete this line.  If you don't want it,
;; just comment it out by adding a semicolon to the start of the line.
;; You may delete these explanatory comments.
(package-initialize)

(require 'package)
(let* ((no-ssl (and (memq system-type '(windows-nt ms-dos))
                    (not (gnutls-available-p))))
       (url (concat (if no-ssl "http" "https") "://melpa.org/packages/")))
    (add-to-list 'package-archives (cons "melpa" url) t))

;; get some ido goodness
(ido-mode 1)
(ido-everywhere 1)
;; in org-mode and magit
(setq org-completion-use-ido t)
(setq magit-completing-read-function 'magit-ido-completing-read)
(setq magit-last-seen-setup-instructions "1.4.0")
;; in M-x
(global-set-key (kbd "M-x") 'smex)
(global-set-key (kbd "M-X") 'smex-major-mode-commands)
;; This is your old M-x.
(global-set-key (kbd "C-c C-c M-x") 'execute-extended-command)
;; keep smex items in the mounted volume
(setq smex-save-file "~/.emacs.d/smex-items")

;; disable auto-save
(setq auto-save-default nil)

;; whitespace and long line highlighting
(require 'whitespace)
(setq whitespace-style '(face trailing lines-tail))
(set-face-attribute 'whitespace-trailing nil
                    :background "#585858")
(set-face-attribute 'whitespace-line nil
                    :background "#585858"
                    :foreground "#808080")
(global-whitespace-mode 1)
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(org-agenda-files (quote ("/host_root/Users/jmille47/org/projects.org"
                            "/host_root/Users/jmille47/org/scheduled.org")))
 '(package-selected-packages
   (quote
    (rjsx-mode js2-mode solidity-mode deft toml-mode haskell-mode yaml-mode ssh-file-modes smex paredit markdown-mode magit ido-ubiquitous go-mode better-defaults))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

(add-to-list 'auto-mode-alist '("\\.js\\'" . rjsx-mode))
(setq js-indent-level 2)
(setq js2-strict-missing-semi-warning nil)
(setq js2-missing-semi-one-line-override t)

;; org mode stuff
(require 'org)
(global-set-key "\C-ca" 'org-agenda)
(setq org-default-notes-file (concat org-directory "/inbox.org"))
(define-key global-map "\C-cc" 'org-capture)

(setq org-refile-targets '(("~/org/projects.org" :maxlevel . 3)
                           ("~/org/someday.org" :level . 1)
                           ("~/org/scheduled.org" :maxlevel . 1)
                           ("~/org/inactive_projects.org" :maxlevel . 1)
                           ("~/org/reference.org" :maxlevel . 1)))

(setq org-todo-keywords
      '((sequence "[ ](t)" "[?](w)" "|" "[X](d)" "[-](c)")))

(setq org-capture-templates
      '(("t" "Todo" entry (file+headline "~/org/inbox.org" "Tasks")
         "* [ ] %?\n %i")))

(define-key global-map "\C-ct"
  (lambda () (interactive) (org-capture nil "t")))

;; Keep auto-backups and auto-saves out of the way
(setq backup-directory-alist
      `((".*" . ,temporary-file-directory)))
(setq auto-save-file-name-transforms
      `((".*" ,temporary-file-directory t)))

;; set the magit key binding
(define-key global-map "\C-xg" 'magit-status)
