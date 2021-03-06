(defun my-get-haskell-modules ()
  (with-temp-buffer
    (insert (shell-command-to-string "ghc-pkg dump"))
    (goto-char (point-min))
    (let ((last-point (point-min)))
      (while (search-forward "exposed-modules: " nil t)
        (delete-region last-point (point))
        (setq last-point (- (search-forward "hidden-modules:") 16)))
      (delete-region last-point (point-max)))
    (goto-char (point-min))
    (replace-regexp "[ \n\t]+" " ")
    (split-string (buffer-string))))

(provide 'yas-haskell-funs)
