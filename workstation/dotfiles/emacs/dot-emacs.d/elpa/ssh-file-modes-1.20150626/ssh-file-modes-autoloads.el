;;; ssh-file-modes-autoloads.el --- automatically extracted autoloads
;;
;;; Code:


;;;### (autoloads (ssh-known-hosts-mode ssh-authorized-keys-mode)
;;;;;;  "ssh-file-modes" "ssh-file-modes.el" (21992 31147 0 0))
;;; Generated autoloads from ssh-file-modes.el

(autoload 'ssh-authorized-keys-mode "ssh-file-modes" "\
Major mode for ssh authorized_keys files.

\(fn)" t nil)

(add-to-list 'auto-mode-alist '(".ssh/authorized_keys2?\\'" . ssh-authorized-keys-mode))

(autoload 'ssh-known-hosts-mode "ssh-file-modes" "\
Major mode for ssh known_hosts files.

\(fn)" t nil)

(add-to-list 'auto-mode-alist '(".ssh/known_hosts\\'" . ssh-known-hosts-mode))

(add-to-list 'auto-mode-alist '("ssh_known_hosts\\'" . ssh-known-hosts-mode))

;;;***

;;;### (autoloads nil nil ("ssh-file-modes-pkg.el") (21992 31147
;;;;;;  665743 888000))

;;;***

(provide 'ssh-file-modes-autoloads)
;; Local Variables:
;; version-control: never
;; no-byte-compile: t
;; no-update-autoloads: t
;; coding: utf-8
;; End:
;;; ssh-file-modes-autoloads.el ends here
